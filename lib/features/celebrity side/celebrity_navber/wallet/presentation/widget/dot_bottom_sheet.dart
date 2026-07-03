import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/account_connect.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import '../stripe_onboarding_screen.dart';

import 'package:tc_mcandy/helpers/ui_helpers.dart';

class DotBottomSheet extends StatelessWidget {
  const DotBottomSheet({super.key});

  Future<void> _handleStripeAccountTap(BuildContext context) async {
    final bool success = await getAccountConnectRxObj.fetchfunctionName();
    if (!success) return;

    final streamData = getAccountConnectRxObj.fillData;
    if (!streamData.hasValue) {
      customToastMessage('Error', 'Onboarding URL not found');
      return;
    }

    final AccountConnectModel response =
        streamData.value as AccountConnectModel;
    final String? onboardingUrl = response.data?.onboardingUrl;

    if (onboardingUrl == null || onboardingUrl.isEmpty) {
      customToastMessage('Error', 'Onboarding URL not found');
      return;
    }

    final navigatorState = NavigationService.navigatorKey.currentState;
    if (navigatorState == null) {
      customToastMessage('Error', 'Navigation is unavailable');
      return;
    }

    if (!context.mounted) return;
    Navigator.of(context).pop();

    navigatorState.push(
      MaterialPageRoute(
        builder: (_) => StripeOnboardingScreen(onboardingUrl: onboardingUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),

            UIHelper.verticalSpace(20.h),

            GestureDetector(
              onTap: () async {
                await _handleStripeAccountTap(context);
              },
              child: Container(
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stripe account",
                      style: TextFontStyle.headline16w500c7C7C7Curbanist
                          .copyWith(color: AppColors.c303030),
                    ),
                    SvgPicture.asset(Assets.icons.arrowBlack),
                  ],
                ),
              ),
            ),

            UIHelper.verticalSpace(12.h),
            // Divider(color: AppColors.c303030),
            // UIHelper.verticalSpace(12.h),

            // // GestureDetector(
            // //   onTap: () {
            // //     NavigationService.navigateTo(Routes.helpDeskScreen);
            // //   },
            // //   child: Container(
            // //     decoration: BoxDecoration(),
            // //     child: Row(
            // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // //       children: [
            // //         Text(
            // //           "FAQ",
            // //           style: TextFontStyle.headline16w500c7C7C7Curbanist
            // //               .copyWith(color: AppColors.c303030),
            // //         ),
            // //         SvgPicture.asset(Assets.icons.arrowBlack),
            // //       ],
            // //     ),
            // //   ),
            // // ),
            // // UIHelper.verticalSpace(12.h),
            // // Divider(color: AppColors.c303030),
            // // UIHelper.verticalSpace(10.h),
          ],
        ),
      ),
    );
  }
}
