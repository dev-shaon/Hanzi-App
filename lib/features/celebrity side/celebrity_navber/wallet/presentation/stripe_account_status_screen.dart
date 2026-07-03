import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class StripeAccountStatusScreen extends StatefulWidget {
  const StripeAccountStatusScreen({super.key});

  @override
  State<StripeAccountStatusScreen> createState() =>
      _StripeAccountStatusScreenState();
}

class _StripeAccountStatusScreenState extends State<StripeAccountStatusScreen> {
  @override
  void initState() {
    super.initState();
    getAccountInfoRxObj.fetchfunctionName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        leading: IconButton(
          onPressed: () => NavigationService.goBack,
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.c303030),
        ),
        title: Text(
          'Stripe account',
          style: TextFontStyle.headline18w600c303030urbanist,
        ),
      ),
      body: StreamBuilder(
        stream: getAccountInfoRxObj.fillData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data?.data;
          final String email = data?.email ?? 'N/A';
          final String accountId = data?.accountId ?? 'N/A';
          final bool chargesEnabled = data?.chargesEnabled ?? false;
          final bool payoutsEnabled = data?.payoutsEnabled ?? false;
          final bool detailsSubmitted = data?.detailsSubmitted ?? false;
          final bool stripeOnboarded =
              data?.stripeOnboarded == 1; // 1 for true, 0 for false

          // Get initials from email or account name if available
          String initials = 'CM';
          if (email.isNotEmpty && email != 'N/A') {
            initials = email.substring(0, 2).toUpperCase();
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.cBF0707, AppColors.cFF5C24],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -28,
                        right: -28,
                        child: _buildDecorCircle(120.w),
                      ),
                      Positioned(
                        bottom: -42,
                        right: 40,
                        child: _buildDecorCircle(100.w),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 52.w,
                                height: 52.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.cFFFFFF.withValues(
                                      alpha: 0.45,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  initials,
                                  style: TextFontStyle
                                      .headline20w600c303030urbanist
                                      .copyWith(color: AppColors.cFFFFFF),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My account',
                                      style: TextFontStyle
                                          .headline24w600c303030urbanist
                                          .copyWith(
                                            color: AppColors.cFFFFFF,
                                            fontSize: 29.sp,
                                          ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      email,
                                      style: TextFontStyle
                                          .headline14w400cADADADurbanist
                                          .copyWith(color: AppColors.cFFFFFF),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          Row(
                            children: [
                              Expanded(
                                child: _StatusCard(
                                  label: 'ONBOARDED',
                                  value: stripeOnboarded ? 'Active' : 'Pending',
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _StatusCard(
                                  label: 'CHARGES',
                                  value:
                                      chargesEnabled ? 'Enabled' : 'Disabled',
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _StatusCard(
                                  label: 'PAYOUTS',
                                  value:
                                      payoutsEnabled ? 'Enabled' : 'Disabled',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.cC7C7C7),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(label: 'Account ID', value: accountId),
                      _DividerLine(),
                      _InfoRow(label: 'Email', value: email),
                      _DividerLine(),
                      _InfoRow(
                        label: 'Details submitted',
                        trailing: _StatusPill(
                          text: detailsSubmitted ? 'Yes' : 'No',
                          active: detailsSubmitted,
                        ),
                      ),
                      _DividerLine(),
                      _InfoRow(
                        label: 'Stripe onboarded',
                        trailing: _StatusPill(
                          text: stripeOnboarded ? 'Verified' : 'Pending',
                          active: stripeOnboarded,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                  decoration: BoxDecoration(
                    color: AppColors.cF9E6E6.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.cEBB2B2),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 20.sp,
                        color: AppColors.cFF5C24,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          stripeOnboarded &&
                                  chargesEnabled &&
                                  payoutsEnabled &&
                                  detailsSubmitted
                              ? 'Your account is fully set up and ready to accept payments.'
                              : 'Your account setup is in progress. Please wait for Stripe verification.',
                          style: TextFontStyle.headline14w400cADADADurbanist
                              .copyWith(color: AppColors.c303030),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDecorCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cFFFFFF.withValues(alpha: 0.08),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatusCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextFontStyle.headline10w500c303030urbanist.copyWith(
              color: AppColors.cFFFFFF.withValues(alpha: 0.9),
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(
                color: AppColors.cFFFFFF.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 13.sp,
                  color: AppColors.cFFFFFF.withValues(alpha: 0.95),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: TextFontStyle.headline12w400c303030urbanist.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? trailing;

  const _InfoRow({required this.label, this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                color: AppColors.c303030,
              ),
            ),
          ),
          if (trailing != null)
            trailing!
          else
            Expanded(
              child: Text(
                value ?? '',
                textAlign: TextAlign.right,
                style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String text;
  final bool active;

  const _StatusPill({required this.text, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999.r),
        gradient: active
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.cBF0707, AppColors.cFF5C24],
              )
            : null,
        color: active ? null : AppColors.cADADAD,
      ),
      child: Text(
        text,
        style: TextFontStyle.headline14w600c303030urbanist.copyWith(
          color: AppColors.cFFFFFF,
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.cC7C7C7.withValues(alpha: 0.6),
    );
  }
}
