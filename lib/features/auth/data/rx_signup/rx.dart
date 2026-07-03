import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/helpers/di.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class PostSignUpRx extends RxResponseInt {
  final api = PostSignUpApi.instance;

  String message = kErrorGeneric;

  PostSignUpRx({required super.empty, required super.dataFetcher});

  ValueStream get filleData => dataFetcher.stream;

  Future<dynamic> post({
    String? email,
    String? name,
    String? password,
    String? confPassword,
    dynamic role,
    String? agree,
  }) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "name": name,
        "password": password,
        "password_confirmation": confPassword,
        "role": role,
        "agree": agree,
      };

      Map resdata = await api.postSignUp(data);
      return await handleSuccessWithReturn(resdata, role);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data, [dynamic role]) async {
    dataFetcher.sink.add(data);

    try {
      String token = data['token']?.toString() ?? '';
      if (data['expires_in'] is int) {
      } else if (data['expires_in'] is String) {}

      var userData = data['data'];

      int userId = 0;
      if (userData['id'] != null) {
        if (userData['id'] is int) {
          userId = userData['id'];
        } else if (userData['id'] is String) {
          userId = int.tryParse(userData['id']) ?? 0;
        }
      }

      String userName = userData['name']?.toString() ?? '';
      String userEmail = userData['email']?.toString() ?? '';

      int otp = 0;
      if (userData['otp'] != null) {
        if (userData['otp'] is int) {
          otp = userData['otp'];
        } else if (userData['otp'] is String) {
          otp = int.tryParse(userData['otp']) ?? 0;
        }
      }
      String? avatar = userData['avatar']?.toString();

      await appData.write(kKeyAccessToken, token);

      if (otp != 0) {
        await appData.write(KKeyOtp, otp.toString());
      }

      await appData.write(kKeyUserId, userId.toString());
      await appData.write(KKeyEmail, userEmail);
      await appData.write('user_name', userName);
      await appData.write('user_avatar', avatar ?? '');

      int roleId = 4;
      if (role != null) {
        if (role is int) {
          roleId = role;
        } else if (role is String) {
          roleId = int.tryParse(role) ?? 4;
        }
      }

      await appData.write(KKeyroleSelected, roleId);
      await appData.write(kkeyUserRole, roleId.toString());

      await appData.write(KKeyPendingEmail, userEmail);

      await appData.write(kKeyIsLoggedIn, false);

      return data;
    } catch (e) {
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = kErrorGeneric;

    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        handleUnauthorized();
        return false;
      } else {
        message = error.response?.data['message'] ?? message;
      }
    }

    customToastMessage('Error', message);
    return false;
  }
}
