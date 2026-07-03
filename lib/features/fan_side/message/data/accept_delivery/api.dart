import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostAcceptOrderAPI {
  static final PostAcceptOrderAPI _singleton = PostAcceptOrderAPI._internal();
  PostAcceptOrderAPI._internal();
  static PostAcceptOrderAPI get instance => _singleton;

  Future<Map> postFunctionName(Map data, int messageId) async {
    try {
      Response response = await postHttp(
        EndPoints.acceptOrder(messageId),
        data,
      );
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
