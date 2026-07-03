import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostDeleteManagerApi {
  static final PostDeleteManagerApi _singleton = PostDeleteManagerApi._internal();
  PostDeleteManagerApi._internal();
  static PostDeleteManagerApi get instance => _singleton;

  Future<Map> post(Map data,int managerId) async {
    try {
      Response response = await deleteHttp(EndPoints.deleteManager(managerId), data);
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