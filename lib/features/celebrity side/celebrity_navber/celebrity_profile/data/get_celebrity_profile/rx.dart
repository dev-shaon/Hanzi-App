import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_profile/model/celebrity_profile_model.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../constants/app_constants.dart';
import '../../../../../../helpers/di.dart';
import '../../../../../../helpers/navigation_service.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class GetCelebrityProfileRx extends RxResponseInt {
  final api = GetCelebrityProfileApi.instance;

  String message = kErrorGeneric;

  GetCelebrityProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchCelebrityProfile() async {
    try {
      Map resdata = await api.getCelebrityProfile();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    CelebrityProfileModel celebrityProfileModel =
        CelebrityProfileModel.fromJson(data);
    dataFetcher.sink.add(celebrityProfileModel);
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
        message = error.response?.data?["message"]?.toString() ?? kErrorGeneric;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
