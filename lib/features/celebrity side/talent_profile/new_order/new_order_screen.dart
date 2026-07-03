import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/pop_up.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(
          title: "",
          showFilter: false,
          ontap: () {
            NavigationService.navigateTo(Routes.newOrderScreen);
          },
        ),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Never miss a new order!",
                style: TextFontStyle.headline24w600c303030urbanist,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "Get reminders for new orders by allowing Cameo to notify you.",
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
              UIHelper.verticalSpace(120.h),
              Center(child: Image.asset(Assets.images.phoneOrder.path)),
              UIHelper.verticalSpace(130.h),

              CustomButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ContinuePopup(
                      title: '"Hanzi" Would Like to Send You Notifications',
                      subtitle:
                          'Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.',
                      showButtons: true,
                      positiveText: "Allow",
                      negativeText: "Don’t Allow",
                      onPositiveTap: () {
                        NavigationService.navigateToReplacement(
                          Routes.identificationScreen,
                        );
                      },
                      onNegativeTap: () {
                        NavigationService.navigateToReplacement(
                          Routes.identificationScreen,
                        );
                      },
                      showIcon: false,
                    ),
                  );
                },
                btnName: "Allow notifications",
              ),

              UIHelper.verticalSpace(20.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.identificationScreen);
                  },
                  child: Text(
                    "Maybe later",
                    style: TextFontStyle.headline16w600c303030urbanist.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
