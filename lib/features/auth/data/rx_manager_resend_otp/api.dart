import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostManagerResendOtpApi {
  static final PostManagerResendOtpApi _singleton =
      PostManagerResendOtpApi._internal();
  PostManagerResendOtpApi._internal();
  static PostManagerResendOtpApi get instance => _singleton;

  Future<Map> postManagerResendOtp(Map data) async {
    try {
      Response response = await postHttp(EndPoints.resendManagerOtp(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
