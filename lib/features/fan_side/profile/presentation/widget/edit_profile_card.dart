import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/widget/circle_avatar_widget.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class EditProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String profilePic;
  final bool isLocalImage;
  final VoidCallback? onTap;
  final ValueNotifier<XFile?> imageNotifier;

  const EditProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.profilePic,
    this.isLocalImage = false,
    this.onTap,
    required this.imageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 335.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.cFFFFF8,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.c7C7C7C),
            ),
            child: Column(
              children: [
                UIHelper.verticalSpace(20.h),
                Text(
                  name,
                  style: TextFontStyle.headline20w500c303030urbanist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  email,
                  style: TextFontStyle.headline14w300c7C7C7Curbanist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Positioned(
            top: -45,
            left: 0,
            right: 0,
            child: Center(
              child: EditableProfileImage(
                imageNotifier: imageNotifier,
                onEditTap: onTap,
                fallbackImageUrl: imageNotifier.value?.path ?? profilePic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
