import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/constants/validation.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ManagerLoginScreen extends StatefulWidget {
  const ManagerLoginScreen({super.key});

  @override
  State<ManagerLoginScreen> createState() => _ManagerLoginScreenState();
}

class _ManagerLoginScreenState extends State<ManagerLoginScreen> {
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

  void _sendManagerOtp() async {
    try {
      setState(() {
        isLoading = true;
      });
      bool success = await postSendManagerOtpRx.post(
        email: emailController.text.trim(),
      );
      if (success) {
        NavigationService.navigateToWithArgs(Routes.managerVeryfyOtpScreen, {
          'email': emailController.text.trim(),
        });
      }
    } catch (e) {
      customToastMessage("Error", e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
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
                Text(
                  "Welcome back",
                  style: TextFontStyle.headline24w600c303030urbanist,
                ),
                UIHelper.verticalSpace(10.h),
                Text(
                  "Log In for manage a celebrity account",
                  style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                    color: AppColors.cADADAD,
                  ),
                ),

                UIHelper.verticalSpace(40.w),
                CustomFormField(
                  controller: emailController,
                  validator: emailValidator,
                  prefixIcon: SvgPicture.asset(Assets.icons.emailIcon),
                  hintText: "email",
                ),
                UIHelper.verticalSpace(32.w),
                CustomButton(
                  onTap: _sendManagerOtp,
                  btnName: "Log In",
                  isGradient: true,
                  isActive: isActive,
                  isLoading: isLoading,
                ),
                UIHelper.verticalSpace(32.h),
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.signinRoute);
                  },
                  child: Text(
                    "Back to regular login",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                      color: AppColors.c34A853,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
