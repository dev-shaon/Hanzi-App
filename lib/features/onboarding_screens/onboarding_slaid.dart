import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/onboarding_screens/widget/Onboarding_content.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class OnboardingSlaid extends StatefulWidget {
  const OnboardingSlaid({super.key});

  @override
  State<OnboardingSlaid> createState() => _OnboardingSlaidState();
}

class _OnboardingSlaidState extends State<OnboardingSlaid> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _autoSlide();
    });
  }

  void _autoSlide() {
    if (!mounted) return;

    if (currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.images.onboardingScreens.path,
              fit: BoxFit.fitHeight,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          appData.write(kKeyIsFirstTime, false);
                          NavigationService.navigateToReplacementUntil(
                            Routes.signinRoute,
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextFontStyle.headline16w500c202020urbanist,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => currentIndex = index);

                        Future.delayed(const Duration(seconds: 2), () {
                          _autoSlide();
                        });
                      },
                      children: [
                        OnboardingContent(
                          title: "Browse",
                          description:
                              "You can connect with the people around the world for doing chat, messages and make connections with them.",
                          imagePath: Assets.images.onboarding1.path,
                          onIconTap: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        OnboardingContent(
                          title: "Find",
                          description:
                              "You can connect with the people around the world for doing chat, messages and make connections with them.",
                          imagePath: Assets.images.onboarding2.path,
                          onIconTap: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        OnboardingContent(
                          title: "Shout-Out",
                          description:
                              "You can connect with the people around the world for doing chat, messages and make connections with them.",
                          imagePath: Assets.images.onboarding3.path,
                          onIconTap: () {},
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                dotHeight: 6.h,
                                dotWidth: 10.w,
                                expansionFactor: 3,
                                activeDotColor: AppColors.cE85421,
                                dotColor: AppColors.c7C7C7C,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (currentIndex < 2) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  appData.write(kKeyIsFirstTime, false);
                                  NavigationService.navigateToReplacementUntil(
                                    Routes.signinRoute,
                                  );
                                }
                              },
                              child: SvgPicture.asset(Assets.icons.arrowRight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
