import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/my_order_model.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetMyOrderRx extends RxResponseInt {
  final api = GetMyOrderApi.instance;

  String message = kErrorGeneric;

  GetMyOrderRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchMyOrder() async {
    try {
      Map resdata = await api.getMyOrderData();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    MyOrderModel model = MyOrderModel.fromJson(data);
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
