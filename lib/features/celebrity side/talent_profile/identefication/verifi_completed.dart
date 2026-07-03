import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

import 'package:tc_mcandy/helpers/ui_helpers.dart';

class VerifiCompleted extends StatefulWidget {
  const VerifiCompleted({super.key});

  @override
  State<VerifiCompleted> createState() => _VerifiCompletedState();
}

class _VerifiCompletedState extends State<VerifiCompleted> {
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
              UIHelper.verticalSpace(180.h),
              Center(child: SvgPicture.asset(Assets.icons.verificationComplet)),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  "Verification completed!",
                  style: TextFontStyle.headline24w600c303030urbanist,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "Get reminders for new orders by allowing Cameo to notify you.",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(300.h),

              CustomButton(
                onTap: () {
                  NavigationService.navigateTo(Routes.profileComplete);
                },
                btnName: "Get started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
