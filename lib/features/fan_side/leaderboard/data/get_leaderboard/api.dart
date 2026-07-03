import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetLeaderBoardApi {
  static final GetLeaderBoardApi _singleton = GetLeaderBoardApi._internal();
  GetLeaderBoardApi._internal();
  static GetLeaderBoardApi get instance => _singleton;

  Future<Map> getLeaderBoardData() async {
    try {
      Response response = await getHttp(EndPoints.getLeaderBoard());
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
