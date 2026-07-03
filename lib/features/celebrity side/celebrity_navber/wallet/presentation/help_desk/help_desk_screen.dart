import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/help_desk/widget/fqa_list.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({super.key});

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cFFFFF8,
        title: CustomAppBar(title: "Help Desk", showFilter: false),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We’re here to help you with anything and everything on Hanzi",
                style: TextFontStyle.headline20w600c303030urbanist,
              ),
              UIHelper.verticalSpace(12.h),
              Text(
                "At Hanzi, we expect at a day’s start is you, better and happier than yesterday. We have got you covered share your concern or check our frequently asked questions listed below.",
                style: TextFontStyle.headline16w400c303030urbanist,
              ),
              UIHelper.verticalSpace(24.h),
              Text("FAQ", style: TextFontStyle.headline20w600c303030urbanist),
              UIHelper.verticalSpace(24.h),
              FqaList(),
              UIHelper.verticalSpace(65.h),
              Center(
                child: Text(
                  "Still stuck? Help us a mail away",
                  style: TextFontStyle.headline16w500c7C7C7Curbanist,
                ),
              ),
              UIHelper.verticalSpace(12.h),
            ],
          ),
        ),
      ),
    );
  }
}
