import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

class IconsContainer extends StatelessWidget {
  const IconsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFF8,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.cEAEAEA),
        boxShadow: [
          BoxShadow(
            color: AppColors.c000000.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.walletScreen);
            },
            child: SvgPicture.asset(
              Assets.icons.wallet,
              width: 22.w,
              height: 26.h,
            ),
          ),
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.celebrityTrofiScreen);
            },
            child: SvgPicture.asset(
              Assets.icons.trophyThreeStar,
              width: 22.w,
              height: 26.h,
            ),
          ),
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.notificationScreen);
            },
            child: SvgPicture.asset(
              Assets.icons.yollowNotification,
              width: 22.w,
              height: 26.h,
            ),
          ),
        ],
      ),
    );
  }
}
