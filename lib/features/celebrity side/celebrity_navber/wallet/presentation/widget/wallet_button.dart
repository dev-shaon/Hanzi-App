import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

class WalletButton extends StatelessWidget {
  final VoidCallback onTapBank;
  final bool showAddBank;
  const WalletButton({
    super.key,
    required this.onTapBank,
    this.showAddBank = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          showAddBank ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
      children: [
        if (showAddBank)
          GestureDetector(
            onTap: onTapBank,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.cBF0707, AppColors.cFF5C24],
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                'Add bank',
                style: TextFontStyle.headline16w600cFFFFFFurbanist,
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            NavigationService.navigateTo(Routes.earnActivityScreen);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.c7C7C7C),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              'Activitys',
              style: TextFontStyle.headline16w600cFFFFFFurbanist.copyWith(
                color: AppColors.c303030,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
