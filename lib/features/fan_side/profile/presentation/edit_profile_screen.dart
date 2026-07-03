import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/image_picker.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/profile_model.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/widget/edit_profile_card.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

import '../../../../common_widgets/custom_toast.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  File? _selectedImageFile;
  final ValueNotifier<XFile?> imagePath = ValueNotifier<XFile?>(null);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  void getUserProfile() async {
    await getUserProfileRxObj.fetchUserProfile();
  }

  void _updateProfile() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      bool success = await updateProfileRxObj.editProfile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        image: imagePath.value != null ? File(imagePath.value!.path) : null,
      );

      if (success) {
        await getUserProfileRxObj.fetchUserProfile();
        if (mounted) {
          customToastMessage("Success", "Profile updated successfully");
          NavigationService.goBack;
        }
      }
    } catch (e) {
      if (mounted) {
        customToastMessage("Error", e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          title: "Profile",
          showFilter: false,
          ontap: () {
            NavigationService.goBack;
            getUserProfile();
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
          child: StreamBuilder(
            stream: getUserProfileRxObj.fillData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                      SizedBox(height: 12.h),
                      const Text("Failed to load profile. Please try again."),
                    ],
                  ),
                );
              }

              if (snapshot.hasData && snapshot.data?.data != null) {
                ProfileModel get = snapshot.data!;

                if (nameController.text.isEmpty) {
                  nameController.text = get.data!.name ?? "";
                }
                if (emailController.text.isEmpty) {
                  emailController.text = get.data!.email ?? "";
                }
                if (phoneController.text.isEmpty) {
                  phoneController.text = get.data?.profile?.phone ?? "";
                }

                return Column(
                  children: [
                    UIHelper.verticalSpace(30.h),
                    EditProfileCard(
                      imageNotifier: imagePath,
                      name: get.data!.name ?? "name",
                      email: get.data!.email ?? "email",
                      onTap: () {
                        showPickImageBottomSheet(context, imagePath);
                        log("Clickable");
                        imagePath.addListener(() {
                          log("Image updated: ${imagePath.value?.path}");
                        });
                      },
                      profilePic:
                          _selectedImageFile?.path ??
                          get.data?.avatar ??
                          kDefaultProfileImage,
                      isLocalImage: _selectedImageFile != null,
                    ),
                    UIHelper.verticalSpace(20.h),
                    CustomFormField(
                      controller: nameController,
                      prefixIcon: SvgPicture.asset(Assets.icons.person),
                      hintText: get.data!.name ?? "name",
                    ),
                    UIHelper.verticalSpace(12.h),
                    CustomFormField(
                      controller: emailController,
                      isRead: true,
                      prefixIcon: SvgPicture.asset(Assets.icons.emailIcon),
                      hintText: get.data!.email ?? "email",
                    ),
                    UIHelper.verticalSpace(12.h),
                    CustomFormField(
                      controller: phoneController,
                      prefixIcon: SvgPicture.asset(Assets.icons.phone),
                      hintText:
                          get.data?.profile?.phone ?? "Enter phone number...",
                    ),
                    UIHelper.verticalSpace(40.h),
                    CustomButton(
                      onTap: () {
                        _updateProfile();
                      },
                      btnName: "Save",
                      isLoading: isLoading,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      ),
    );
  }
}
