import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tc_mcandy/helpers/di.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class DeleteAccountApi {
  static final DeleteAccountApi _singleton = DeleteAccountApi._internal();
  DeleteAccountApi._internal();
  static DeleteAccountApi get instance => _singleton;

  Future<Map> deleteAccount() async {
    try {
      Response response = await deleteHttp(
        EndPoints.deleteAccount(),
        Options(
          headers: {'Authorization': 'Bearer ${appData.read(kKeyAccessToken)}'},
        ),
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
