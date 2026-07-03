import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_edit_profile/api.dart';
import 'package:tc_mcandy/networks/rx_base.dart';

import '../../../../../constants/app_constants.dart';

final class EditProfileRx extends RxResponseInt<Map> {
  EditProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get getCartStream => dataFetcher.stream;
  final api = EditProfileApi.instance;

  Future<bool> editProfile({
    required String name,
    required String phone,
    required String email,

    File? image,
  }) async {
    try {
      final data = await api.editProfile(
        image: image,
        name: name,
        phone: phone,
        email: email,
      );
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
      message = error.response?.data["message"].toString() ?? kErrorGeneric;
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
