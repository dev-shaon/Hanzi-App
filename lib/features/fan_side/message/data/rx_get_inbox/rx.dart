import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/inbox_response_model.dart';
import 'api.dart';

final class GetInboxMessageRx extends RxResponseInt<InboxResponseModel> {
  final api = GetInboxMessageApi.instance;

  String message = kErrorGeneric;

  GetInboxMessageRx({required super.empty, required super.dataFetcher});

  ValueStream get getInboxStream => dataFetcher.stream;

  Future<bool> getInboxMessage({required int userId}) async {
    try {
      final resdata = await api.getInboxMessage(userId: userId);
      await handleSuccessWithReturn(resdata);
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    log(error.toString());
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
        return false;
      } else {
        message = error.response?.data?["message"]?.toString() ?? kErrorGeneric;
      }
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
