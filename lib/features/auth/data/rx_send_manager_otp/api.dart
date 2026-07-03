import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostSendManagerOtpApi {
  static final PostSendManagerOtpApi _singleton =
      PostSendManagerOtpApi._internal();
  PostSendManagerOtpApi._internal();
  static PostSendManagerOtpApi get instance => _singleton;

  Future<Map> postSendManagerOtp(Map data) async {
    try {
      Response response = await postHttp(EndPoints.sendManagerOtp(), data);
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
