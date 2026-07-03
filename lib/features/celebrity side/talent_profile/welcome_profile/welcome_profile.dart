import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class WelcomeProfile extends StatefulWidget {
  const WelcomeProfile({super.key});

  @override
  State<WelcomeProfile> createState() => _WelcomeProfileState();
}

class _WelcomeProfileState extends State<WelcomeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(50.h),
              Text(
                "Welcome to Hanzi 🎉",
                style: TextFontStyle.headline24w600c303030urbanist,
              ),
              UIHelper.verticalSpace(8.h),
              RichText(
                text: TextSpan(
                  text:
                      "Before you start setting up your profile to share with your fans, here's a special Hanzi Welcome from ",
                  style: TextFontStyle.headline16w500c7C7C7Curbanist,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tapiwa Mukandi',
                      style: TextFontStyle.headline16w600c303030urbanist,
                    ),
                    TextSpan(
                      text: ' just for you.',
                      style: TextFontStyle.headline16w500c7C7C7Curbanist,
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(100.h),
              Center(child: Image.asset(Assets.images.welcome.path)),
              UIHelper.verticalSpace(150.h),
              Center(
                child: Text(
                  "The future holds more than you imagine. 🤩",
                  style: TextFontStyle.headline16w600c303030urbanist,
                ),
              ),
              UIHelper.verticalSpace(30.h),
              CustomButton(
                onTap: () {
                  NavigationService.navigateTo(Routes.addProfileImage);
                },
                btnName: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
