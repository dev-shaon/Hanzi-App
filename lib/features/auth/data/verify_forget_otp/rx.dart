// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../networks/rx_base.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import 'api.dart';

final class VerifyForgetPassRx extends RxResponseInt<Map> {
  String? errorMessage;
  String? resendToken;
  final api = VerifyForgetPassApi.instance;

  VerifyForgetPassRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> verifyForgetPass({
    required String email,
    required String otp,
  }) async {
    try {
      final data = await api.verifyForgetPass(email: email, otp: otp);
      handleSuccessWithReturn(data);
      resendToken = data['token'];
      log("Forget Token is ============> $resendToken");
      appData.write(KKeyForgetToken, resendToken);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"].toString() ?? kErrorGeneric;
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
