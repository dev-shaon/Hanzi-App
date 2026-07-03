import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostTalentProfileApi {
  static final PostTalentProfileApi _singleton =
      PostTalentProfileApi._internal();
  PostTalentProfileApi._internal();
  static PostTalentProfileApi get instance => _singleton;

  Future<Map> postTalentProfile(Map data) async {
    try {
      Response response = await postHttp(EndPoints.postTalentProfile(), data);
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
