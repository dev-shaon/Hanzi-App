import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ProfileCon extends StatelessWidget {
  final String name;
  final String avatarUrl;
  const ProfileCon({super.key, required this.name, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cFFFFFF,
        border: Border.all(color: AppColors.cC7C7C7),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                "Get personalized videos",
                style: TextFontStyle.headline20w600c303030urbanist,
              ),

              UIHelper.verticalSpace(16.h),

              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.cFFFFF8,
                  border: Border.all(color: AppColors.cC7C7C7),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.c515978.withValues(alpha: 0.2),
                      ),
                      child: ClipOval(
                        child: CustomNetworkImage(
                          urls: avatarUrl,
                          height: 98.h,
                          width: 98.w,
                        ),
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    Text(
                      name,
                      style: TextFontStyle.headline16w500c202020urbanist
                          .copyWith(color: AppColors.c303030),
                    ),

                    UIHelper.verticalSpace(4.h),

                    Text(
                      "New to Hanzi 👋",
                      style: TextFontStyle.headline14w500cFF5C24urbanist,
                    ),
                  ],
                ),
              ),

              UIHelper.verticalSpace(16.h),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.icons.fileIcon),
                  UIHelper.horizontalSpace(6.w),
                  Text(
                    "Click the link",
                    style: TextFontStyle.headline20w600c303030urbanist,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  SvgPicture.asset(Assets.icons.downGreen),
                ],
              ),
            ],
          ),

          Positioned(
            left: -2,
            bottom: 40,
            child: SvgPicture.asset(Assets.icons.redLight),
          ),

          Positioned(
            right: -2,
            top: 46,
            child: SvgPicture.asset(Assets.icons.blueLight),
          ),
        ],
      ),
    );
  }
}
