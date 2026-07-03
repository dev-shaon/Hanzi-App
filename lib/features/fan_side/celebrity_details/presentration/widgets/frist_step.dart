import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class FristStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatar;
  final VoidCallback? onTap;
  final bool? isFollow;
  final bool? isLoading;
  final String? tierIcon;

  const FristStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatar,
    this.onTap,
    this.isFollow,
    this.isLoading,
    this.tierIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: CustomNetworkImage(
                      urls: avatar,
                      height: 60.h,
                      width: 60.w,
                    ),
                  ),
                  if (tierIcon != null)
                    Positioned(
                      top: -2.h,
                      right: -12.w,
                      child: SvgPicture.asset(tierIcon!),
                    ),
                ],
              ),
              UIHelper.horizontalSpace(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      title,
                      style: TextFontStyle.headline20w600c303030urbanist,
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      subtitle,
                      style: TextFontStyle.headline16w500c202020urbanist
                          .copyWith(color: AppColors.cFF5C24),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              : isFollow == true
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    border: Border.all(color: AppColors.c7C7C7C),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "Unfollow",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.cFF5C24,
                  ),
                  child: Text(
                    "Follow",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
