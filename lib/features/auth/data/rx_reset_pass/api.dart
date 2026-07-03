import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostResetPassApi {
  static final PostResetPassApi _singleton = PostResetPassApi._internal();
  PostResetPassApi._internal();
  static PostResetPassApi get instance => _singleton;

  Future<Map> postResetPass(Map data) async {
    try {
      Response response = await postHttp(EndPoints.resetPassword(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map resData = json.decode(json.encode(response.data));
        return resData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
