import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class PostSignUpGetOtpRx extends RxResponseInt {
  final api = PostSignUpGetOtpApi.instance;

  String message = kErrorGeneric;

  PostSignUpGetOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({String? email}) async {
    try {
      Map<String, dynamic> data = {"email": email};

      Map resdata = await api.postOtp(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    await appData.remove(KKeyOtp);

    if (data['data']['otp'] != null) {
      String newOtp = data['data']['otp'].toString();
      await appData.write(KKeyOtp, newOtp);

      customToastMessage(
        'Success',
        data['message'] ?? 'OTP sent to your email',
      );
    } else {
      log("OTP not found in response");
    }
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
        message = error.response?.data?["message"]?.toString() ?? kErrorGeneric;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
