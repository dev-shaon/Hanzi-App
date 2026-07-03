import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ListCreatorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tstar;
  final String hour;
  final String price;
  final String icon;
  final VoidCallback onTap;
  final String avatar;

  const ListCreatorCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tstar,
    required this.hour,
    required this.price,
    required this.icon,
    required this.avatar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 155.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Stack(
                children: [
                  CustomNetworkImage(urls: avatar, height: 129.h, width: 155.w),
                  Positioned(
                    top: 4.h,
                    right: 2.w,
                    child: SvgPicture.asset(icon),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(8.h),

            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextFontStyle.headline16w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(3.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextFontStyle.headline14w500cFF5C24urbanist,
                  ),
                  UIHelper.verticalSpace(6.h),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.starIcon),
                      UIHelper.horizontalSpace(4.h),
                      Text(
                        tstar,
                        style: TextFontStyle.headline12w500c7C7C7CCurbanist,
                      ),
                      UIHelper.horizontalSpace(12.h),
                      SvgPicture.asset(Assets.icons.current),
                      UIHelper.horizontalSpace(4.h),
                      Text(
                        hour,
                        style: TextFontStyle.headline12w500c7C7C7CCurbanist,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    price,
                    style: TextFontStyle.headline14w600c303030urbanist,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
