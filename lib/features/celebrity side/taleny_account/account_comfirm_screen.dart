import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class AccountComfirmScreen extends StatefulWidget {
  const AccountComfirmScreen({super.key});

  @override
  State<AccountComfirmScreen> createState() => _AccountComfirmScreenState();
}

class _AccountComfirmScreenState extends State<AccountComfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              UIHelper.verticalSpace(180.h),
              Center(
                child: SvgPicture.asset(
                  Assets.icons.confirm,
                  height: 60.h,
                  width: 60.w,
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Text(
                "Submitted successfully",
                style: TextFontStyle.headline20w600c303030urbanist,
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                "Your account is submitted for the approval. Please wait some time to review your account. After getting approval, you will be able to login and setup you profile.",
                style: TextFontStyle.headline16w500cADADADurbanist,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                "(Note: your application will be verified manually. It can take longer time)",
                style: TextFontStyle.headline16w500cADADADurbanist,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(24.h),
              CustomButton(
                width: 176.w,
                onTap: () {
                  NavigationService.navigateTo(Routes.signinRoute);
                },
                btnName: "Back to login page",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
