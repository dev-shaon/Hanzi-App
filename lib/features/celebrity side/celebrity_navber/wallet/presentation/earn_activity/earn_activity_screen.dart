import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/wallet_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/earn_activity/widget/three_sections.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class EarnActivityScreen extends StatefulWidget {
  const EarnActivityScreen({super.key});

  @override
  State<EarnActivityScreen> createState() => _EarnActivityScreenState();
}

class _EarnActivityScreenState extends State<EarnActivityScreen> {
  String _selectedFilterKey = 'all_time';
  String _selectedFilterLabel = 'All time';

  @override
  void initState() {
    super.initState();
    _fetchEarnings();
  }

  void _fetchEarnings() async {
    await getWalletRxObj.fetchfunctionName();
  }

  void _onFilterSelected(String key, String label) {
    setState(() {
      _selectedFilterKey = key;
      _selectedFilterLabel = label;
    });
    // Note: getWalletRxObj doesn't support server-side filtering,
    // so we handle it client-side in the StreamBuilder.
    getWalletRxObj.fetchfunctionName();
  }

  List<RecentTransaction> _filterTransactions(List<RecentTransaction> all) {
    if (_selectedFilterKey == 'all_time') return all;

    final now = DateTime.now();
    DateTime threshold;

    switch (_selectedFilterKey) {
      case 'last_week':
        threshold = now.subtract(const Duration(days: 7));
        break;
      case 'last_15_days':
        threshold = now.subtract(const Duration(days: 15));
        break;
      case 'last_30_days':
        threshold = now.subtract(const Duration(days: 30));
        break;
      case 'last_month':
        threshold = DateTime(now.year, now.month - 1, now.day);
        break;
      default:
        return all;
    }

    return all.where((t) {
      if (t.createdAt == null) return false;
      try {
        final dt = DateTime.parse(t.createdAt!);
        return dt.isAfter(threshold);
      } catch (_) {
        return false;
      }
    }).toList();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cFFFFF8,
        title: CustomAppBar(title: "Activity", showFilter: false),
      ),
      body: Column(
        children: [
          // ── Filter bar ──────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: AppColors.cFFFFF8,
              boxShadow: [
                BoxShadow(
                  color: AppColors.c7C7C7C.withValues(alpha: 0.12),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    builder: (_) => ThreeSections(
                      selectedFilter: _selectedFilterKey,
                      onFilterSelected: _onFilterSelected,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedFilterLabel,
                      style: TextFontStyle.headline14w500cFF5C24urbanist
                          .copyWith(fontSize: 16),
                    ),
                    UIHelper.horizontalSpace(6.w),
                    SvgPicture.asset(Assets.icons.downOrenge),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder(
              stream: getWalletRxObj.fillData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final earningsData = snapshot.data?.data;

                // Show loader until data is actually fetched
                if (earningsData == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                final List<RecentTransaction> allTransactions =
                    earningsData.recentTransactions ?? [];

                final transactions = _filterTransactions(allTransactions);

                if (transactions.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.icons.piggyBank.path,
                            height: 80.h,
                            width: 80.w,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "No activity here yet",
                            style: TextFontStyle.headline16w500c202020urbanist
                                .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Let your fans know you're on tc_mcandy, share your profile, and feed that pig.",
                            style: TextFontStyle.headline16w500c7C7C7Curbanist,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final entry = transactions[index];
                    final String currentDate = _formatDate(entry.createdAt);

                    // Logic to show grouping header
                    bool showHeader = true;
                    if (index > 0) {
                      final prevDate = _formatDate(
                        transactions[index - 1].createdAt,
                      );
                      if (currentDate == prevDate) {
                        showHeader = false;
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showHeader) ...[
                          if (index > 0) UIHelper.verticalSpace(10.h),
                          Text(
                            currentDate,
                            style: TextFontStyle.headline16w500c7C7C7Curbanist
                                .copyWith(fontSize: 14),
                          ),
                          UIHelper.verticalSpace(12.h),
                        ],
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.type ?? "Earnings",
                                    style: TextFontStyle
                                        .headline16w600c303030urbanist,
                                  ),
                                  if (entry.fanName != null)
                                    Text(
                                      "From: ${entry.fanName}",
                                      style: TextFontStyle
                                          .headline12w400c303030urbanist
                                          .copyWith(color: AppColors.cADADAD),
                                    ),
                                ],
                              ),
                              Text(
                                "+\$${(entry.amount ?? 0).toStringAsFixed(2)}",
                                style: TextFontStyle
                                    .headline16w600c303030urbanist
                                    .copyWith(color: AppColors.c34A853),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: AppColors.cC7C7C7),
                        UIHelper.verticalSpace(8.h),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
