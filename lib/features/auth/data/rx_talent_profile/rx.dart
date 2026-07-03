import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class PostTalentProfileRx extends RxResponseInt {
  final api = PostTalentProfileApi.instance;

  String message = kErrorGeneric;

  PostTalentProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({
    String? displayName,
    String? userId,
    String? userName,
    dynamic phoneCode,
    dynamic phoneNumber,
    dynamic dateOfBirth,
    String? socialPlatform,
    String? country,
    String? bio,
  }) async {
    try {
      Map<String, dynamic> data = {
        "display_name": displayName,
        "user_id": userId,
        "username": userName,
        "phone_code": phoneCode,
        "phone": phoneNumber,
        "dob": dateOfBirth,
        "social_platform": socialPlatform,
        "country": country,
        "bio": bio,
      };

      Map resdata = await api.postTalentProfile(data);
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
        message = error.response?.data?["message"]?.toString() ?? kErrorGeneric;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
