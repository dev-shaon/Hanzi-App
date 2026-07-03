import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _newPassVisible = false;
  bool _confirmPassVisible = false;
  bool _isLoading = false;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _newPassController.addListener(_updateButtonState);
    _confirmPassController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isActive =
          _newPassController.text.isNotEmpty &&
          _confirmPassController.text.isNotEmpty &&
          _newPassController.text == _confirmPassController.text;
    });
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_newPassController.text != _confirmPassController.text) {
      customToastMessage("Error", "Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      bool success = await postResetPassRxObj.post(
        email: widget.email,
        password: _newPassController.text.trim(),
        confirmPassword: _confirmPassController.text.trim(),
        token: appData.read(KKeyForgetToken),
      );

      if (success) {
        customToastMessage("Success", "Password reset successfully!");
        NavigationService.navigateToReplacementUntil(Routes.signinRoute);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      Assets.icons.backIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  UIHelper.horizontalSpace(60.w),
                  Text(
                    "Change password",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                ],
              ),

              UIHelper.verticalSpace(40.h),

              CustomFormField(
                controller: _newPassController,
                hintText: "New Password",
                prefixIcon: SvgPicture.asset(Assets.icons.protectRight),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _newPassVisible = !_newPassVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: SvgPicture.asset(
                      _newPassVisible ? Assets.icons.eyeOpen : Assets.icons.eye,
                    ),
                  ),
                ),
                isPass: true,
                isObsecure: !_newPassVisible,
              ),

              UIHelper.verticalSpace(16.h),

              CustomFormField(
                controller: _confirmPassController,
                hintText: "Confirm new password",
                prefixIcon: SvgPicture.asset(Assets.icons.protectRight),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _confirmPassVisible = !_confirmPassVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      _confirmPassVisible
                          ? Assets.icons.eyeOpen
                          : Assets.icons.eye,
                    ),
                  ),
                ),
                isPass: true,
                isObsecure: !_confirmPassVisible,
              ),

              UIHelper.verticalSpace(32.h),

              CustomButton(
                onTap: _isActive ? _resetPassword : null,
                isActive: _isActive,
                isGradient: true,
                btnName: "Continue",
                isLoading: _isLoading,
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
