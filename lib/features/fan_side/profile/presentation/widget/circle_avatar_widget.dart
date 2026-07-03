import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class EditableProfileImage extends StatelessWidget {
  final ValueNotifier<XFile?>? imageNotifier;
  final VoidCallback? onEditTap;
  final String fallbackImageUrl;

  const EditableProfileImage({
    super.key,
    this.imageNotifier,
    this.onEditTap,
    required this.fallbackImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (imageNotifier == null) {
      return _buildImage(null);
    }

    return ValueListenableBuilder<XFile?>(
      valueListenable: imageNotifier!,
      builder: (context, value, _) => _buildImage(value),
    );
  }

  Widget _buildImage(XFile? imageFile) {
    log("images${imageFile?.path}");
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: imageFile == null
                ? CustomNetworkImage(
                    height: 80.h,
                    width: 80.w,
                    urls: fallbackImageUrl,
                  )
                : Image.file(
                    File(imageFile.path),
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              height: 24.h,
              width: 24.w,
              padding: EdgeInsets.all(6.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cFFFFFF),
                gradient: const LinearGradient(
                  colors: [AppColors.cB87407, AppColors.cE29822],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SvgPicture.asset(Assets.icons.editPen, width: 13.w),
            ),
          ),
        ),
      ],
    );
  }
}
