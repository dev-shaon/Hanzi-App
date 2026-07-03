import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetUserProfileApi {
  static final GetUserProfileApi _singleton = GetUserProfileApi._internal();
  GetUserProfileApi._internal();
  static GetUserProfileApi get instance => _singleton;

  Future<Map> getUserProfileData() async {
    try {
      Response response = await getHttp(EndPoints.userProfile());

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
