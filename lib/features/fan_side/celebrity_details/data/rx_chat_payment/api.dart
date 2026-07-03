import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostChatPaymentApi {
  static final PostChatPaymentApi _singleton = PostChatPaymentApi._internal();
  PostChatPaymentApi._internal();
  static PostChatPaymentApi get instance => _singleton;

  Future<Map> postChatPayment(int celebrityId, Map data) async {
    try {
      Response response = await postHttp(EndPoints.chatPayment(celebrityId), data);
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