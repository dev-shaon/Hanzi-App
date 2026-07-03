import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';

class FollowingList extends StatelessWidget {
  final String name;
  final String role;
  final String avatar;
  final void Function()? onTap;
  final bool? isLoading;
  const FollowingList({
    super.key,
    required this.name,
    required this.role,
    required this.avatar,
    this.onTap,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomNetworkImage(
                urls: avatar,
                width: 48.h,
                height: 48.h,
                borderRadius: 50.r,
              ),
              UIHelper.horizontalSpace(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextFontStyle.headline16w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    role,
                    style: TextFontStyle.headline14w500cFF5C24urbanist,
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: (isLoading ?? false) ? null : onTap,
            child: (isLoading ?? false)
                ? Container(
                    width: 18.w,
                    height: 18.h,
                    margin: EdgeInsets.only(right: 20.w),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.cFF5C24,
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      border: Border.all(color: AppColors.c7C7C7C),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Unfollow",
                      style: TextFontStyle.headline16w500c7C7C7Curbanist,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
