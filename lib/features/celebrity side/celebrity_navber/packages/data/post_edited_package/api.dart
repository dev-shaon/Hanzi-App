import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class EditedCelebrityPackageApi {
  static final EditedCelebrityPackageApi _singleton =
      EditedCelebrityPackageApi._internal();
  EditedCelebrityPackageApi._internal();
  static EditedCelebrityPackageApi get instance => _singleton;

  Future<Map> postEditedCelebrityPackage(int id, Map data) async {
    try {
      final formData = FormData.fromMap(data.cast<String, dynamic>());

      Response response = await postHttp(
        EndPoints.updateCelebrityPost(id),
        formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
