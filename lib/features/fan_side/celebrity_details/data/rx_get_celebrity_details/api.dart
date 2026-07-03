import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetCelebrityDetailsApi {
  static final GetCelebrityDetailsApi _singleton =
      GetCelebrityDetailsApi._internal();
  GetCelebrityDetailsApi._internal();
  static GetCelebrityDetailsApi get instance => _singleton;

  Future<Map> getCelebrityDetails(dynamic id) async {
    try {
      Response response = await getHttp(EndPoints.getCategoryDetails(id));
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
