import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/role/widget/role_card.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

import 'package:tc_mcandy/helpers/ui_helpers.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool roleChaked = false;
  bool roleChake = false;
  dynamic role = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              UIHelper.verticalSpace(40.h),
              Text(
                "Hey! Please select your account type.",
                style: TextFontStyle.headline24w600c303030urbanist,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(36.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoleCard(
                    isSelected: roleChaked,
                    title: "As a Talent",
                    onTap: () {
                      setState(() {
                        roleChaked = true;
                        roleChake = false;
                        role = 3;
                        appData.write(KKeyroleSelected, role);
                      });
                    },
                  ),
                  RoleCard(
                    isSelected: roleChake,
                    title: "As a Fan",
                    onTap: () {
                      setState(() {
                        roleChake = true;
                        roleChaked = false;
                        role = 4;
                        appData.write(KKeyroleSelected, role);
                      });
                    },
                  ),
                ],
              ),
              UIHelper.verticalSpace(32.h),
              CustomButton(
                onTap: () {
                  if (role != 0) {
                    NavigationService.navigateToWithArgs(Routes.signUpScreen, {
                      'role': role,
                      'text': role == 3 ? "Your Name" : "Shop Name",
                    });
                  }
                },
                isActive: role != 0,
                btnName: "Continue",
              ),

              UIHelper.verticalSpace(20.h),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextFontStyle.headline12w400c303030urbanist,
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: TextFontStyle.headline14w500cFF5C24urbanist
                          .copyWith(fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigationService.navigateTo(Routes.signinRoute);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
