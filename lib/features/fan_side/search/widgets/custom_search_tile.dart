import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CustomSearchTile extends StatelessWidget {
  final String avatar;
  final String name;
  final String category;
  final VoidCallback onTap;
  const CustomSearchTile({
    super.key,
    required this.avatar,
    required this.name,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        margin: EdgeInsets.only(bottom: 2.w),
        decoration: BoxDecoration(
          color: AppColors.cFFFFF8,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withValues(alpha: 0.1),
              offset: Offset(0, 1),
              blurRadius: 0.1.r,
              spreadRadius: 0.r,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  urls: avatar,
                  borderRadius: 100.r,
                  height: 48.h,
                  width: 48.w,
                ),
                UIHelper.horizontalSpace(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextFontStyle.headline16w500c202020urbanist
                          .copyWith(
                            color: AppColors.c303030,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      category,
                      style: TextFontStyle.headline16w500c202020urbanist
                          .copyWith(color: AppColors.cFF5C24, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(Assets.icons.crossIcon, height: 12.h, width: 12.w),
          ],
        ),
      ),
    );
  }
}
