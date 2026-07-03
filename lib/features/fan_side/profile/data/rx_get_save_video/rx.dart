import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/save_video_model.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/networks/stream_cleaner.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetSaveVideoRx extends RxResponseInt {
  final api = GetSaveVideoApi.instance;

  String message = kErrorGeneric;

  GetSaveVideoRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchSaveVideo() async {
    try {
      Map resdata = await api.getSaveVideo();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    SaveVideosModel saveVideosModel = SaveVideosModel.fromJson(data);
    dataFetcher.sink.add(saveVideosModel);
    return true;
  }

  bool isVideoSaved(String? videoUrl) {
    if (videoUrl == null) return false;
    final model = dataFetcher.valueOrNull;
    if (model == null || model.data == null) return false;
    return model.data!.any((datum) => datum.videoUrl == videoUrl);
  }

  void toggleLocalSave(String? videoUrl, int? celebrityId) {
    if (videoUrl == null) return;
    final model = dataFetcher.valueOrNull ?? SaveVideosModel(data: []);
    final List<Datum> currentData = List.from(model.data ?? []);

    final int index = currentData.indexWhere(
      (datum) => datum.videoUrl == videoUrl,
    );

    if (index != -1) {
      // Remove it
      currentData.removeAt(index);
    } else {
      // Add it
      currentData.insert(
        0,
        Datum(
          videoUrl: videoUrl,
          celebrityId: celebrityId,
          createdAt: DateTime.now(),
        ),
      );
    }

    dataFetcher.sink.add(
      SaveVideosModel(
        status: model.status,
        message: model.message,
        code: model.code,
        data: currentData,
      ),
    );
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        /// Token expired or unauthorized — reset app state
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.signinRoute);
      } else {
        message = error.response?.data["message"].toString() ?? kErrorGeneric;
      }
      if (error.type == DioExceptionType.connectionError) {
        message = kErrorNoConnection;
      }
    }
    customToastMessage('Error', message);
    return super.handleErrorWithReturn(error);
  }
}
