import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

import '../../../../networks/api_access.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool oldPassVisible = false;
  bool newPassVisible = false;
  bool confirmPassVisible = false;
  bool isLoading = false;

  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  void _changePassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      bool success = await postChangePasswordRxObj.post(
        oldPassword: oldPassController.text,
        newPassword: newPassController.text,
        confirmPassword: confirmPassController.text,
      );
      if (success) {
        customToastMessage("Success", "Password changed successfully");
        NavigationService.goBack;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomAppBar(title: "Change Password", showFilter: false),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            /// Old Password
            CustomFormField(
              controller: oldPassController,
              hintText: "Old Password",
              prefixIcon: SvgPicture.asset(Assets.icons.protectRight),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    oldPassVisible = !oldPassVisible;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    oldPassVisible ? Assets.icons.eyeOpen : Assets.icons.eye,
                  ),
                ),
              ),
              isPass: true,
              isObsecure: !oldPassVisible,
            ),

            UIHelper.verticalSpace(12.h),

            CustomFormField(
              controller: newPassController,
              hintText: "New Password",
              prefixIcon: SvgPicture.asset(Assets.icons.protectRight),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    newPassVisible = !newPassVisible;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    newPassVisible ? Assets.icons.eyeOpen : Assets.icons.eye,
                  ),
                ),
              ),
              isPass: true,
              isObsecure: !newPassVisible,
            ),

            UIHelper.verticalSpace(12.h),

            CustomFormField(
              controller: confirmPassController,
              hintText: "Confirm New Password",
              prefixIcon: SvgPicture.asset(Assets.icons.protectRight),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    confirmPassVisible = !confirmPassVisible;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    confirmPassVisible
                        ? Assets.icons.eyeOpen
                        : Assets.icons.eye,
                  ),
                ),
              ),
              isPass: true,
              isObsecure: !confirmPassVisible,
            ),

            UIHelper.verticalSpace(40.h),

            CustomButton(
              onTap: _changePassword,
              btnName: "Save",
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
