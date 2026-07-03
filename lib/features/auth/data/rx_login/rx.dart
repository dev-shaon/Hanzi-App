import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/helpers/di.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';

final class PostLoginRx extends RxResponseInt {
  final api = PostLoginApi.instance;

  String message = kErrorGeneric;
  String? lastError;
  String? lastPasswordError;

  PostLoginRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({String? email, String? password}) async {
    try {
      Map<String, dynamic> data = {"email": email, "password": password};

      Map resdata = await api.postLogin(data);

      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      appData.write(kKeyAccessToken, data['token']);
      if (data['refresh_token'] != null) {
        appData.write(kKeyRefreshToken, data['refresh_token']);
      }
      appData.write(kKeyIsLoggedIn, true);
      appData.write(kkeyIsManager, false);
      DioSingleton.instance.update(data['token']);
      appData.write(kKeyFCMToken, data["token"]);
      appData.write(kkeyhasPackage, data['data']['has_package']);

      if (data['data'] != null) {
        appData.write(kKeyUserId, data['data']['id'].toString());

        if (data['data']['role'] != null && data['data']['role'].isNotEmpty) {
          String roleId = data['data']['role'].toString();
          appData.write(kkeyUserRole, roleId);
        }
      }

      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) {
    lastError = null;
    lastPasswordError = null;
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
        return false;
      }
      final data = error.response?.data?['data'];
      final emailRaw = data?['email'];
      if (emailRaw is List && emailRaw.isNotEmpty) {
        lastError = emailRaw.first.toString();
      } else if (emailRaw != null) {
        lastError = emailRaw.toString();
      }
      final passwordRaw = data?['password'];
      if (passwordRaw is List && passwordRaw.isNotEmpty) {
        lastPasswordError = passwordRaw.first.toString();
      } else if (passwordRaw != null) {
        lastPasswordError = passwordRaw.toString();
      }
      if (lastError == null && lastPasswordError == null) {
        lastError =
            error.response?.data?['message']?.toString() ?? kErrorGeneric;
      }
    } else {
      lastError = kErrorGeneric;
    }
    return false;
  }
}
