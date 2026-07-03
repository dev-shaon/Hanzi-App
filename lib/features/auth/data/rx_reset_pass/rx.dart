import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostResetPassRx extends RxResponseInt {
  final api = PostResetPassApi.instance;

  PostResetPassRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({
    String? email,
    String? password,
    String? confirmPassword,
    String? token,
  }) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "token": token,
      };

      Map resdata = await api.postResetPass(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
        return false;
      } else {
        message = error.response?.data["message"].toString() ?? kErrorGeneric;
      }
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
