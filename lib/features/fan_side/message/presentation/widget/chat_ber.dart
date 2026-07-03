import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ChatBer extends StatelessWidget {
  final String name;
  final String avatar;
  final bool isOnline;
  final bool isTyping;

  const ChatBer({
    super.key,
    this.name = '',
    this.avatar = '',
    this.isOnline = false,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            NavigationService.goBack;
          },
          child: SvgPicture.asset(
            Assets.icons.arrowBack,
            height: 24.h,
            width: 24.w,
          ),
        ),
        UIHelper.horizontalSpace(12.w),
        CustomNetworkImage(
          urls: avatar.isNotEmpty ? avatar : kDefaultProfileImage,
          height: 40.h,
          borderRadius: 50.r,
          width: 40.w,
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: AppColors.c34A853,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        UIHelper.horizontalSpace(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.isNotEmpty ? name : '...',
                style: TextFontStyle.headline14w600c303030urbanist,
                overflow: TextOverflow.ellipsis,
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                isTyping
                    ? 'typing...'
                    : isOnline
                    ? 'Online'
                    : 'Offline',
                style: TextFontStyle.headline12w500c7C7C7CCurbanist.copyWith(
                  color: isTyping || isOnline ? AppColors.c34A853 : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
