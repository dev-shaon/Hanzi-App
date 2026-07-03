import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/stripe_onboarding_screen.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

import '../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../networks/api_access.dart';
import '../../model/account_connect.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  Future<void> _startStripeOnboarding() async {
    final bool success = await getAccountConnectRxObj.fetchfunctionName();
    if (!success) return;

    final streamData = getAccountConnectRxObj.fillData;
    if (!streamData.hasValue) {
      customToastMessage('Error', 'Onboarding URL not found');
      return;
    }

    final AccountConnectModel response = streamData.value;
    final String? onboardingUrl = response.data?.onboardingUrl;

    if (onboardingUrl == null || onboardingUrl.isEmpty) {
      customToastMessage('Error', 'Onboarding URL not found');
      return;
    }

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StripeOnboardingScreen(onboardingUrl: onboardingUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cFFFFF8,
        title: CustomAppBar(title: "Bank Account", showFilter: false),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set up banking",
              style: TextFontStyle.headline20w600c303030urbanist,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "Link a bank or PayPal account so you can manage your payouts.",
              style: TextFontStyle.headline16w500cADADADurbanist,
            ),
            UIHelper.verticalSpace(36.h),
            Text(
              "How payouts work",
              style: TextFontStyle.headline16w600c303030urbanist,
            ),
            UIHelper.verticalSpace(20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.icons.protectRight),
                UIHelper.horizontalSpace(6.w),
                Expanded(
                  child: Text(
                    "You have complete control over your payouts Earnings are transferred to your account within 2-7 days after you initiate a payout transfer.",
                    style: TextFontStyle.headline16w500cADADADurbanist,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(70.h),
            Center(child: Image.asset(Assets.images.payImage.path)),
            UIHelper.verticalSpace(90.h),
            CustomButton(
              onTap: _startStripeOnboarding,
              btnName: "Set up banking",
            ),
          ],
        ),
      ),
    );
  }
}
