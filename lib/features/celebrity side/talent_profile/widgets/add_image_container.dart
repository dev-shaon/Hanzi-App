import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class AddImageContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String? imagePath;

  const AddImageContainer({super.key, required this.onTap, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.cC7C7C7),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 11.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.icons.addIcon),
              UIHelper.horizontalSpace(8.w),
              Text(
                imagePath == null ? "Add photo" : "Replace photo",
                style: TextFontStyle.headline16w600c303030urbanist,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
