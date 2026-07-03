import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class Reviews extends StatelessWidget {
  final String name;
  final String rating;
  final String date;
  final String reviewText;
  final String? avatar;

  const Reviews({
    super.key,
    required this.name,
    required this.rating,
    required this.date,
    required this.reviewText,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    int starCount = 0;
    try {
      starCount = double.parse(rating).floor();
    } catch (_) {}

    return Container(
      width: 250.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        border: Border.all(color: AppColors.cC7C7C799),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextFontStyle.headline14w600c303030urbanist,
                ),
              ),
              UIHelper.horizontalSpace(8.w),
              Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: SvgPicture.asset(
                      Assets.icons.starIcon,
                      height: 14.h,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(
                        index < starCount
                            ? Colors.orange
                            : Colors.grey.shade300,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Expanded(
            child: Text(
              reviewText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextFontStyle.headline14w300c7C7C7Curbanist.copyWith(
                color: AppColors.c303030,
              ),
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            date,
            style: TextFontStyle.headline14w500cFF5C24urbanist.copyWith(
              color: AppColors.c7C7C7C,
            ),
          ),
        ],
      ),
    );
  }
}
