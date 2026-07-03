import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostReviewRx extends RxResponseInt {
  final api = PostReviewAPI.instance;

  String message = "Something went wrong";

  PostReviewRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({
    required int rating,
    String? review,
    required int messageId,
    required int celebrityId,
  }) async {
    try {
      Map<String, dynamic> data = {
        "celebrity_id": celebrityId,
        "rating": rating,
        if (review != null) "review": review,
      };

      Map resdata = await api.postReview(data, messageId);
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
