import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class BankContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const BankContainer({super.key, required this.onTap, 
  required this.label
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.c7C7C7C),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(Assets.icons.bank, height: 20.h, width: 20.w),
                UIHelper.horizontalSpace(16.w),
                Text(
                  "Bank accounts",
                  style: TextFontStyle.headline16w600c303030urbanist,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.cFFBB00,
                  ),
                  child: Text(
                    label,
                    style: TextFontStyle.headline14w600c303030urbanist.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                UIHelper.horizontalSpace(10.w),
                SvgPicture.asset(
                  Assets.icons.arrowBlack,
                  width: 7.w,
                  height: 12.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
