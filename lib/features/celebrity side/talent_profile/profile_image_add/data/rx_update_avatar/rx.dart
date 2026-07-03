import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/networks/rx_base.dart';

import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../constants/app_constants.dart';
import 'api.dart';

final class PostUpdateAvatarRx extends RxResponseInt {
  final api = PostUpdateAvatarApi.instance;

  String message = kErrorGeneric;

  PostUpdateAvatarRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({required File avatar}) async {
    try {
      String fileName = avatar.path.split('/').last;
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(avatar.path, filename: fileName),
      });

      Map resdata = await api.postUpdateAvatar(formData);
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
