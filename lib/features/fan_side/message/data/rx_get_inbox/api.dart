import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/features/fan_side/message/model/inbox_response_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetInboxMessageApi {
  static final GetInboxMessageApi _singleton = GetInboxMessageApi._internal();
  GetInboxMessageApi._internal();
  static GetInboxMessageApi get instance => _singleton;

  Future<InboxResponseModel> getInboxMessage({required int userId}) async {
    try {
      Response response = await getHttp(EndPoints.conversation(userId));
      if (response.statusCode == 200) {
        InboxResponseModel data = InboxResponseModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}