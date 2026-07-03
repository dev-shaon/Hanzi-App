import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isActive = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isActive = emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendForgotEmail() async {
    setState(() => isLoading = true);
    try {
      bool success = await postForgetEmailSendRxObj.post(
        email: emailController.text.trim(),
      );
      if (success) {
        NavigationService.navigateToWithArgs(Routes.forgetVerifyScreen, {
          "email": emailController.text.trim(),
        });
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SafeArea(
            child: Column(
            children: [
              UIHelper.verticalSpace(40.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      NavigationService.goBack;
                    },
                    child: SvgPicture.asset(
                      Assets.icons.backIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  UIHelper.horizontalSpace(60.w),
                  Text(
                    "Enter your email",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                ],
              ),
              UIHelper.verticalSpace(40.w),
              CustomFormField(
                controller: emailController,
                prefixIcon: SvgPicture.asset(Assets.icons.emailIcon),
                hintText: "Username or email",
              ),
              UIHelper.verticalSpace(32.w),
              CustomButton(
                onTap: isActive ? _sendForgotEmail : null,
                btnName: "Continue",
                isGradient: true,
                isActive: isActive,
                isLoading: isLoading,
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
