import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/profile_model.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/profile_card.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/widget/profile_button.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/helpers_method.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  void getUserProfile() async {
    await getUserProfileRxObj.fetchUserProfile();
  }

  void logout() async {
    try {
      await postLogoutRxObj.fetchLogout().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return false;
        },
      );
      NavigationService.goBack;
    } catch (e) {
      log('Logout API error: $e');
      customToastMessage('Error', 'Logout failed. Signing out locally.');
    }

    await Future.wait([
      appData.remove(kKeyAccessToken),
      appData.remove(kKeyRefreshToken),
      appData.remove(kKeyFCMToken),
      appData.write(kKeyIsLoggedIn, false),
    ]);
    NavigationService.navigateToReplacementUntil(Routes.signinRoute);
  }

  void deleteAccount() async {
    try {
      await deleteAccountRxObj.deleteAccount().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return false;
        },
      );
      NavigationService.goBack;
    } catch (e) {
      log('Delete Account API error: $e');
      customToastMessage('Error', 'Account deletion failed. Please try again.');
    }

    await Future.wait([
      appData.remove(kKeyAccessToken),
      appData.remove(kKeyRefreshToken),
      appData.remove(kKeyFCMToken),
      appData.write(kKeyIsLoggedIn, false),
    ]);
    NavigationService.navigateToReplacementUntil(Routes.signinRoute);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {
        'title': 'Edit Profile',
        'icon': Assets.icons.profileEdit,
        'onTap': () {
          NavigationService.navigateTo(Routes.editProfileScreen);
        },
      },
      {
        'title': 'My Orders',
        'icon': Assets.icons.shoppingWhiteIcon,
        'onTap': () {
          NavigationService.navigateTo(Routes.myOrders);
        },
      },
      {
        'title': 'Saved Video',
        'icon': Assets.icons.save,
        'onTap': () {
          NavigationService.navigateTo(Routes.savedVideoScreen);
        },
      },
      {
        'title': 'Change Password',
        'icon': Assets.icons.securitySafe,
        'onTap': () {
          NavigationService.navigateTo(Routes.changePassword);
        },
      },
      {
        'title': 'Logout',
        'icon': Assets.icons.personMinus,
        'onTap': () {
          showCustomDialog(
            context: context,
            titile: 'Logout',
            subTitile: 'Are you sure you want to log out of your account?',
            confirmButtonName: 'Log Out',
            cancleButtonName: 'Cancel',
            yesTap: logout,
          );
        },
      },
      {
        'title': 'Delete Account',
        'icon': Assets.icons.personRemove,
        'onTap': () {
          showCustomDialog(
            context: context,
            titile: 'Delete Account',
            subTitile: 'Are you sure you want to delete your account?',
            confirmButtonName: 'Delete',
            confirmBorderColor: AppColors.cFF3939,
            confirmTextColor: AppColors.cFF3939,
            cancleButtonName: 'Cancel',
            yesTap: deleteAccount,
          );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextFontStyle.headline24w600c303030urbanist,
        ),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: StreamBuilder(
          stream: getUserProfileRxObj.fillData,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data?.data != null) {
              ProfileModel get = snapshot.data!;
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      // print(appData.read(kkeyUserRole));
                    },
                    child: ProfileCard(
                      name: get.data?.name ?? "Name",
                      email: get.data?.email ?? "Email",
                      profilePic: get.data?.avatar ?? kDefaultProfileImage,
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      itemBuilder: (context, index) {
                        final button = buttons[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: ProfileButton(
                            title: button['title'],
                            icon: button['icon'],
                            onTap: button['onTap'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
