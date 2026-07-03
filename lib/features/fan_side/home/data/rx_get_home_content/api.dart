import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class GetHomeContentApi {
  static final GetHomeContentApi _singleton = GetHomeContentApi._internal();
  GetHomeContentApi._internal();
  static GetHomeContentApi get instance => _singleton;

  Future<Map> getHomeContent() async {
    try {
      Response response = await getHttp(EndPoints.getHomeContent());
      if (response.statusCode == 200) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
