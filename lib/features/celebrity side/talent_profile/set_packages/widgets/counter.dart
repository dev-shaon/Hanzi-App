import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class Counter extends StatelessWidget {
  final int value;
  final VoidCallback increment;
  final VoidCallback decrement;
  const Counter({super.key, required this.value, required this.increment, required this.decrement});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140.w,
      child: Row(
        children: [
          InkWell(
            onTap: decrement,
            child: SvgPicture.asset(Assets.icons.detrimentIcon),
          ),
          UIHelper.horizontalSpace(12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.c7C7C7C),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextFontStyle.headline14w600c303030urbanist,
              ),
            ),
          ),
          UIHelper.horizontalSpace(12.w),
          InkWell(
            onTap: increment,
            child: SvgPicture.asset(Assets.icons.incripment),
          ),
        ],
      ),
    );
  }
}
