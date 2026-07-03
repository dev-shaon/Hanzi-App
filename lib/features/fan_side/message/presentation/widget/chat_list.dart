import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ChatList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String mini;
  final String? load;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ChatList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.mini,
    this.load,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 29.r,
              backgroundColor: AppColors.c34A853,
              child: CustomNetworkImage(
                urls: imageUrl ?? '',
                borderRadius: 27,
                height: 52.h,
                width: 52.w,
              ),
            ),
            UIHelper.horizontalSpace(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextFontStyle.headline14w600c303030urbanist,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        mini,
                        style: TextFontStyle.headline10w500c303030urbanist,
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(4.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          style: TextFontStyle.headline12w500c7C7C7CCurbanist,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      load != null
                          ? CircleAvatar(
                              backgroundColor: AppColors.cFF5C24,
                              radius: 10.r,
                              child: Text(
                                load!,
                                style: TextFontStyle
                                    .headline10w500c303030urbanist
                                    .copyWith(color: AppColors.cFFFFFF),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
