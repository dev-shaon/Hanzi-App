import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ManagerVeryfyOtpScreen extends StatefulWidget {
  final String email;
  const ManagerVeryfyOtpScreen({super.key, required this.email});

  @override
  State<ManagerVeryfyOtpScreen> createState() => _ManagerVeryfyOtpScreenState();
}

class _ManagerVeryfyOtpScreenState extends State<ManagerVeryfyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  Timer? _timer;
  int _remainingSeconds = 60;
  bool _isResendEnabled = false;
  bool _isResending = false;
  bool _isLoading = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _remainingSeconds = 60;
      _isResendEnabled = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isResendEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _resendOtp() async {
    if (!_isResendEnabled || _isResending) return;

    setState(() {
      _isResending = true;
    });

    try {
      await postManagerResendOtpRx.post(email: widget.email);

      customToastMessage("Success", "OTP sent successfully");
      _otpController.clear();
      _startTimer();
    } catch (e) {
      customToastMessage("Error", "Failed to resend OTP");
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  void _verifyOtp() async {
    if (_otpController.text.trim().length < 4) {
      setState(() => _errorText = "Please enter the 4-digit OTP");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      bool success = await postManagerVeryfyOtpRx.post(
        otp: _otpController.text.trim(),
        email: widget.email,
      );

      if (success) {
        customToastMessage("Success", "Verification successful!");
        NavigationService.navigateToReplacementUntil(Routes.celebrityNavber);
      } else {
        setState(() => _errorText = "Invalid OTP. Please try again.");
      }
    } catch (e) {
      setState(() => _errorText = "Invalid OTP. Please try again.");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 75.w,
      height: 50.h,
      textStyle: TextFontStyle.headline24w600c303030urbanist.copyWith(
        fontSize: 22.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.cADADAD),
        color: AppColors.cFFFFFF,
      ),
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            children: [
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      Assets.icons.backIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  UIHelper.horizontalSpace(50.w),
                  Text(
                    "Check your email",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                ],
              ),
              UIHelper.verticalSpace(60.h),

              Pinput(
                controller: _otpController,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _errorText = null;
                  });
                },
                preFilledWidget: Text(
                  '-',
                  style: TextFontStyle.headline16w500c7C7C7Curbanist,
                ),
              ),

              UIHelper.verticalSpace(8.h),

              if (_errorText != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    _errorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              UIHelper.verticalSpace(20.h),

              CustomButton(
                onTap: _verifyOtp,
                isActive: _otpController.text.length == 4,
                btnName: "Continue",
                isLoading: _isLoading,
              ),

              UIHelper.verticalSpace(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't get any code? ",
                    style: TextFontStyle.headline14w500cFF5C24urbanist.copyWith(
                      color: AppColors.c7C7C7C,
                    ),
                  ),
                  GestureDetector(
                    onTap: _isResendEnabled ? _resendOtp : null,
                    child: _isResending
                        ? SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.cFF5C24,
                              ),
                            ),
                          )
                        : Text(
                            "Resend",
                            style: TextFontStyle.headline14w600c303030urbanist
                                .copyWith(
                                  color: _isResendEnabled
                                      ? AppColors.cFF5C24
                                      : AppColors.c7C7C7C,
                                ),
                          ),
                  ),
                  if (!_isResending) ...[
                    Text(
                      " - ",
                      style: TextFontStyle.headline14w500cFF5C24urbanist
                          .copyWith(color: AppColors.c303030),
                    ),
                    Text(
                      _formatTime(_remainingSeconds),
                      style: TextFontStyle.headline14w500cFF5C24urbanist
                          .copyWith(
                            color: _isResendEnabled
                                ? AppColors.c7C7C7C
                                : AppColors.c303030,
                          ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
