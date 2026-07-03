import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String profilePic;
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 335.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.cFFFFF8,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.c7C7C7C),
            ),
            child: Column(
              children: [
                UIHelper.verticalSpace(20.h),
                Text(name, style: TextFontStyle.headline20w500c303030urbanist),
                UIHelper.verticalSpace(4.h),
                Text(email, style: TextFontStyle.headline14w300c7C7C7Curbanist),
              ],
            ),
          ),

          Positioned(
            top: -40.h,
            left: 0.w,
            right: 0.w,
            child: Center(
              child: CustomNetworkImage(
                borderRadius: 100.r,
                urls: profilePic,
                height: 80.h,
                width: 80.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
