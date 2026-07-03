import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class InboxInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool hasText;
  final VoidCallback onSend;
  final VoidCallback onPickMedia;

  const InboxInputBar({
    super.key,
    required this.controller,
    required this.hasText,
    required this.onSend,
    required this.onPickMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.cFCF5E9,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.c303030.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              minLines: 1,
              style: TextStyle(fontSize: 14.sp, color: AppColors.c303030),
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.c7C7C7C),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
          if (!hasText) ...[
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                onTap: onPickMedia,
                child: SvgPicture.asset(
                  Assets.icons.fileIcon,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.c5F400E,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            UIHelper.horizontalSpace(16.w),
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                onTap: onPickMedia,
                child: SvgPicture.asset(
                  Assets.icons.cameraIcon,
                  height: 20.h,
                  width: 20.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.c5F400E,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
          if (hasText)
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: GestureDetector(
                onTap: onSend,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: const BoxDecoration(
                    color: AppColors.cFF5C24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.send, color: Colors.white, size: 18.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
