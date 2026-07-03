import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/wallet_model.dart';
import 'package:tc_mcandy/networks/rx_base.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import 'api.dart';

final class GetWalletRx extends RxResponseInt {
  final api = GetWalletApi.instance;

  String message = kErrorGeneric;

  GetWalletRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchfunctionName() async {
    try {
      Map resdata = await api.getWalletData();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    // Model Mapping Section
    WalletModel res = WalletModel.fromJson(data);
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
