import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';

import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class LogoutRx extends RxResponseInt<Map> {
  LogoutRx({required super.empty, required super.dataFetcher});

  ValueStream get collectionStream => dataFetcher.stream;
  final api = LogoutApi.instance;

  Future<bool> userLogout() async {
    try {
      final data = await api.userLogout();
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        return false;
      }
      message = error.response?.data["message"].toString() ?? kErrorGeneric;
      if (error.type == DioExceptionType.connectionError) {
        return false;
      }
    }
    customToastMessage('Error', message);
    return false;
  }

  @override
  dynamic handleSuccessWithReturn(dynamic data) {
    appData.write(kKeyIsLoggedIn, false);
    dataFetcher.sink.add(data);
    return data;
  }
}
