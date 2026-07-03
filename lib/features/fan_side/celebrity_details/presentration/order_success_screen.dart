import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFF8,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const Spacer(),
              Center(child: SvgPicture.asset(Assets.icons.verificationComplet)),
              UIHelper.verticalSpace(16.h),
              Text(
                "Payment Successful!",
                style: TextFontStyle.headline24w600c303030urbanist,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "Congrats! Your order has been placed successfully. You will be notified once it's ready.",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  NavigationService.navigateToReplacement(Routes.navberScreen);
                },
                btnName: "Go to Home",
              ),
              UIHelper.verticalSpace(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
