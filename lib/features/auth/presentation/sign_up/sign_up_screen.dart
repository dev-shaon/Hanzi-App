import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tc_mcandy/common_widgets/a_g_container.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/constants/validation.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import 'package:tc_mcandy/providers/validation_provider.dart';

import '../../../../common_widgets/custom_toast.dart';

class SignUpScreen extends StatefulWidget {
  final dynamic role;
  final String text;
  const SignUpScreen({super.key, required this.role, required this.text});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    shopeController.addListener(_updateState);
    emailController.addListener(_updateState);
    passwordController.addListener(_updateState);
    confirmPasswordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController shopeController = TextEditingController();

  void _signup() async {
    if (formKey.currentState!.validate()) {
      if (isChecked == true) {
        setState(() {
          isLoading = true;
        });
        try {
          var response = await signupRx.post(
            email: emailController.text,
            password: passwordController.text,
            name: shopeController.text,
            confPassword: confirmPasswordController.text,
            role: widget.role.toString(),
            agree: isChecked.toString(),
          );

          if (response != false && response != null) {
            customToastMessage('Success', 'OTP sent to your email');

            NavigationService.navigateToWithArgs(Routes.verfiyScreen, {
              "roleSelected": widget.role,
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        } catch (e) {
          customToastMessage("Warning", "An error occurred: $e");
          setState(() {
            isLoading = false;
          });
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        customToastMessage(
          "Warning",
          "Please agree to the terms and conditions",
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    shopeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ValidationProvider(),
      child: Consumer<ValidationProvider>(
        builder: (context, provider, child) {
          bool isActive =
              shopeController.text.isNotEmpty &&
              emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty &&
              confirmPasswordController.text.isNotEmpty &&
              isChecked;
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.verticalSpace(40.h),
                      Center(
                        child: Text(
                          "Create an account",
                          style: TextFontStyle.headline24w600c303030urbanist,
                        ),
                      ),
                      UIHelper.verticalSpace(40.h),

                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomFormField(
                              controller: shopeController,
                              hintText: widget.text,
                              validator: nameValidator,
                              onChanged: (_) => setState(() {}),
                              prefixIcon: SvgPicture.asset(Assets.icons.person),
                            ),
                            UIHelper.verticalSpace(16.h),

                            CustomFormField(
                              controller: emailController,
                              hintText: "Email Address",
                              validator: emailValidator,
                              onChanged: (_) => setState(() {}),
                              prefixIcon: SvgPicture.asset(
                                Assets.icons.emailIcon,
                              ),
                            ),
                            UIHelper.verticalSpace(16.h),

                            CustomFormField(
                              controller: passwordController,
                              hintText: "Password",
                              validator: passwordValidator,
                              onChanged: (_) => setState(() {}),
                              prefixIcon: SvgPicture.asset(
                                Assets.icons.protectRight,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: SvgPicture.asset(
                                    isPasswordVisible
                                        ? Assets.icons.eyeOpen
                                        : Assets.icons.eye,
                                  ),
                                ),
                              ),
                              isPass: true,
                              isObsecure: !isPasswordVisible,
                            ),
                            UIHelper.verticalSpace(16.h),

                            CustomFormField(
                              controller: confirmPasswordController,
                              hintText: "Confirm password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Confirm password is required";
                                }
                                if (value != passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              onChanged: (_) => setState(() {}),
                              prefixIcon: SvgPicture.asset(
                                Assets.icons.protectRight,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: SvgPicture.asset(
                                    isConfirmPasswordVisible
                                        ? Assets.icons.eyeOpen
                                        : Assets.icons.eye,
                                  ),
                                ),
                              ),
                              isPass: true,
                              isObsecure: !isConfirmPasswordVisible,
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(12.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: SvgPicture.asset(
                              isChecked
                                  ? Assets.icons.checkedIcon
                                  : Assets.icons.uncheckedIcon,
                            ),
                          ),
                          UIHelper.horizontalSpace(6.w),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextFontStyle.headline14w400CFFFFFFGlacial,
                              children: [
                                const TextSpan(text: 'Agree to '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextFontStyle
                                      .headline14w500cFF5C24urbanist,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      NavigationService.navigateTo(
                                        Routes.tarmsScreens,
                                      );
                                    },
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextFontStyle
                                      .headline14w500cFF5C24urbanist,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      NavigationService.navigateTo(
                                        Routes.policyScreen,
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(20.h),

                      CustomButton(
                        onTap: () async {
                          _signup();
                        },
                        isActive: isActive,
                        isLoading: isLoading,
                        btnName: "Create Account",
                      ),

                      UIHelper.verticalSpace(28.h),

                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              "or",
                              style:
                                  TextFontStyle.headline12w300c303030urbanist,
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      UIHelper.verticalSpace(32.h),
                      AGContainer(),
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
                                  NavigationService.navigateTo(
                                    Routes.signinRoute,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
