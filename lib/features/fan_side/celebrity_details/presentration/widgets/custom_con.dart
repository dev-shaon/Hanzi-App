import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class CustomCon extends StatelessWidget {
  final String text;
  const CustomCon({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cC7C7C7),
      ),
      child: Text(text, style: TextFontStyle.headline14w400CFFFFFFGlacial),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final List<String> items;
  const CustomContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 10.h,
      children: items.map((item) => CustomCon(text: item)).toList(),
    );
  }
}
