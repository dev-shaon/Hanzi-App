import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_profile/presentation/widget/celebrity_profile_card.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

import '../../model/celebrity_profile_model.dart';

class CelebrityEditProfile extends StatefulWidget {
  const CelebrityEditProfile({super.key});

  @override
  State<CelebrityEditProfile> createState() => _CelebrityEditProfileState();
}

class _CelebrityEditProfileState extends State<CelebrityEditProfile> {
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCelebrityProfile();
  }

  void _getCelebrityProfile() async {
    await getCelebrityProfileRxObj.fetchCelebrityProfile();
  }

  void _updateProfile() async {
    try {
      isLoading = true;
      bool success = await updateProfileRxObj.editProfile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        // avatar: _selectedImagePath != null ? File(_selectedImagePath!) : null,
      );
      if (success) {
        customToastMessage("Success", "Profile updated successfully");
        NavigationService.goBack;
      }
    } catch (e) {
      customToastMessage("Error", e.toString());
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(title: "Profile", showFilter: false),
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
            stream: getCelebrityProfileRxObj.fillData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              CelebrityProfileModel get = snapshot.data!;
              return Column(
                children: [
                  UIHelper.verticalSpace(40.h),
                  CelebrityProfileCard(
                    name: get.data?.name ?? '',
                    email: get.data?.email ?? '',
                    isEditProfile: true,
                    onTap: () {},
                    profilePic:
                        get.data?.avatar ??
                        kDefaultProfileImage,
                  ),
                  UIHelper.verticalSpace(20.h),
                  CustomFormField(
                    controller: nameController,
                    prefixIcon: SvgPicture.asset(Assets.icons.person),
                    hintText: get.data?.name ?? '',
                  ),
                  UIHelper.verticalSpace(12.h),

                  CustomFormField(
                    controller: emailController,
                    prefixIcon: SvgPicture.asset(Assets.icons.emailIcon),
                    hintText: get.data?.email ?? '',
                  ),
                  UIHelper.verticalSpace(12.h),

                  CustomFormField(
                    controller: phoneController,
                    prefixIcon: SvgPicture.asset(Assets.icons.phone),
                    hintText:
                        get.data?.profile?.phone ?? 'Enter your number.....',
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
            },
          ),
        ),
      ),
      ),
    );
  }
}
