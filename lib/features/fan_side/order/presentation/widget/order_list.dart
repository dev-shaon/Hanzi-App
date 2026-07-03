import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

import '../../../../../common_widgets/custom_network_image.dart';
import '../../../../../helpers/ui_helpers.dart';

class OrderList extends StatelessWidget {
  final String name;
  final String role;
  final String amount;
  final String status;
  final String image;
  final VoidCallback? onTap;

  const OrderList({
    super.key,
    required this.name,
    required this.role,
    required this.amount,
    required this.status,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 2.w),
        decoration: BoxDecoration(
          color: AppColors.cFFFFF8,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withValues(alpha: 0.1),
              offset: Offset(0, 1),
              blurRadius: 0.1,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Name + Avatar (flex নেয়, বাকি দুটোকে push করে না) ──
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  CustomNetworkImage(
                    urls: image,
                    borderRadius: 100.r,
                    height: 48.h,
                    width: 48.w,
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextFontStyle.headline16w500c202020urbanist
                          .copyWith(
                            color: AppColors.c303030,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Amount (fixed width) ──
            SizedBox(
              width: 80.w,
              child: Text(
                amount,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                  color: AppColors.c303030,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // ── Status (fixed width) ──
            SizedBox(
              width: 70.w,
              child: Text(
                status,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                  color:
                      status.toLowerCase() == 'canceled' ||
                          status.toLowerCase() == 'cancel'
                      ? AppColors.cE92F48
                      : status.toLowerCase() == 'completed'
                      ? AppColors.c34A853
                      : AppColors.cFF5C24,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
