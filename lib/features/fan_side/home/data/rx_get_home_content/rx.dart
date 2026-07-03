import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/fan_side/home/model/home_content_model.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/di.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class GetHomeContentRx extends RxResponseInt {
  final api = GetHomeContentApi.instance;

  String message = kErrorGeneric;

  GetHomeContentRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> getHomeContent() async {
    try {
      Map resdata = await api.getHomeContent();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    HomeContentModel homeContentModel = HomeContentModel.fromJson(data);
    dataFetcher.sink.add(homeContentModel);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        return false;
      }
      if (error.response?.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.signinRoute);
      } else {
        message = error.response?.data?["message"]?.toString() ?? kErrorGeneric;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
