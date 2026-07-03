import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/model/leaderboard_model.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetLeaderBoardRx extends RxResponseInt {
  final api = GetLeaderBoardApi.instance;

  String message = kErrorGeneric;

  GetLeaderBoardRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchLeaderboard() async {
    try {
      Map resdata = await api.getLeaderBoardData();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    LeaderBoardModel model = LeaderBoardModel.fromJson(data);
    dataFetcher.sink.add(model);
    return true;
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
        message = error.response?.data["message"].toString() ?? kErrorGeneric;
      }
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
