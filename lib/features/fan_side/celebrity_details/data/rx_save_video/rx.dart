import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostSaveVideoRx extends RxResponseInt {
  final api = PostSaveVideoApi.instance;

  String message = kErrorGeneric;

  PostSaveVideoRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({int? id, String? videoUrl}) async {
    try {
      Map<String, dynamic> data = {"celebrity_id": id, "video_url": videoUrl};

      Map resdata = await api.postSaveVideo(data);
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
    return super.handleErrorWithReturn(error);
  }
}
