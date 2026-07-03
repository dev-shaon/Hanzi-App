import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostLogoutApi {
  static final PostLogoutApi _singleton = PostLogoutApi._internal();
  PostLogoutApi._internal();
  static PostLogoutApi get instance => _singleton;

  Future<Map> postLogout() async {
    try {
      Response response = await postHttp(EndPoints.logout(), {});
      if (response.statusCode == 200) {
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
