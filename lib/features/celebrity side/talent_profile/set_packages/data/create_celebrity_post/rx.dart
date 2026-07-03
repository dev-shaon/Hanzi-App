import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../constants/app_constants.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class CelebrityPostRx extends RxResponseInt {
  final api = CelebrityPostApi.instance;

  CelebrityPostRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({
    required int categoryId,
    required String celebrityBio,
    required String mainTitle,
    required String description,
    required List<String> serviceTypes,
    required List<String> tags,
    required int status,
    required List<Map<String, dynamic>> packages,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "category_id": categoryId,
        "celebrity_bio": celebrityBio,
        "main_title": mainTitle,
        "description": description,
        "status": status,
      });

      for (int i = 0; i < serviceTypes.length; i++) {
        formData.fields.add(MapEntry("service_types[$i]", serviceTypes[i]));
      }

      for (int i = 0; i < tags.length; i++) {
        formData.fields.add(MapEntry("tags[$i]", tags[i]));
      }

      for (int i = 0; i < packages.length; i++) {
        formData.fields.add(
          MapEntry(
            "packages[$i][package_name]",
            packages[i]['package_name'].toString(),
          ),
        );
        formData.fields.add(
          MapEntry("packages[$i][price]", packages[i]['price'].toString()),
        );
        formData.fields.add(
          MapEntry(
            "packages[$i][description]",
            packages[i]['description'].toString(),
          ),
        );
        formData.fields.add(
          MapEntry(
            "packages[$i][revision_limit]",
            packages[i]['revision_limit'].toString(),
          ),
        );
        formData.fields.add(
          MapEntry(
            "packages[$i][delivery_days]",
            packages[i]['delivery_days'].toString(),
          ),
        );
        formData.fields.add(
          MapEntry(
            "packages[$i][editable]",
            packages[i]['editable'].toString(),
          ),
        );
      }

      Map resdata = await api.postCelebrityPost(formData);
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
