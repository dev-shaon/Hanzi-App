import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ContinuePopup extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showButtons;
  final String? positiveText;
  final String? negativeText;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;
  final bool showIcon;

  const ContinuePopup({
    super.key,
    required this.title,
    required this.subtitle,
    this.showButtons = false,
    this.positiveText,
    this.negativeText,
    this.onPositiveTap,
    this.onNegativeTap,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cFFFFF8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.all(20.w),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (showIcon) ...[
                SvgPicture.asset(Assets.icons.questionIcon),
                UIHelper.horizontalSpace(8.w),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextFontStyle.headline18w600c303030urbanist,
                ),
              ),
            ],
          ),

          UIHelper.verticalSpace(8.h),

          Text(
            subtitle,
            // textAlign: TextAlign.center,
            style: TextFontStyle.headline16w500c7C7C7Curbanist,
          ),

          if (showButtons) ...[
            UIHelper.verticalSpace(20.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap:
                        onNegativeTap ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.cFFFFFF,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.cC7C7C7),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        negativeText ?? "Cancel",
                        style: TextFontStyle.headline14w600c303030urbanist,
                      ),
                    ),
                  ),
                ),

                UIHelper.horizontalSpace(12.w),

                Expanded(
                  child: GestureDetector(
                    onTap: onPositiveTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.cFFFFFF,
                        border: Border.all(color: AppColors.cC7C7C7),

                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        positiveText ?? "Continue",
                        style: TextFontStyle.headline14w600c303030urbanist,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
