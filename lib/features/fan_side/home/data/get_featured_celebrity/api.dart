import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetFeaturedCelebrityApi {
  static final GetFeaturedCelebrityApi _singleton =
      GetFeaturedCelebrityApi._internal();
  GetFeaturedCelebrityApi._internal();
  static GetFeaturedCelebrityApi get instance => _singleton;

  Future<Map> getFeaturedCelebrityData({int? page}) async {
    try {
      final params = <String, dynamic>{};
      if (page != null) params['page'] = page;

      Response response = await getHttp(
        EndPoints.featuredCelebrity(),
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
