import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetCelebrityOrderApi {
  static final GetCelebrityOrderApi _singleton =
      GetCelebrityOrderApi._internal();
  GetCelebrityOrderApi._internal();
  static GetCelebrityOrderApi get instance => _singleton;

  Future<Map> getCelebrityOrder({String? status}) async {
    try {
      Response response = await getHttp(EndPoints.getOrders(status: status));
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
