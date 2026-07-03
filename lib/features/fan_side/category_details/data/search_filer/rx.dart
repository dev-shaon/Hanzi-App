import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/search_filter_model.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';

import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetSearchFilterRx extends RxResponseInt {
  final api = GetSearchFilterApi.instance;

  GetSearchFilterRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;
  int _fetchGeneration = 0;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMorePages => _hasMorePages;

  void clear() {
    _currentPage = 1;
    _isLoadingMore = false;
    _hasMorePages = true;
    dataFetcher.sink.add(SearchFilterModel(data: []));
  }

  Future<bool> fetchSearchFilter({
    String? name,
    String? profession,
    int? categoryId,
    String? search,
    String? priceRange,
    String? sortByPrice,
    int? page,
  }) async {
    _currentPage = page ?? 1;
    _hasMorePages = true;
    _isLoadingMore = false;
    _fetchGeneration++;
    try {
      Map resdata = await api.getSearchFilterData(
        name: name,
        profession: profession,
        categoryId: categoryId,
        search: search,
        priceRange: priceRange,
        sortByPrice: sortByPrice,
        page: _currentPage,
      );
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  Future<bool> fetchNextPage({
    String? name,
    String? profession,
    int? categoryId,
    String? search,
    String? priceRange,
    String? sortByPrice,
  }) async {
    if (_isLoadingMore || !_hasMorePages) return false;
    _isLoadingMore = true;
    final nextPage = _currentPage + 1;
    final generation = _fetchGeneration;
    try {
      Map resdata = await api.getSearchFilterData(
        name: name,
        profession: profession,
        categoryId: categoryId,
        search: search,
        priceRange: priceRange,
        sortByPrice: sortByPrice,
        page: nextPage,
      );
      if (generation != _fetchGeneration) {
        _isLoadingMore = false;
        return false;
      }
      return await _handleNextPageSuccess(resdata);
    } catch (error) {
      _isLoadingMore = false;
      return await handleErrorWithReturn(error);
    }
  }

  Future<bool> _handleNextPageSuccess(dynamic data) async {
    SearchFilterModel res = SearchFilterModel.fromJson(data);
    final currentData = dataFetcher.value;
    final existingItems = currentData?.data ?? [];
    final newItems = res.data ?? [];
    final mergedModel = SearchFilterModel(
      status: res.status,
      message: res.message,
      code: res.code,
      data: [...existingItems, ...newItems],
      pagination: res.pagination,
    );
    _currentPage = res.pagination?.currentPage ?? _currentPage + 1;
    _hasMorePages =
        (res.pagination?.currentPage ?? 0) < (res.pagination?.lastPage ?? 0);
    _isLoadingMore = false;
    dataFetcher.sink.add(mergedModel);
    return true;
  }

  @override
  handleSuccessWithReturn(data) async {
    SearchFilterModel res = SearchFilterModel.fromJson(data);
    _currentPage = res.pagination?.currentPage ?? 1;
    _hasMorePages =
        (res.pagination?.currentPage ?? 0) < (res.pagination?.lastPage ?? 0);
    dataFetcher.sink.add(res);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
      } else if (error.response?.statusCode == 404) {
        dataFetcher.sink.add(
          SearchFilterModel(
            status: false,
            data: [],
            message:
                error.response?.data["message"]?.toString() ??
                "No results found",
          ),
        );
      }
    }
    return false;
  }
}
