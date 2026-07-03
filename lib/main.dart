import 'dart:developer';
import 'dart:io';

import 'package:auto_animated/auto_animated.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tc_mcandy/constants/custome_theme.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/helpers_method.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/register_provider.dart';
import 'package:tc_mcandy/helpers/deep_link_service.dart';
import 'package:tc_mcandy/loading.dart';
import 'package:tc_mcandy/networks/dio/dio.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tc_mcandy/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = kStripePublishableKey;
  await Stripe.instance.applySettings();

  await GetStorage.init();
  diSetUp();
  DioSingleton.instance.create();
  
  // Initialize Deep Linking
  await DeepLinkService().init();

  try {
    if (Platform.isIOS) {
      if (Platform.environment.containsKey('SIMULATOR_DEVICE_NAME')) {
        log('Running on an iOS simulator. Skipping high refresh rate setting.');
      } else {
        await FlutterDisplayMode.setHighRefreshRate();
        log('High refresh rate mode set successfully.');
      }
    } else {
      await FlutterDisplayMode.setHighRefreshRate();
      log('High refresh rate mode set successfully.');
    }
  } catch (e) {
    log('Error setting high refresh rate: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Dismiss keyboard on hot restart
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    DeepLinkService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            // showMaterialDialog(context);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const UtillScreenMobile();
            },
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: 'Priche',
          theme: ThemeData(
            primarySwatch: CustomTheme.kToDark,
            primaryColor: AppColors.allPrimaryColor,
            useMaterial3: false,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.scaffoldColor,
              elevation: 0,
              foregroundColor: AppColors.c000000,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.allPrimaryColor,
            ),
            scaffoldBackgroundColor: AppColors.cFFFFF8,
          ),
          builder: (context, widget) {
            return MediaQuery(data: MediaQuery.of(context), child: widget!);
          },
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: Loading(),
        );
      },
    );
  }
}
