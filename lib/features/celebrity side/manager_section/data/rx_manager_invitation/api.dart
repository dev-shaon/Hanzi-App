import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class PostSendInvitationApi {
  static final PostSendInvitationApi _singleton =
      PostSendInvitationApi._internal();
  PostSendInvitationApi._internal();
  static PostSendInvitationApi get instance => _singleton;

  Future<Map> postSendInvitation(Map data) async {
    try {
      Response response = await postHttp(EndPoints.sendInvitation(), data);
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
