import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetCelebrityByPriceApi {
  static final GetCelebrityByPriceApi _singleton =
      GetCelebrityByPriceApi._internal();
  GetCelebrityByPriceApi._internal();
  static GetCelebrityByPriceApi get instance => _singleton;

  Future<Map> getCelebrityByPriceData({
    required int priceRange,
    int? page,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (page != null) params['page'] = page;

      Response response = await getHttp(
        EndPoints.getCelebrityByPrice(priceRange),
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
