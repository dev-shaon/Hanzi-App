import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetAccountConnectApi {
  static final GetAccountConnectApi _singleton = GetAccountConnectApi._internal();
  GetAccountConnectApi._internal();
  static GetAccountConnectApi get instance => _singleton;

  Future<Map> getfunctionNameData() async {
    try {
      Response response = await getHttp(EndPoints.accountConnect());
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