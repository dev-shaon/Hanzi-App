import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ConnectWidget extends StatelessWidget {
  final VoidCallback? messageOnTap;
  final VoidCallback? followOnTap;
  const ConnectWidget({super.key, this.messageOnTap, this.followOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.cFCF5E9,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cC7C7C7),
      ),
      child: Column(
        children: [
          Text(
            "Other ways to connect",
            style: TextFontStyle.headline20w600c303030urbanist,
          ),
          UIHelper.verticalSpace(16.h),
          GestureDetector(onTap: messageOnTap,child: Button(text: 'Send a message \$2.99')),
          UIHelper.verticalSpace(12.h),
          GestureDetector(
            onTap: followOnTap,
            child: Button(
              icons: Assets.icons.bNotification,
              text: 'Follow for updates',
              color: AppColors.c303030,
              style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                color: AppColors.cFFFFFF,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final String? icons;
  final Color? color;
  final TextStyle? style;
  final VoidCallback? onTap;

  const Button({
    super.key,
    required this.text,
    this.icons,
    this.color,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 62.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.cF6DFBA,
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: AppColors.cC7C7C7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icons != null) ...[
              SvgPicture.asset(icons!, width: 20.w, height: 20.h),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: style ?? TextFontStyle.headline16w500c202020urbanist,
            ),
          ],
        ),
      ),
    );
  }
}
