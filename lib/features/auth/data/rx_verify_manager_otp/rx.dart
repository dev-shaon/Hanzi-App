import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import 'api.dart';

final class PostVerifyManagerOtpRx extends RxResponseInt {
  final api = PostVerifyManagerOtpApi.instance;

  String message = kErrorGeneric;

  PostVerifyManagerOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<bool> post({String? email, String? otp}) async {
    try {
      Map<String, dynamic> data = {"email": email, "otp": otp};

      Map resdata = await api.postVerifyManagerOtp(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      String token = data['token']?.toString() ?? '';
      await appData.write(kKeyAccessToken, token);
      await appData.write(kKeyIsLoggedIn, true);

      // Explicitly check for manager role or presence of managed_by data
      bool isManagerResponse =
          data['role'] == 'manager' || data['managed_by'] != null;
      await appData.write(kkeyIsManager, isManagerResponse);

      DioSingleton.instance.update(token);

      // Save celebrity account data so the rest of the app shows the correct profile
      final userData = data['data'];
      if (userData != null) {
        int userId = 0;
        if (userData['id'] is int) {
          userId = userData['id'];
        } else if (userData['id'] is String) {
          userId = int.tryParse(userData['id']) ?? 0;
        }
        await appData.write(kKeyUserId, userId.toString());
        await appData.write(KKeyEmail, userData['email']?.toString() ?? '');
        await appData.write('user_name', userData['name']?.toString() ?? '');
        await appData.write(
          'user_avatar',
          userData['avatar']?.toString() ?? '',
        );

        // Store the celebrity's role (role field from data object)
        String userRole = userData['role']?.toString() ?? '';
        if (userRole.isNotEmpty) {
          await appData.write(kkeyUserRole, userRole);
        }
      }

      dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      log('Manager verify save error: $e');
      return false;
    }
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
