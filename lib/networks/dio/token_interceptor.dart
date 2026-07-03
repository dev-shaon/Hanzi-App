import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';

import 'dio.dart';

final class TokenInterceptor extends Interceptor {
  static bool _isRefreshing = false;
  static final List<_RetryRequest> _pendingRequests = [];
  static int _refreshRetryCount = 0;
  static const int _maxRefreshRetries = 3;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 ||
        err.requestOptions.path == EndPoints.refreshToken() ||
        err.requestOptions.path == EndPoints.login() ||
        err.requestOptions.path == EndPoints.logout() ||
        err.requestOptions.extra['isRetry'] == true) {
      return super.onError(err, handler);
    }

    if (_isRefreshing) {
      _pendingRequests.add(_RetryRequest(err.requestOptions, handler));
      return;
    }

    _isRefreshing = true;
    _refreshRetryCount = 0; // Reset retry count

    try {
      final refreshed = await _refreshTokenWithRetry();

      if (refreshed) {
        final newToken = appData.read(kKeyAccessToken);

        // Update headers on the existing Dio instance without recreating it
        DioSingleton.instance.dio.options.headers[NetworkConstants
                .AUTHORIZATION] =
            "Bearer $newToken";

        // Retry the original request
        final retryResponse = await _retry(err.requestOptions, newToken);
        handler.resolve(retryResponse);

        // Retry all queued requests
        for (final pending in _pendingRequests) {
          try {
            final response = await _retry(pending.options, newToken);
            pending.handler.resolve(response);
          } catch (e) {
            pending.handler.reject(
              DioException(requestOptions: pending.options, error: e),
            );
          }
        }
      } else {
        // Refresh token invalid or couldn't refresh after retries
        handleUnauthorized();
        handler.next(err);
      }
    } catch (e) {
      log('Refresh token failed: $e');
      handleUnauthorized();
      handler.next(err);
    } finally {
      _isRefreshing = false;
      _pendingRequests.clear();
      _refreshRetryCount = 0;
    }
  }

  /// Refresh token with exponential backoff retry
  /// Returns true if token was refreshed successfully
  Future<bool> _refreshTokenWithRetry() async {
    while (_refreshRetryCount < _maxRefreshRetries) {
      try {
        final result = await _refreshToken();
        if (result) {
          _refreshRetryCount = 0;
          return true;
        }

        // Refresh failed, log the attempt
        _refreshRetryCount++;
        if (_refreshRetryCount < _maxRefreshRetries) {
          // Exponential backoff: 500ms, 1s, 2s
          final delayMs = 500 * (1 << (_refreshRetryCount - 1));
          log(
            'Token refresh failed, retrying in ${delayMs}ms (attempt $_refreshRetryCount/$_maxRefreshRetries)',
          );
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      } catch (e) {
        _refreshRetryCount++;
        log(
          'Token refresh exception: $e (attempt $_refreshRetryCount/$_maxRefreshRetries)',
        );

        if (_refreshRetryCount < _maxRefreshRetries) {
          // Exponential backoff for exceptions too
          final delayMs = 500 * (1 << (_refreshRetryCount - 1));
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      }
    }

    // All retry attempts exhausted
    log('Token refresh failed after $_maxRefreshRetries attempts');
    return false;
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = appData.read(kKeyRefreshToken);
      if (refreshToken == null) {
        log('Refresh token not found in storage');
        return false;
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
            NetworkConstants.AUTHORIZATION: "Bearer $refreshToken",
          },
        ),
      );

      final response = await dio.post(EndPoints.refreshToken());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        final newToken = data['token'];
        final newRefreshToken = data['refresh_token'];

        if (newToken != null) {
          appData.write(kKeyAccessToken, newToken);
        }
        if (newRefreshToken != null) {
          appData.write(kKeyRefreshToken, newRefreshToken);
        }

        log('✅ Token refreshed successfully');
        return true;
      }

      log('❌ Refresh token returned unexpected status: ${response.statusCode}');
      return false;
    } on DioException catch (e) {
      // If refresh token endpoint itself returns 401, refresh token is invalid
      if (e.response?.statusCode == 401) {
        log('❌ Refresh token is invalid (401 from server)');
        return false;
      }

      // Network errors should not immediately fail
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        log('⚠️ Network error during token refresh: ${e.type} - Will retry');
        throw Exception('Network error: ${e.type}'); // Throw to trigger retry
      }

      log('❌ Token refresh error: ${e.message}');
      return false;
    } catch (e) {
      log('❌ Unexpected error during token refresh: $e');
      throw Exception('Unexpected error: $e'); // Throw to trigger retry
    }
  }

  Future<Response> _retry(RequestOptions options, String newToken) {
    final opts = Options(
      method: options.method,
      headers: {
        ...options.headers,
        NetworkConstants.AUTHORIZATION: "Bearer $newToken",
      },
      extra: {...options.extra, 'isRetry': true},
    );

    return DioSingleton.instance.dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: opts,
    );
  }
}

class _RetryRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _RetryRequest(this.options, this.handler);
}
