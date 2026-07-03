import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/model/celebrity_package_model.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetCelebrityPackageRx extends RxResponseInt {
  final api = GetCelebrityPackageApi.instance;

  String message = kErrorGeneric;

  GetCelebrityPackageRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchCelebrityPackageData() async {
    try {
      Map resdata = await api.getCelebrityPackageData();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    CelebrityPackageModel model = CelebrityPackageModel.fromJson(data);
    dataFetcher.sink.add(model);
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
