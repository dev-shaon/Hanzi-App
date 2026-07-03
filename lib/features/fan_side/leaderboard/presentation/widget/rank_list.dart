import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/model/leaderboard_model.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class RankList extends StatelessWidget {
  final Datum datum;
  final bool isHighlighted;

  const RankList({super.key, required this.datum, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    const highlightColor = Color(0xFFFF5F44);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: isHighlighted
            ? highlightColor.withValues(alpha: 0.1)
            : AppColors.cFFFFFF,
        border: isHighlighted
            ? Border.all(color: highlightColor, width: 1.5)
            : null,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(
                color: isHighlighted ? highlightColor : AppColors.c8E98A8,
              ),
            ),
            child: Text(
              "${datum.rank ?? ''}",
              style: TextFontStyle.headline16w600c303030urbanist.copyWith(
                color: isHighlighted ? highlightColor : AppColors.c8E98A8,
              ),
            ),
          ),
          UIHelper.horizontalSpace(12.w),
          Container(
            decoration: isHighlighted
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: highlightColor, width: 2.5),
                  )
                : null,
            child: ClipOval(
              child: CustomNetworkImage(
                urls: datum.avatar ?? '',
                height: 52.h,
                width: 52.w,
              ),
            ),
          ),
          UIHelper.horizontalSpace(16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                datum.name ?? '',
                style: TextFontStyle.headline16w600c303030urbanist.copyWith(
                  color: isHighlighted ? highlightColor : AppColors.c303030,
                ),
              ),
              UIHelper.verticalSpace(6.w),
              Row(
                children: List.generate(5, (index) {
                  final rating = datum.averageRating ?? 0;
                  return Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: SvgPicture.asset(
                      index < rating
                          ? Assets.icons.starIcon
                          : Assets.icons.whiteStar,
                      height: 8.h,
                      width: 8.w,
                    ),
                  );
                }),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                "${datum.averageRating ?? 0}.0 (Total review ${datum.totalReviews ?? 0})",
                style: TextFontStyle.headline12w500c7C7C7CCurbanist.copyWith(
                  color: AppColors.c303030,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
