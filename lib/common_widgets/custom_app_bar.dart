import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showFilter;
  final VoidCallback? ontap;
  final VoidCallback? onFilterTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showFilter = true,
    this.ontap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ontap ?? () => NavigationService.goBack,
            child: SvgPicture.asset(
              Assets.icons.arrowBack,
              height: 24.h,
              width: 24.w,
            ),
          ),
          Text(title, style: TextFontStyle.headline24w600c303030urbanist),
          showFilter
              ? InkWell(
                  onTap: onFilterTap,
                  child: SvgPicture.asset(
                    Assets.icons.filterIcon,
                    height: 24.h,
                    width: 24.w,
                  ),
                )
              : UIHelper.horizontalSpace(24.w),
        ],
      ),
    );
  }
}
