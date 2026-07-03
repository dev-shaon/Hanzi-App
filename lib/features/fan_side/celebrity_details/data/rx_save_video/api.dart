import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostSaveVideoApi {
  static final PostSaveVideoApi _singleton = PostSaveVideoApi._internal();
  PostSaveVideoApi._internal();
  static PostSaveVideoApi get instance => _singleton;

  Future<Map> postSaveVideo(Map data) async {
    try {
      Response response = await postHttp(EndPoints.saveVideo(), data);
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
