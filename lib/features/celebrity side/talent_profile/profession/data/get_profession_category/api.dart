import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetProfessionCategoryApi {
  static final GetProfessionCategoryApi _singleton = GetProfessionCategoryApi._internal();
  GetProfessionCategoryApi._internal();
  static GetProfessionCategoryApi get instance => _singleton;

  Future<Map> getProfessionCategory() async {
    try {
      Response response = await getHttp(EndPoints.professionCategory());
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