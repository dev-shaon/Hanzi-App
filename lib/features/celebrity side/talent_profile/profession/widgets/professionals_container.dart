import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ProfessionalsContainer extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String profession;
  const ProfessionalsContainer({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          urls: imageUrl,
          borderRadius: 16,
          height: 145.h,
          width: 145.w,
        ),

        UIHelper.verticalSpace(8.h),

        Text(name, style: TextFontStyle.headline16w600c303030urbanist),

        UIHelper.verticalSpace(4.h),

        Text(profession, style: TextFontStyle.headline14w500cFF5C24urbanist),
      ],
    );
  }
}
