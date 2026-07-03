import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class FirstOrderBottomSheet extends StatelessWidget {
  final String avatar;
  final String name;

  const FirstOrderBottomSheet({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),

            UIHelper.verticalSpace(20.h),

            Text(
              "Get your first order",
              style: TextFontStyle.headline20w600c303030urbanist,
            ),

            UIHelper.verticalSpace(8.h),

            Text(
              "Share your Cameo profile link 5 times to maximize receiving your first order.",
              style: TextFontStyle.headline16w500cADADADurbanist,
            ),

            UIHelper.verticalSpace(20.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.cC7C7C7),
                color: AppColors.cFFFFFF,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Assets.icons.light),
                      UIHelper.horizontalSpace(8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pro tip",
                              style:
                                  TextFontStyle.headline18w600c303030urbanist,
                            ),
                            UIHelper.verticalSpace(4.h),
                            Text(
                              "Add your Cameo profile link directly to your social media bios so fans can find it easily,",
                              style:
                                  TextFontStyle.headline16w500cADADADurbanist,
                            ),
                            UIHelper.verticalSpace(4.h),
                            Text(
                              "Copy this link",
                              style: TextFontStyle.headline16w500cADADADurbanist
                                  .copyWith(
                                    color: AppColors.c303030,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(20.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.cC7C7C7),
                color: AppColors.cFFFFFF,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.icons.twoInto),
                      UIHelper.horizontalSpace(8.w),
                      Expanded(
                        child: Text(
                          "Talent who post about Cameo on social media get 2x more orders.",
                          style: TextFontStyle.headline16w500cADADADurbanist,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            UIHelper.verticalSpace(20.h),
            Text(
              "Share the post",
              style: TextFontStyle.headline16w500cADADADurbanist.copyWith(
                color: AppColors.c303030,
              ),
            ),
            UIHelper.verticalSpace(8.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.cC7C7C7),
                color: AppColors.cFFFFFF,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.cFFFFF8,
                      border: Border.all(color: AppColors.cC7C7C7),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(7.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.c515978.withValues(alpha: 0.2),
                          ),
                          child: ClipOval(
                            child: CustomNetworkImage(
                              urls: avatar,
                              height: 48.h,
                              width: 48.w,
                              
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          name,
                          style: TextFontStyle.headline10w500c303030urbanist,
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          " New to Hanzi 👋",
                          style: TextFontStyle.headline14w500cFF5C24urbanist
                              .copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.horizontalSpace(6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Share the post",
                          style: TextFontStyle.headline16w600c303030urbanist,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          "Spread the word! Let your fans know that you're officially on Hanzi.",
                          style: TextFontStyle.headline14w500cFF5C24urbanist
                              .copyWith(color: AppColors.c7C7C7C),
                          textAlign: TextAlign.start,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          "Share",
                          style: TextFontStyle.headline14w500cFF5C24urbanist
                              .copyWith(
                                color: AppColors.c303030,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
