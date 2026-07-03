import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class SendMessageApi {
  static final SendMessageApi _singleton = SendMessageApi._internal();
  SendMessageApi._internal();
  static SendMessageApi get instance => _singleton;
  Future<Map> sendMessage(
    int userId,
    String message, {
    File? file,
    bool? generateKey,
    String? keyCode,
  }) async {
    try {
      if (file != null) {
        final ext = p.extension(file.path).toLowerCase();
        final String mimeType;
        switch (ext) {
          case '.mp4':
            mimeType = 'video/mp4';
          case '.mov':
            mimeType = 'video/quicktime';
          case '.mkv':
            mimeType = 'video/x-matroska';
          case '.avi':
            mimeType = 'video/x-msvideo';
          case '.jpg':
          case '.jpeg':
            mimeType = 'image/jpeg';
          case '.png':
            mimeType = 'image/png';
          case '.gif':
            mimeType = 'image/gif';
          case '.webp':
            mimeType = 'image/webp';
          default:
            mimeType = 'application/octet-stream';
        }

        final fileName = p.basename(file.path);

        FormData formData = FormData.fromMap({
          'message': message,
          'file': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: DioMediaType.parse(mimeType),
          ),
  
          if (generateKey != null) 'generateKey': generateKey ? 1 : 0,

          if (generateKey == true && keyCode != null) 'downloadKey': keyCode,
        });

        Response response = await postHttp(
          EndPoints.sendMessage(userId),
          formData,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return json.decode(json.encode(response.data));
        } else {
          throw DataSource.DEFAULT.getFailure();
        }
      } else {
        final Map data = {'message': message};
        Response response = await postHttp(EndPoints.sendMessage(userId), data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return json.decode(json.encode(response.data));
        } else {
          throw DataSource.DEFAULT.getFailure();
        }
      }
    } catch (error) {
      rethrow;
    }
  }
}
