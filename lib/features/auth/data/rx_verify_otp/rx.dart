import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import 'api.dart';

final class PostVerifyOtpRx extends RxResponseInt {
  final api = PostVerifyOtpApi.instance;

  String message = kErrorGeneric;

  PostVerifyOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({String? otp, String? email}) async {
    try {
      Map<String, dynamic> data = {"otp": otp, "email": email};

      Map resdata = await api.postVerifyOtp(data);
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
    log(error.toString());
    if (error is DioException) {
      String message = error.response?.data["message"].toString() ?? kErrorGeneric;
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
      customToastMessage('Error', message);
    }
    return false;
  }
}
