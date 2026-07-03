import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';
import '../helpers/ui_helpers.dart';

import '../constants/app_constants.dart';

void customToastMessage(String title, String description) {
  // Suppress toasts if session expired or if it's a redundant connection error
  if (AppSessionState.isSessionExpired || description == kErrorNoConnection) return;
  // Get the root scaffold messenger
  final context = NavigationService.navigatorKey.currentContext!;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.cFFFFFF,
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: AppColors.cFFFFFF),
          ),
        ],
      ),
      backgroundColor: const Color(0xff444444),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      dismissDirection: DismissDirection.horizontal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
      // No action button - will auto close after 3 seconds
    ),
  );
}
