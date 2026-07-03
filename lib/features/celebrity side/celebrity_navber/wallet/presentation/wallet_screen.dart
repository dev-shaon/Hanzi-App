import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/wallet_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/widget/bank_container.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/widget/dot_bottom_sheet.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/widget/videos_dms.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/widget/wallet_button.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/widget/wallet_chart.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';
// import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/stripe_onboarding_screen.dart';
// import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/account_connect.dart';
// import 'package:tc_mcandy/common_widgets/custom_toast.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    _fetchWallet();
  }

  void _fetchWallet() async {
    await getWalletRxObj.fetchfunctionName();
    await getAccountInfoRxObj.fetchfunctionName();
  }

  /// Format "2026-02-27" → "Feb 27 2026"
  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final dt = DateTime.parse(raw);
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[dt.month]} ${dt.day} ${dt.year}';
    } catch (_) {
      return raw;
    }
  }

  // Future<void> _startStripeOnboarding() async {
  //   final bool success = await getAccountConnectRxObj.fetchfunctionName();
  //   if (!success) return;

  //   final streamData = getAccountConnectRxObj.fillData;
  //   if (!streamData.hasValue) {
  //     customToastMessage('Error', 'Onboarding URL not found');
  //     return;
  //   }

  //   final AccountConnectModel response = streamData.value;
  //   final String? onboardingUrl = response.data?.onboardingUrl;

  //   if (onboardingUrl == null || onboardingUrl.isEmpty) {
  //     customToastMessage('Error', 'Onboarding URL not found');
  //     return;
  //   }

  //   if (!mounted) return;

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) => StripeOnboardingScreen(onboardingUrl: onboardingUrl),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(
              Assets.icons.arrowBack,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
        title: Text(
          "Wallet",
          style: TextFontStyle.headline24w600c303030urbanist,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'FAQ') {
                NavigationService.navigateTo(Routes.helpDeskScreen);
              }
            },
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            color: AppColors.cFFFFFF,
            icon: SvgPicture.asset(Assets.icons.dot, height: 24.h, width: 24.w),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'FAQ',
                child: Text(
                  'FAQ',
                  style: TextFontStyle.headline14w400cADADADurbanist.copyWith(
                    color: AppColors.c303030,
                  ),
                ),
              ),
            ],
          ),
          UIHelper.horizontalSpace(10.w),
        ],
      ),
      body: StreamBuilder(
        stream: getWalletRxObj.fillData,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data?.data;

          return StreamBuilder(
            stream: getAccountInfoRxObj.fillData,
            builder: (context, accountSnapshot) {
              if (!accountSnapshot.hasData ||
                  accountSnapshot.data?.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final info = accountSnapshot.data?.data;
              final bool isVerified = info?.stripeOnboarded == 1;

              final double walletBalance = data?.walletBalance ?? 0;
              final double totalEarnings = data?.totalEarnings ?? 0;
              final double orderEarnings = data?.orderEarnings ?? 0;
              final double subscriptionEarnings =
                  data?.subscriptionEarnings ?? 0;
              final List<RecentTransaction> transactions =
                  data?.recentTransactions ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Text(
                      "Available balance (USD)",
                      style: TextFontStyle.headline16w500cADADADurbanist,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${walletBalance.toStringAsFixed(2)}",
                          style: TextFontStyle.headline28w700c202020urbanist
                              .copyWith(fontSize: 32),
                        ),
                        SvgPicture.asset(
                          Assets.icons.wallet,
                          height: 40.h,
                          width: 40.h,
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  WalletButton(
                    onTapBank: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      builder: (_) => DotBottomSheet(),
                    ),
                    showAddBank: !isVerified,
                  ),
                  UIHelper.verticalSpace(20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BankContainer(
                      onTap: () {
                        if (isVerified) {
                          NavigationService.navigateTo(
                            Routes.stripeAccountStatusScreen,
                          );
                        } else {
                          NavigationService.navigateTo(
                            Routes.bankAccountScreen,
                          );
                        }
                      },
                      label: isVerified ? 'Verified' : 'Set up',
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.cC7C7C7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        color: AppColors.cFFFFFF,
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Earnings",
                                  style: TextFontStyle
                                      .headline20w600c303030urbanist,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        "All time",
                                        style: TextFontStyle
                                            .headline14w500cFF5C24urbanist
                                            .copyWith(fontSize: 16),
                                      ),
                                      UIHelper.horizontalSpace(6.w),
                                      SvgPicture.asset(Assets.icons.downOrenge),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(20.h),
                            Center(
                              child: WalletDonutChart(
                                totalEarnings: totalEarnings,
                                orderEarnings: orderEarnings,
                                subscriptionEarnings: subscriptionEarnings,
                              ),
                            ),
                            UIHelper.verticalSpace(16.h),
                            VideosDms(
                              title: 'Hanzi videos',
                              price: '\$${orderEarnings.toStringAsFixed(2)}',
                              color: AppColors.cFF5C24,
                            ),
                            UIHelper.verticalSpace(8.h),
                            VideosDms(
                              title: 'Subscriptions',
                              price:
                                  '\$${subscriptionEarnings.toStringAsFixed(2)}',
                            ),
                            UIHelper.verticalSpace(20.h),
                            Divider(color: AppColors.c303030),
                            UIHelper.verticalSpace(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent activity",
                                  style: TextFontStyle
                                      .headline20w600c303030urbanist,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    NavigationService.navigateTo(
                                      Routes.earnActivityScreen,
                                    );
                                  },
                                  child: Text(
                                    "View all",
                                    style: TextFontStyle
                                        .headline14w500cFF5C24urbanist
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(20.h),
                            if (transactions.isEmpty)
                              Center(
                                child: Text(
                                  "No recent transactions",
                                  style: TextFontStyle
                                      .headline16w500c7C7C7Curbanist,
                                ),
                              )
                            else
                              ListView.builder(
                                itemCount: transactions.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final tx = transactions[index];
                                  final bool isDebit =
                                      tx.status?.toLowerCase() == 'refunded' ||
                                      tx.payoutStatus?.toLowerCase() ==
                                          'transferred';
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (index == 0 ||
                                            transactions[index].createdAt !=
                                                transactions[index - 1]
                                                    .createdAt)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 8.h,
                                            ),
                                            child: Text(
                                              _formatDate(tx.createdAt),
                                              style: TextFontStyle
                                                  .headline16w500c7C7C7Curbanist
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              tx.type ?? 'Order',
                                              style: TextFontStyle
                                                  .headline16w500c7C7C7Curbanist,
                                            ),
                                            Text(
                                              isDebit
                                                  ? '-\$${tx.amount?.toStringAsFixed(2) ?? "0.00"}'
                                                  : '+\$${tx.celebrityPayout?.toStringAsFixed(2) ?? "0.00"}',
                                              style: TextFontStyle
                                                  .headline16w600c303030urbanist
                                                  .copyWith(
                                                    color: isDebit
                                                        ? AppColors.cBF0707
                                                        : AppColors.c34A853,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
