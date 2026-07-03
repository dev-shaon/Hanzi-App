import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/model/celebrity_order_list_model.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetCelebrityOrderRx extends RxResponseInt {
  final api = GetCelebrityOrderApi.instance;
  String message = kErrorGeneric;

  GetCelebrityOrderRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  final Map<String, String> _statusMap = {
    'Pending': 'pending',
    'In-Progress': 'in_progress',
    'Delivered': 'delivered',
    'Completed': 'completed',
    'Rejected': 'rejected',
  };

  Future<bool> fetchCelebrityOrders({String? filter}) async {
    try {
      Map resdata = await api.getCelebrityOrder(
        status: filter != null ? _statusMap[filter] : null,
      );
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    CelebrityOrderListModel res = CelebrityOrderListModel.fromJson(data);
    dataFetcher.sink.add(res);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.signinRoute);
      } else {
        message =
            error.response?.data["message"].toString() ??
            kErrorGeneric;
      }
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
