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
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
// import 'package:get/get.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import 'package:tc_mcandy/providers/validation_provider.dart';

import '../../../../constants/app_constants.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isLoading = false;
  String? apiEmailError;
  String? apiPasswordError;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  void _login() async {
    setState(() {
      isLoading = true;
      apiEmailError = null;
    });
    loginRx.lastError = null;
    loginRx.lastPasswordError = null;
    bool success = await loginRx.post(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (success) {
      AppSessionState.isSessionExpired = false;
      String? userRoleId = appData.read(kkeyUserRole);
      bool hasPackage = appData.read(kkeyhasPackage) ?? false;

      if (userRoleId == "fan") {
        NavigationService.navigateToReplacement(Routes.navberScreen);
      } else if (userRoleId == "celebrity") {
        if (hasPackage == true) {
          NavigationService.navigateToReplacement(Routes.celebrityNavber);
        } else {
          NavigationService.navigateToReplacement(Routes.welcomeProfile);
        }
      } else {
        NavigationService.navigateToReplacement(Routes.navberScreen);
      }
    } else {
      setState(() {
        isLoading = false;
        apiEmailError = loginRx.lastError;
        apiPasswordError = loginRx.lastPasswordError;
      });
    }
  }

  void _updateButtonState() {
    setState(() {});
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isActive =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    return ChangeNotifierProvider(
      create: (_) => ValidationProvider(),
      child: Consumer<ValidationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.verticalSpace(40.h),
                      Center(
                        child: Text(
                          "Welcome back",
                          style: TextFontStyle.headline24w600c303030urbanist,
                        ),
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        "Log In to your existing account",
                        style: TextFontStyle.headline16w500cADADADurbanist,
                      ),
                      UIHelper.verticalSpace(40.h),
                      CustomFormField(
                        controller: emailController,
                        hintText: "email",
                        prefixIcon: SvgPicture.asset(Assets.icons.emailIcon),
                        textInputAction: TextInputAction.next,
                        validator: emailValidator,
                        onChanged: (_) {
                          if (apiEmailError != null) {
                            setState(() => apiEmailError = null);
                          }
                        },
                      ),
                      if (apiEmailError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 6.h, left: 4.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              apiEmailError!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      UIHelper.verticalSpace(16.h),

                      CustomFormField(
                        controller: passwordController,
                        hintText: "Password",
                        prefixIcon: SvgPicture.asset(Assets.icons.protectRight),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            provider.togglePasswordVisibility();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: SvgPicture.asset(
                              provider.isPasswordVisible
                                  ? Assets.icons.eyeOpen
                                  : Assets.icons.eye,
                            ),
                          ),
                        ),
                        isPass: true,
                        isObsecure: !provider.isPasswordVisible,
                        onChanged: (_) {
                          if (apiPasswordError != null) {
                            setState(() => apiPasswordError = null);
                          }
                        },
                      ),
                      if (apiPasswordError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 6.h, left: 4.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              apiPasswordError!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      UIHelper.verticalSpace(12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(Routes.forgotScreen);
                            },
                            child: Text(
                              "Forget password?",
                              style: TextFontStyle.headline14w400CFFFFFFGlacial
                                  .copyWith(
                                    color: AppColors.cFF5C24,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(20.h),
                      CustomButton(
                        onTap: _login,
                        btnName: "Log In",
                        isGradient: true,
                        isActive: isActive,
                        isLoading: isLoading,
                      ),

                      UIHelper.verticalSpace(32.h),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              "or",
                              style:
                                  TextFontStyle.headline12w300c303030urbanist,
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(32.h),
                      AGContainer(onTapGoogle: () {}),
                      UIHelper.verticalSpace(20.h),
                      RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextFontStyle.headline12w400c303030urbanist,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: TextFontStyle.headline14w500cFF5C24urbanist
                                  .copyWith(fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  NavigationService.navigateTo(
                                    Routes.roleScreen,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(40.h),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(
                            Routes.managerLoginScreen,
                          );
                        },
                        child: Text(
                          "Login as a manager",
                          style: TextFontStyle.headline16w500c7C7C7Curbanist
                              .copyWith(
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
        },
      ),
    );
  }
}
