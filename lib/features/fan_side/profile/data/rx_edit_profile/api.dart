import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import 'package:tc_mcandy/networks/endpoints.dart';
import 'package:tc_mcandy/networks/exception_handler/data_source.dart';

final class EditProfileApi {
  static final EditProfileApi _singleton = EditProfileApi._internal();
  EditProfileApi._internal();

  static EditProfileApi get instance => _singleton;

  Future<Map> editProfile({
    required String name,
    required String phone,
    required String email,

    File? image,
  }) async {
    try {
    FormData data = FormData.fromMap({
      "name": name,
      "phone": phone,
      "email": email,
    });
    
    if (image != null && await File(image.path).exists()) {
      data.files.add(
        MapEntry('avatar', await MultipartFile.fromFile(image.path)),
      );
    }
    
    Response response = await postHttp(EndPoints.editProfile(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
