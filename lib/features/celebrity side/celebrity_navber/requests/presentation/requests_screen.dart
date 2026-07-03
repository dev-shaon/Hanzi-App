import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/presentation/widgets/firstOrder_bottom_sheet.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/presentation/widgets/icons_container.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/presentation/widgets/morning_list.dart';
import 'package:tc_mcandy/features/fan_side/order/presentation/widget/order_list.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  String _selectedFilter = 'In-Progress';
  bool _isLoading = false;

  final List<String> morningTitles = [
    "All",
    'In-Progress',
    'Delivered',
    'Rejected',
  ];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
    getCelebrityProfileRxObj.fetchCelebrityProfile();
  }

  void _fetchOrders() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    await getCelebrityOrderRxObj.fetchCelebrityOrders(filter: _selectedFilter);
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 50.h,
        width: 50.w,
        child: FloatingActionButton(
          heroTag: 'requestsSupportFab',
          onPressed: () {
            NavigationService.navigateTo(Routes.customerSupportScreen);
          },
          backgroundColor: AppColors.cFFFFF8,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.cC7C7C7, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: SvgPicture.asset(
              Assets.icons.aiIcon,
              height: 60.h,
              width: 60.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(20.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: IconsContainer(),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Text(
                    "Good morning 🌻",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(6.h),
                  Text(
                    "You have no open orders at the moment,",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist,
                  ),
                  UIHelper.verticalSpace(16.h),
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: morningTitles.length,
                      itemBuilder: (context, index) {
                        final title = morningTitles[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: MorningList(
                            title: title,
                            isSelected: _selectedFilter == title,
                            onTap: () {
                              setState(() => _selectedFilter = title);
                              _fetchOrders();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  UIHelper.verticalSpace(30.h),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cC7C7C7),
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: StreamBuilder(
                  stream: getCelebrityOrderRxObj.fillData,
                  builder: (context, asyncSnapshot) {
                    final allOrders = asyncSnapshot.data?.data?.data ?? [];
                    final orders = allOrders
                        .where(
                          (item) => item.status?.toLowerCase() != "pending",
                        )
                        .toList();

                    if (_isLoading) {
                      return const CustomShimmer(
                        type: ShimmerType.orderListShimmer,
                      );
                    }

                    if (orders.isEmpty) {
                      return _buildEmpty();
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final item = orders[index];
                        return OrderList(
                          name: item.fan?.name ?? "",
                          role: item.package?.packageName ?? "",
                          amount: "\$${item.price ?? 0}",
                          status: item.status ?? "",
                          image:
                              item.fan?.avatar ??
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.icons.busket),
          UIHelper.verticalSpace(8.h),
          Text(
            "No orders yet",
            style: TextFontStyle.headline20w600c303030urbanist,
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            "Run a new promotion and share on social media to grow your orders.",
            style: TextFontStyle.headline16w500cADADADurbanist,
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(24.h),
          CustomButton(
            width: 165.w,
            btnName: "Get your order",
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                builder: (context) {
                  final profile =
                      getCelebrityProfileRxObj.dataFetcher.valueOrNull;
                  return FirstOrderBottomSheet(
                    avatar: profile?.data?.avatar ?? '',
                    name: profile?.data?.name ?? '',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
