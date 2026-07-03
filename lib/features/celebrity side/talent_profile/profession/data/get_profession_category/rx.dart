import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/model/profession_category_model/profession_category_model.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetProfessionCategoryRx extends RxResponseInt {
  final api = GetProfessionCategoryApi.instance;

  String message = kErrorGeneric;

  GetProfessionCategoryRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchProfessionCategory() async {
    try {
      Map resdata = await api.getProfessionCategory();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    ProfessionCategoryModel professionCategoryModel =
        ProfessionCategoryModel.fromJson(data);
    dataFetcher.sink.add(professionCategoryModel);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
        return false;
      } else {
        message = error.response?.data["message"].toString() ?? kErrorGeneric;
      }
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
