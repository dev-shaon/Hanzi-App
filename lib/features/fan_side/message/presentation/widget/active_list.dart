import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ActiveList extends StatelessWidget {
  final String text;
  final String? imageUrl;
  const ActiveList({super.key, required this.text, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.c34A853, width: 2.w),
          ),
          child: ClipOval(
            child: CustomNetworkImage(
              urls: imageUrl ?? '',
              height: 60.h,
              width: 60.w,
            ),
          ),
        ),

        UIHelper.verticalSpace(8.h),

        Text(
          text,
          style: TextFontStyle.headline12w400c303030urbanist.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
