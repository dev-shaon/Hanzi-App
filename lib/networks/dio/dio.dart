import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/app_constants.dart';
import '../../helpers/di.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'log.dart';
import 'token_interceptor.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;

  void create() {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE},
    );
    dio = Dio(options)..interceptors.add(Logger());
  }

  void update(String auth) {
    if (kDebugMode) {
      print("Dio update");
    }

    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.AUTHORIZATION: "Bearer $auth",
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options)
      ..interceptors.add(TokenInterceptor())
      ..interceptors.add(Logger());
  }

  void updateLanguage(String countryCode) {
    if (kDebugMode) {
      print("Dio update $countryCode");
    }
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.AUTHORIZATION:
            "Bearer ${appData.read(kKeyAccessToken)} ",
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options)
      ..interceptors.add(TokenInterceptor())
      ..interceptors.add(Logger());
  }
}

Future<Response> postHttp(String path, [dynamic data]) => DioSingleton
    .instance
    .dio
    .post(path, data: data, cancelToken: CancelToken());

Future<Response> putHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.put(path, data: data, cancelToken: CancelToken());

Future<Response> getHttp(
  String path, {
  Map<String, dynamic>? queryParameters,
}) => DioSingleton.instance.dio.get(
  path,
  queryParameters: queryParameters,
  cancelToken: CancelToken(),
);

Future<Response> deleteHttp(String path, [dynamic data]) => DioSingleton
    .instance
    .dio
    .delete(path, data: data, cancelToken: CancelToken());
