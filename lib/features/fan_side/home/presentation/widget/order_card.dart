import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class OrderCard extends StatelessWidget {
  final String price;
  final String text;
  final VoidCallback? onTap;
  const OrderCard({
    super.key,
    required this.price,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.cFCF5E9,
          border: Border.all(color: AppColors.cF6DFBA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.setPrice.path),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 8.r,
                  top: 10.r,
                  bottom: 10.r,
                  left: 2.r,
                ),
                child: Text(
                  price,
                  style: TextFontStyle.headline10w700cFFFFFFurbanist,
                ),
              ),
            ),

            UIHelper.horizontalSpace(8.w),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.headline16w600c303030urbanist,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
