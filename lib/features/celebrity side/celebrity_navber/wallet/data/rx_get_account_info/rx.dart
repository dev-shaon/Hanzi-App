import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/account_info_model.dart';
import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../constants/app_constants.dart';
import '../../../../../../helpers/all_routes.dart';
import '../../../../../../helpers/di.dart';
import '../../../../../../helpers/navigation_service.dart';
import '../../../../../../networks/rx_base.dart';

import '../../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class GetAccountInfoRx extends RxResponseInt {
  final api = GetAccountInfoApi.instance;

  String message = "Something went wrong";

  GetAccountInfoRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchfunctionName() async {
    try {
      Map resdata = await api.getAccountInfoData();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {

    AccountInfoModel res = AccountInfoModel.fromJson(data);
    dataFetcher.sink.add(res);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.signinRoute);
      } else if (error.response?.statusCode == 404) {
        // Handle 404 as "Not Connected" state
        AccountInfoModel res = AccountInfoModel(
          status: false,
          code: 404,
          data: Data(stripeOnboarded: 0),
        );
        dataFetcher.sink.add(res);
        return true;
      } else {
        message = error.response?.data["message"].toString() ??
            "Something went wrong";
      }
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}