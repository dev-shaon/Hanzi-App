import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

void showPickImageBottomSheet(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier, {
  bool showCameraOption = true,
}) {
  // final textTheme = Theme.of(
  //   context,
  // ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),

    // showDragHandle: false,
    context: context,
    builder: (BuildContext context) => Container(
      padding: EdgeInsets.all(24.sp),
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              selectImageFromCamera(context, imageFileNotifier);
              NavigationService.goBack;
            },
            child: Row(
              spacing: 16.w,
              children: [
                SvgPicture.asset(Assets.icons.cameraPicker, width: 24.w),
                Text(
                  "Take a Photo",
                  style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),

          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              selectImageFromGallery(context, imageFileNotifier);
              NavigationService.goBack;
            },
            child: Row(
              spacing: 16.w,
              children: [
                SvgPicture.asset(Assets.icons.camera, width: 24.w),
                Text(
                  "Choose from Album",
                  style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> selectImageFromCamera(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    imageFileNotifier.value = pickedFile;
  }
  // Collapse the modal popup menu for hiding bottom sheet
  if (context.mounted) {
    Navigator.pop(context);
  }
}

Future<void> selectImageFromGallery(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    imageFileNotifier.value = pickedFile;
    // Collapse the modal popup menu for hiding bottom sheet
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({super.key, required this.name, required this.style});

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.sp),
      child: Text(name, style: style.copyWith(letterSpacing: 1.0)),
    );
  }
}


// imagePickerDialog(BuildContext context, ValueNotifier<File?> imageNotifier) {
//   return showModalBottomSheet(
//     showDragHandle: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20.r),
//       ),
//     ),
//     context: context,
//     builder: (_) => Container(
//       height: 90.h,
//       padding: EdgeInsets.symmetric(
//         horizontal: 20.w,
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.pop(context);
//               pickImage(imageNotifier, ImageSource.camera);
//             },
//             child: Row(
//               children: [
//                 SvgPicture.asset(Assets.icons.add1),
//                 UIHelper.horizontalSpaceSmall,
//                 Text(
//                   "Take a Photo".tr,
//                   style: TextFontStyle.headline12w400cA5A5A5Poppins,
//                 ),
//               ],
//             ),
//           ),
//           UIHelper.verticalSpace(16.h),
//           InkWell(
//             onTap: () {
//               NavigationService.goBack;
//               pickImage(imageNotifier, ImageSource.gallery);
//             },
//             child: Row(
//               children: [
//                 SvgPicture.asset(
//                   Assets.icons.call,
//                 ),
//                 UIHelper.horizontalSpaceSmall,
//                 Text(
//                   "Choose from Album".tr,
//                   style: TextFontStyle.headline12w400cA5A5A5Poppins,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
// Future<void> pickImage(
//   ValueNotifier<File?> imageNotifier,
//   ImageSource source,
// ) async {
//   final ImagePicker picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: source);

//   if (pickedFile != null) {
//     imageNotifier.value = File(pickedFile.path); // Update the ValueNotifier
//   }
// }