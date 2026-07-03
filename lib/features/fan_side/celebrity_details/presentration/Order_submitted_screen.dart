import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class OrderSubmittedScreen extends StatefulWidget {
  const OrderSubmittedScreen({super.key});

  @override
  State<OrderSubmittedScreen> createState() => _OrderSubmittedScreenState();
}

class _OrderSubmittedScreenState extends State<OrderSubmittedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.icons.confirm),
                UIHelper.verticalSpace(20.h),
                Text(
                  "Completed the payment & submitted the order successfully.",
                  style: TextFontStyle.headline20w600c303030urbanist,
                  textAlign: TextAlign.center,
                ),
                UIHelper.verticalSpace(30.h),
                CustomButton(
                  width: 176.w,
                  onTap: () {
                    NavigationService.navigateToReplacement(
                      Routes.navberScreen,
                    );
                  },
                  btnName: "Back to home page",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
