import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/api_access.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  void logout() async {
    try {
      await postLogoutRxObj.fetchLogout().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return false;
        },
      );
      NavigationService.goBack;
    } catch (e) {
      log('Logout API error: $e');
    }

    await Future.wait([
      appData.remove(kKeyAccessToken),
      appData.remove(kKeyFCMToken),
      appData.write(kKeyIsLoggedIn, false),
    ]);
    NavigationService.navigateToReplacementUntil(Routes.signinRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: "", showFilter: false),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Almost done. We'd like to quickly verify you",
                style: TextFontStyle.headline24w600c303030urbanist,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "In order to proceed, we need to verify your identity through our partner, Stripe.",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
              UIHelper.verticalSpace(90.h),
              Center(child: Image.asset(Assets.images.identification.path)),
              UIHelper.verticalSpace(100.h),

              CustomButton(
                onTap: () {
                  NavigationService.navigateTo(Routes.verifiCompleted);
                },
                btnName: "Verify with Stripe",
              ),

              UIHelper.verticalSpace(8.h),
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 83.w,
                    vertical: 11.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.c7C7C7C),
                  ),
                  child: Text(
                    "Log out and verify later",
                    style: TextFontStyle.headline16w700cFFFFFFurbanist.copyWith(
                      color: AppColors.c303030,
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Cancel application",
                    style: TextFontStyle.headline16w600c303030urbanist.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
