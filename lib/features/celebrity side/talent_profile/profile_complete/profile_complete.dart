import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profile_complete/widget/profile_con.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/profile_model.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

import '../../../../networks/api_access.dart';

class ProfileComplete extends StatefulWidget {
  const ProfileComplete({super.key});

  @override
  State<ProfileComplete> createState() => _ProfileCompleteState();
}

class _ProfileCompleteState extends State<ProfileComplete> {
  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  void getUserProfile() async {
    await getUserProfileRxObj.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: StreamBuilder(
            stream: getUserProfileRxObj.fillData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Error loading profile"));
              }
              ProfileModel get = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(48.h),
                  Text(
                    "Profile complete! 🎉",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Congrats! You are now ready to start receiving orders. The best way to receive new orders is by sharing these ready to use images to your social media accounts.",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist,
                  ),
                  UIHelper.verticalSpace(73.h),
                  Center(
                    child: ProfileCon(
                      name: get.data?.name ?? "Unknown",
                      avatarUrl: get.data?.avatar ?? "",
                    ),
                  ),
                  UIHelper.verticalSpace(80.h),
                  CustomButton(
                    onTap: () {
                      NavigationService.navigateTo(Routes.celebrityNavber);
                    },
                    btnName: "Share",
                  ),
                  UIHelper.verticalSpace(20.h),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.celebrityNavber);
                      },
                      child: Text(
                        "I’ll promote later",
                        style: TextFontStyle.headline16w600c303030urbanist
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
