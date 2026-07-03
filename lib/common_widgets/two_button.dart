import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class TwoButton extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onApply;
  const TwoButton({super.key, required this.onClear, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 54.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onClear,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Clear all',
                style: TextFontStyle.headline16w600c303030urbanist,
              ),
            ),
          ),
          GestureDetector(
            onTap: onApply,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.cBF0707, AppColors.cFF5C24],
                ),
              ),
              child: Text(
                'Show results',
                style: TextFontStyle.headline16w600cFFFFFFurbanist,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
