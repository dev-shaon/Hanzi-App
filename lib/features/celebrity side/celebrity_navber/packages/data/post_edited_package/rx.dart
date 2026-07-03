import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/networks/rx_base.dart';
import '../../../../../../constants/app_constants.dart';
import 'api.dart';

final class EditedCelebrityPackageRx extends RxResponseInt {
  final api = EditedCelebrityPackageApi.instance;

  String message = kErrorGeneric;

  EditedCelebrityPackageRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({
    required int id,
    required String mainTitle,
    required String description,

    // package 0
    required String packageId0,
    required String packageName0,
    required String price0,
    required String packageDescription0,
    required String revisionLimit0,
    required String deliveryDays0,
    required String editable0,

    // package 1
    required String packageId1,
    required String packageName1,
    required String price1,
    required String packageDescription1,
    required String revisionLimit1,
    required String deliveryDays1,
    required String editable1,

    // package 2
    required String packageId2,
    required String packageName2,
    required String price2,
    required String packageDescription2,
    required String revisionLimit2,
    required String deliveryDays2,
    required String editable2,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'main_title': mainTitle,
        'description': description,
        'packages[0][id]': packageId0,
        'packages[0][package_name]': packageName0,
        'packages[0][price]': price0,
        'packages[0][description]': packageDescription0,
        'packages[0][revision_limit]': revisionLimit0,
        'packages[0][delivery_days]': deliveryDays0,
        'packages[0][editable]': editable0,
        'packages[1][id]': packageId1,
        'packages[1][package_name]': packageName1,
        'packages[1][price]': price1,
        'packages[1][description]': packageDescription1,
        'packages[1][revision_limit]': revisionLimit1,
        'packages[1][delivery_days]': deliveryDays1,
        'packages[1][editable]': editable1,
        'packages[2][id]': packageId2,
        'packages[2][package_name]': packageName2,
        'packages[2][price]': price2,
        'packages[2][description]': packageDescription2,
        'packages[2][revision_limit]': revisionLimit2,
        'packages[2][delivery_days]': deliveryDays2,
        'packages[2][editable]': editable2,
      };
      Map resdata = await api.postEditedCelebrityPackage(id, data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"].toString() ?? kErrorGeneric;
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
