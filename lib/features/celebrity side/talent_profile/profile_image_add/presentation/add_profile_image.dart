import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/common_widgets/image_picker.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/widgets/add_image_container.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/widgets/questions_container.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import '../../../../../networks/api_access.dart';

class AddProfileImage extends StatefulWidget {
  const AddProfileImage({super.key});

  @override
  State<AddProfileImage> createState() => _AddProfileImageState();
}

class _AddProfileImageState extends State<AddProfileImage> {
  bool isLoading = false;
  // ✅ শুধু ValueNotifier রাখুন, _selectedImagePath আলাদা দরকার নেই
  final ValueNotifier<XFile?> imagePath = ValueNotifier<XFile?>(null);

  void _updateAvatar() async {
    try {
      setState(() => isLoading = true);

      bool success = await updateAvatarRxObj.post(
        avatar: File(imagePath.value!.path),
      );

      if (success) {
        NavigationService.navigateTo(Routes.professionScreen);
      }
    } catch (e) {
      customToastMessage("Error", e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: "", showFilter: false),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alright, let's get your glamour shot 📸",
                style: TextFontStyle.headline24w600c303030urbanist,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "Your pic on your profile counts. A good, high quality photo will increase your chances of receiving orders.",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
              UIHelper.verticalSpace(100.h),
              ValueListenableBuilder<XFile?>(
                valueListenable: imagePath,
                builder: (context, value, _) {
                  return Column(
                    children: [
                      Center(
                        child: value == null
                            ? Image.asset(Assets.images.profile.path)
                            : ClipOval(
                                child: Image.file(
                                  File(value.path),
                                  width: 150.w,
                                  height: 150.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      UIHelper.verticalSpace(20.h),
                      Center(
                        child: AddImageContainer(
                          onTap: () =>
                              showPickImageBottomSheet(context, imagePath),
                          imagePath: value?.path,
                        ),
                      ),
                      UIHelper.verticalSpace(40.h),
                      QuestionsContainer(),
                      UIHelper.verticalSpace(30.h),
                      CustomButton(
                        onTap: value != null
                            ? () {
                                _updateAvatar();
                              }
                            : null,
                        isLoading: isLoading,
                        isActive: value != null,
                        btnName: "Continue",
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
