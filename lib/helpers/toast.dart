// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

import '../constants/text_font_style.dart';

final class ToastUtil {
  ToastUtil._();

  static void showErrorMessage({required String message, String? title}) {
    // Suppress toasts if session expired
    if (AppSessionState.isSessionExpired) return;
    Get.snackbar(
      titleText: Text(
        title ?? "Warning",
        style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
          fontSize: 16.sp,
          color: AppColors.cFFFFFF,
          fontStyle: FontStyle.normal,
        ),
      ),
      messageText: Text(
        message,
        style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
          fontSize: 13.sp,
          color: AppColors.cFFFFFF,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
        ),
      ),
      "",
      message,
      // backgroundColor: Color.fromARGB(255, 244, 112, 89),
      borderRadius: 26.r,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h, bottom: 12.h),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showSuccessMessage(String message) {
    Get.snackbar(
      titleText: Text(
        "Successful",
        // style: TextFontStyle.headline16w600CFFFFFFPoppins,
      ),
      messageText: Text(
        message,
        // style: TextFontStyle.headline14w500C242424Poppins.copyWith(
        //   color: AppColors.cFFFFFF,
        // ),
      ),
      "",
      message,
      backgroundColor: AppColors.allPrimaryColor,
      borderRadius: 26.r,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h, bottom: 10.h),
      snackPosition: SnackPosition.TOP,
    );
  }
}
