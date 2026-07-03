import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/celebrity%20side/manager_section/model/ManagerListModel.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class GetManagerListRx extends RxResponseInt {
  final api = GetManagerListApi.instance;
  String message = kErrorGeneric;

  GetManagerListRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetch() async {
    try {
      Map resdata = await api.getManagersData();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    // Model Mapping Section
    ManagerListModel res = ManagerListModel.fromJson(data);
    dataFetcher.sink.add(res);
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
