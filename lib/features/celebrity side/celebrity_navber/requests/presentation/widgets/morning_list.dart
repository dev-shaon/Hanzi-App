import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class MorningList extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MorningList({
    super.key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.cFF5C24 : AppColors.c7C7C7C,
            width: 1.w,
          ),
          color: isSelected
              ? AppColors.cFF5C24.withValues(alpha: 0.12)
              : AppColors.cFFFFFF,
        ),
        child: Text(
          title,
          style: TextFontStyle.headline14w500cFF5C24urbanist.copyWith(
            color: AppColors.c303030,
          ),
        ),
      ),
    );
  }
}
