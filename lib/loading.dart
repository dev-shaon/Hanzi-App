import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tc_mcandy/features/auth/presentation/signin/signin_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_navber.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/welcome_profile/welcome_profile.dart';
import 'package:tc_mcandy/features/fan_side/navber_screen.dart';
import 'package:tc_mcandy/features/onboarding_screens/onboarding_slaid.dart';
import 'package:tc_mcandy/splash_screens/splash_screen.dart';

import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helpers_method.dart';
import 'networks/dio/dio.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  bool _isLoading = true;
  Widget? _nextScreen;

  Future<void> loadInitialData() async {
    await setInitValue();

    bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
    log("Is Logged In: $isLoggedIn");

    if (isLoggedIn) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);

      String userRole = appData.read(kkeyUserRole) ?? "";
      bool hasPackage = appData.read(kkeyhasPackage) ?? false;

      log("hasPackage: $hasPackage");
      log("userRole: $userRole");

      setState(() {
        _nextScreen = userRole == "fan"
            ? const NavberScreen()
            : hasPackage == false
            ? const WelcomeProfile()
            : const CelebrityNavber();
        _isLoading = false;
      });
    } else {
      bool isFirstTime = appData.read(kKeyIsFirstTime) ?? true;
      log("Is First Time: $isFirstTime");

      setState(() {
        _nextScreen = isFirstTime
            ? const OnboardingSlaid()
            : const SigninScreen();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();
    } else {
      return _nextScreen ?? const SigninScreen();
    }
  }
}
