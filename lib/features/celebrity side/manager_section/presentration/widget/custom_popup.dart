import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  // final VoidCallback onDone;

  const CustomPopup({
    super.key,
    required this.title,
    required this.message,
    // required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: SvgPicture.asset(Assets.icons.orangeConfirmation),),
            UIHelper.verticalSpace(16.h),
            Text(
              title,
              style: TextFontStyle.headline20w600c202020urbanist.copyWith(color: AppColors.cE85421),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextFontStyle.headline14w400cADADADurbanist,
            ),
            UIHelper.verticalSpace(20.h),
            // CustomButton(
            //   onTap: onDone,
            //   btnName: "Done",
            // ),
          ],
        ),
      ),
    );
  }
}
