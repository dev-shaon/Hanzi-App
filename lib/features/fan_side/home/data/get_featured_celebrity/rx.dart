import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/fan_side/home/model/featured_celebrity_model.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/di.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class GetFeaturedCelebrityRx extends RxResponseInt {
  final api = GetFeaturedCelebrityApi.instance;
  String message = kErrorGeneric;

  GetFeaturedCelebrityRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchFeaturedCelebrity({int? page}) async {
    try {
      Map resdata = await api.getFeaturedCelebrityData(page: page);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    // Model Mapping Section
    FeaturedCelebrityModel res = FeaturedCelebrityModel.fromJson(data);
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
