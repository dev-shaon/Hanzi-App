import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class GetCelebrityProfileApi {
  static final GetCelebrityProfileApi _singleton =
      GetCelebrityProfileApi._internal();
  GetCelebrityProfileApi._internal();
  static GetCelebrityProfileApi get instance => _singleton;

  Future<Map> getCelebrityProfile() async {
    try {
      Response response = await getHttp(EndPoints.userProfile());
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
