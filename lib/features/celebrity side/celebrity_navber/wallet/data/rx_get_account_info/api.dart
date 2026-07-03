import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
final class GetAccountInfoApi {
  static final GetAccountInfoApi _singleton = GetAccountInfoApi._internal();
  GetAccountInfoApi._internal();
  static GetAccountInfoApi get instance => _singleton;

  Future<Map> getAccountInfoData() async {
    try {
      Response response = await getHttp(EndPoints.accountInfo());
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