import 'dart:convert';
import 'dart:developer';



import 'package:dio/dio.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/categories_model.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';



final class GetCategoriesApi {
  static final GetCategoriesApi _singleton = GetCategoriesApi._internal();
  GetCategoriesApi._internal();

  static GetCategoriesApi get instance => _singleton;

  Future<CategoriesModel> getCategories() async {
    try {
      Response response = await getHttp(EndPoints.fancategory());
      if (response.statusCode == 200) {
        final data =
            CategoriesModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        log('Error: ${response.statusCode}');
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}