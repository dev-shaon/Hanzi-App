import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class HomeBer extends StatelessWidget {
  const HomeBer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(Assets.images.logo.path, width: 78.w, height: 29.h),
        Row(
          children: [
            InkWell(
              onTap: () {
                NavigationService.navigateTo(Routes.notificationScreen);
              },
              child: SvgPicture.asset(
                Assets.icons.notification,
                height: 20.h,
                width: 20.w,
              ),
            ),
            UIHelper.horizontalSpace(12.w),
            InkWell(
              onTap: () {
                NavigationService.navigateTo(Routes.orderScreen);
              },
              child: SvgPicture.asset(
                Assets.icons.shoppingIcon,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
