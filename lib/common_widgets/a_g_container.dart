import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class AGContainer extends StatelessWidget {
  final void Function()? onTapGoogle;
  final void Function()? onTapApple;
  const AGContainer({super.key, this.onTapGoogle, this.onTapApple});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Platform.isIOS)
          GestureDetector(
            onTap: onTapApple,
            child: Container(
              // width: 200.w,
              padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.c202020,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.icons.apple),
                  UIHelper.horizontalSpace(12.w),
                  Text(
                    "Sign in with Apple",
                    style: TextFontStyle.headline16w600cFFFFFFurbanist,
                  ),
                ],
              ),
            ),
          ),
        UIHelper.verticalSpace(12.w),
        GestureDetector(
          onTap: onTapGoogle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.cFFFFFF,
              border: Border.all(color: AppColors.cADADAD),
            ),
            child: Row(
              children: [
                SvgPicture.asset(Assets.icons.google),
                UIHelper.horizontalSpace(16.w),
                Text(
                  "Sign in with Google",
                  style: TextFontStyle.headline16w600c303030urbanist,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
