import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostReviewAPI {
  static final PostReviewAPI _singleton = PostReviewAPI._internal();
  PostReviewAPI._internal();
  static PostReviewAPI get instance => _singleton;

  Future<Map> postReview(Map data, int messageId) async {
    try {
      Response response = await postHttp(EndPoints.postReview(messageId), data);
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
