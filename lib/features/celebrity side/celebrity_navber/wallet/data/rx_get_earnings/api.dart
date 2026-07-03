import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class GetEarningsApi {
  static final GetEarningsApi _singleton = GetEarningsApi._internal();
  GetEarningsApi._internal();
  static GetEarningsApi get instance => _singleton;

  Future<Map> getEarnings({String filter = 'all_time'}) async {
    try {
      Response response = await getHttp(EndPoints.getEarnings(filter: filter));
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
