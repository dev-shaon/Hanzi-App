import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CategoryCard extends StatelessWidget {
  final String text;
  final String imageurls;
  final VoidCallback? onTap;
  const CategoryCard({
    super.key,
    required this.text,
    required this.onTap,
    required this.imageurls,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.cFCF5E9,
          border: Border.all(color: AppColors.cF6DFBA),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.headline16w600c303030urbanist,
              ),
            ),
            UIHelper.horizontalSpace(10.w),
            Flexible(
              flex: 2,
              child: CustomNetworkImage(
                urls: imageurls,
                height: 80.h,
                width: 80.w,
                placeholder: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
