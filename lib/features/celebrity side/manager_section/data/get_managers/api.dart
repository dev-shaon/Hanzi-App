import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetManagerListApi {
  static final GetManagerListApi _singleton = GetManagerListApi._internal();
  GetManagerListApi._internal();
  static GetManagerListApi get instance => _singleton;

  Future<Map> getManagersData() async {
    try {
      Response response = await getHttp(EndPoints.managersList());
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