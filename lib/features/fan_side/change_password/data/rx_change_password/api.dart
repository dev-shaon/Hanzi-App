import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostChangePasswordApi {
  static final PostChangePasswordApi _singleton =
      PostChangePasswordApi._internal();
  PostChangePasswordApi._internal();
  static PostChangePasswordApi get instance => _singleton;

  Future<Map> postChangePassword(Map data) async {
    try {
      Response response = await postHttp(EndPoints.changePassword(), data);
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
