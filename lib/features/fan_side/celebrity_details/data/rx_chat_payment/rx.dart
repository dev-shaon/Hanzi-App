import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostChatPaymentRx extends RxResponseInt {
  final api = PostChatPaymentApi.instance;
  String message = kErrorGeneric;

  PostChatPaymentRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<String?> post({required int celebrityId}) async {
    try {
      Map<String, dynamic> data = {"chat_price": 2.99};
      Map resdata = await api.postChatPayment(celebrityId, data);
      final clientSecret = resdata['data']?['stripe_client_secret'];
      await handleSuccessWithReturn(resdata);
      return clientSecret?.toString();
    } catch (error) {
      await handleErrorWithReturn(error);
      return null;
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