import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/model/celebrity_details_model.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetCelebrityDetailsRx extends RxResponseInt {
  final api = GetCelebrityDetailsApi.instance;

  String message = kErrorGeneric;

  GetCelebrityDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchCelebrityDetails({required int id}) async {
    try {
      Map resdata = await api.getCelebrityDetails(id);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    CelebrityDetailsModel celebrityDetailsModel =
        CelebrityDetailsModel.fromJson(data);
    log(celebrityDetailsModel.data!.startPrice.toString());
    dataFetcher.sink.add(celebrityDetailsModel);
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
