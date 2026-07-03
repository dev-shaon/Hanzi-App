import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostAcceptOrderRx extends RxResponseInt {
  final api = PostAcceptOrderAPI.instance;

  String message = "Something went wrong";

  PostAcceptOrderRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({String? downloadKey, required int messageId}) async {
    try {
      Map<String, dynamic> data = {"download_key": downloadKey};

      Map resdata = await api.postFunctionName(data, messageId);
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
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data["message"].toString() ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    return false;
  }
}
