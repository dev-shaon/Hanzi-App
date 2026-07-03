import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CelebrityProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String profilePic;
  final bool isEditProfile;
  final VoidCallback? onTap;
  const CelebrityProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.profilePic,
    this.isEditProfile = false,
    this.onTap,
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
            top: -40,
            left: 150,
            child: Stack(
              children: [
                ClipOval(child: CustomNetworkImage(urls: profilePic)),
                Positioned(
                  bottom: 0,
                  right: -2,
                  child: isEditProfile
                      ? GestureDetector(
                          onTap: onTap,
                          child: Container(
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.cFFFFFF,
                                width: 2,
                              ),
                              gradient: LinearGradient(
                                colors: [AppColors.cB87407, AppColors.cE29822],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(Assets.icons.editPen),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
