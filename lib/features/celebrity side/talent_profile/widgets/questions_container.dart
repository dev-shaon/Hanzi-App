import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class QuestionsContainer extends StatelessWidget {
  const QuestionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cC7C7C7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.icons.questionIcon),
              UIHelper.horizontalSpace(6.w),
              Text(
                "Your photo should",
                style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                  color: AppColors.c303030,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(6.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color: AppColors.c7C7C7C,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              UIHelper.horizontalSpace(8),
              Text(
                "Show your face clearly",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
            ],
          ),
          UIHelper.verticalSpace(6.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color: AppColors.c7C7C7C,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              UIHelper.horizontalSpace(8.w),
              Text(
                "Good lighting",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
            ],
          ),
          UIHelper.verticalSpace(6.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color: AppColors.c7C7C7C,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              UIHelper.horizontalSpace(8),
              Text(
                "Be crisp and clear",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
            ],
          ),
          UIHelper.verticalSpace(6.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color: AppColors.c7C7C7C,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              UIHelper.horizontalSpace(8),
              Text(
                "Headshots recommended",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
