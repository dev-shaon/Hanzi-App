import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onIconTap;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpace(100.h),

        Image.asset(imagePath),

        UIHelper.verticalSpace(105.h),

        Text(
          title,
          style: TextFontStyle.headline28w700c202020urbanist,
        ),

        UIHelper.verticalSpace(18.h),

        Text(
          description,
          style: TextFontStyle.headline16w500c7C7C7Curbanist
              .copyWith(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
