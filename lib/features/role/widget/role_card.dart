import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class RoleCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;

  const RoleCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.w,
        height: 126.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cFFCCBB : AppColors.cFFEFE9,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.cFF5C24 : AppColors.cFFCCBB,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              isSelected
                  ? Assets.icons.underCircle
                  : Assets.icons.circle,
            ),
            UIHelper.verticalSpace(32.h),
            Center(
              child: Text(
                title,
                style: TextFontStyle.headline20w600c202020urbanist,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
