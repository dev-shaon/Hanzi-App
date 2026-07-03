import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class GetWalletApi {
  static final GetWalletApi _singleton = GetWalletApi._internal();
  GetWalletApi._internal();
  static GetWalletApi get instance => _singleton;

  Future<Map> getWalletData() async {
    try {
      Response response = await getHttp(EndPoints.getWallet());
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
