import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostUnFollowApi {
  static final PostUnFollowApi _singleton = PostUnFollowApi._internal();
  PostUnFollowApi._internal();
  static PostUnFollowApi get instance => _singleton;

  Future<Map> postUnFollow(int id) async {
    try {
      Response response = await postHttp(EndPoints.postUnFollow(id));
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
