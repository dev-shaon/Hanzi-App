import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class PostUpdateAvatarApi {
  static final PostUpdateAvatarApi _singleton = PostUpdateAvatarApi._internal();
  PostUpdateAvatarApi._internal();
  static PostUpdateAvatarApi get instance => _singleton;

  Future<Map> postUpdateAvatar(FormData data) async {
    try {
      Response response = await postHttp(EndPoints.updateAvatar(), data);
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
