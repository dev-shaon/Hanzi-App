import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class SendMessageRx extends RxResponseInt<Map> {
  final api = SendMessageApi.instance;
  String message = kErrorGeneric;

  SendMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> sendMessage({
    required int userId,
    required String message,
    File? file,
    bool? generateKey,
    String? keyCode, 
  }) async {
    try {
      final resdata = await api.sendMessage(
        userId,
        message,
        file: file,
        generateKey: generateKey,
        keyCode: keyCode,
      );
      await handleSuccessWithReturn(resdata);
      return true;
    } catch (error) {
      await handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
      }
      message = error.response?.data["message"].toString() ?? kErrorGeneric;
      if (error.type == DioExceptionType.connectionError) {
        return false;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}