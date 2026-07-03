import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class MeetingsButton extends StatelessWidget {
  const MeetingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 50.w),
        decoration: BoxDecoration(
          color: AppColors.cFF3939,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.meetingCamra),
            UIHelper.horizontalSpace(10.w),
            Text(
              "Schedule a Meetings",
              style: TextFontStyle.headline20w600c303030urbanist.copyWith(
                color: AppColors.cFFFFFF,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
