import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class PDRWidget extends StatelessWidget {
  final String price;
  final String delivery;
  final String reviews;
  const PDRWidget({
    super.key,
    required this.price,
    required this.delivery,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text("Price", style: TextFontStyle.headline16w500cADADADurbanist),
            UIHelper.verticalSpace(6.h),
            Text(
              price,
              style: TextFontStyle.headline16w600cFFFFFFurbanist.copyWith(
                color: AppColors.c202020,
              ),
            ),
          ],
        ),
        UIHelper.horizontalSpace(20.w),
        Column(
          children: [
            Text(
              "Delivery",
              style: TextFontStyle.headline16w500cADADADurbanist,
            ),
            UIHelper.verticalSpace(6.h),
            Text(
              delivery,
              style: TextFontStyle.headline16w600cFFFFFFurbanist.copyWith(
                color: AppColors.c202020,
              ),
            ),
          ],
        ),
        UIHelper.horizontalSpace(20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reviews", style: TextFontStyle.headline16w500cADADADurbanist),
            UIHelper.verticalSpace(6.h),
            Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.starIcon,
                  height: 14.h,
                  width: 14.w,
                ),
                UIHelper.horizontalSpace(6.w),
                Text(
                  reviews,
                  style: TextFontStyle.headline16w600cFFFFFFurbanist.copyWith(
                    color: AppColors.c202020,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
