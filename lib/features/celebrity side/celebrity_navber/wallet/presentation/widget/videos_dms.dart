import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class VideosDms extends StatelessWidget {
  final String title;
  final String price;
  final Color? color;
  const VideosDms({super.key, required this.title, required this.price, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 7.h,
              width: 7.w,
              decoration: BoxDecoration(
                color:color ?? AppColors.c2196F3,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Text(
              title,
              style: TextFontStyle.headline16w500c7C7C7Curbanist,
            ),
          ],
        ),

        Text(price, style: TextFontStyle.headline16w600c303030urbanist),
      ],
    );
  }
}
