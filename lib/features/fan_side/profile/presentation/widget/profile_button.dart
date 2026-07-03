import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const ProfileButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.cBF0707, AppColors.cFF5C24],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon, // 👈 dynamic
                  height: 20.h,
                  width: 20.w,
                ),
                UIHelper.horizontalSpace(8.w),
                Text(
                  title,
                  style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                    color: AppColors.cFFFFFF,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              Assets.icons.arrowWhite,
              height: 12.h,
              width: 12.w,
            ),
          ],
        ),
      ),
    );
  }
}
