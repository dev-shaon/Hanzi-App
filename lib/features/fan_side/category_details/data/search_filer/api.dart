import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class GetSearchFilterApi {
  static final GetSearchFilterApi _singleton = GetSearchFilterApi._internal();
  GetSearchFilterApi._internal();
  static GetSearchFilterApi get instance => _singleton;

  Future<Map> getSearchFilterData({
    String? name,
    String? profession,
    int? categoryId,
    String? search,
    String? priceRange,
    String? sortByPrice,
    int? page,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (name != null && name.isNotEmpty) params['name'] = name;
      if (profession != null && profession.isNotEmpty) {
        params['profession'] = profession;
      }
      if (categoryId != null) params['category_id'] = categoryId;
      if (search != null && search.isNotEmpty) {
        params['search'] = search.toLowerCase();
      }
      if (priceRange != null && priceRange.isNotEmpty) {
        params['price_range'] = priceRange;
      }
      if (sortByPrice != null && sortByPrice.isNotEmpty) {
        params['sort_by_price'] = sortByPrice;
      }
      if (page != null) params['page'] = page;

      Response response = await getHttp(
        EndPoints.searchFilter(),
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
