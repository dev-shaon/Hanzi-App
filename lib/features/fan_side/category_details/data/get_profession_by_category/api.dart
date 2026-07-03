import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetCategoryByProfessionApi {
  static final GetCategoryByProfessionApi _singleton =
      GetCategoryByProfessionApi._internal();
  GetCategoryByProfessionApi._internal();
  static GetCategoryByProfessionApi get instance => _singleton;

  Future<Map> getCategoryByProfession(int id, {int? page}) async {
    try {
      final params = <String, dynamic>{};
      if (page != null) params['page'] = page;

      Response response = await getHttp(
        EndPoints.categoryByProfession(id),
        queryParameters: params,
      );
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
