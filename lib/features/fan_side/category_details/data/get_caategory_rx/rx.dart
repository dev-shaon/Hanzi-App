// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:rxdart/streams.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/fan_side/category_details/data/get_caategory_rx/api.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/categories_model.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/toast.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';

import '../../../../../../../networks/rx_base.dart';

final class GetCategoriesRx extends RxResponseInt<CategoriesModel> {
  GetCategoriesRx({required super.empty, required super.dataFetcher});

  ValueStream<CategoriesModel> get getCategoriesValue => dataFetcher.stream;

  final api = GetCategoriesApi.instance;

  Future<CategoriesModel?> getCategories() async {
    try {
      final data = await api.getCategories();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  CategoriesModel? handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final response = error.response;

      if (response?.statusCode == 401) {
        /// Token expired or unauthorized — reset app state
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.signinRoute);
      } else {
        ToastUtil.showErrorMessage(message: "");
      }
    } else {
      /// Handle non-Dio errors
      ToastUtil.showErrorMessage(message: "");
    }

    log("ChatData Error: $error");
    dataFetcher.sink.addError(error);

    /// Return null or empty model to avoid crash
    return null;
  }
}
