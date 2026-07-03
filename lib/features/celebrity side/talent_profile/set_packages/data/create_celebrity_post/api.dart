import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class CelebrityPostApi {
  static final CelebrityPostApi _singleton = CelebrityPostApi._internal();
  CelebrityPostApi._internal();
  static CelebrityPostApi get instance => _singleton;

  Future<Map> postCelebrityPost(FormData data) async { // ✅ FormData নিন
    try {
      Response response = await postHttp(EndPoints.createCelebrityPost(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}