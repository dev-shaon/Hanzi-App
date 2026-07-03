import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostPlaceOrderRx extends RxResponseInt {
  final api = PostPlaceOrderApi.instance;

  String message = kErrorGeneric;

  PostPlaceOrderRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<String?> post({required int id, required String videoScript}) async {
    try {
      Map<String, dynamic> data = {
        "package_id": id,
        "video_script": videoScript,
      };

      Map resdata = await api.postPlaceOrder(data);

      // ✅ stripe_client_secret return করো
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
