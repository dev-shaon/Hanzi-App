import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/order/presentation/widget/order_list.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import '../model/my_order_model.dart'; // Tumar model file path ta check kore nio

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String selectedFilter = "All";
  final List<String> filters = ["All", "In progress", "Delivered", "Rejected"];

  @override
  void initState() {
    super.initState();
    _getMyOrder();
  }

  void _getMyOrder() async {
    await getMyOrderRxObj.fetchMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(title: "My Orders", showFilter: false),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 1,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (context, index) =>
                  UIHelper.horizontalSpace(10.w),
              itemBuilder: (context, index) {
                bool isSelected = selectedFilter == filters[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filters[index];
                    });
                  },
                  child: Chip(
                    backgroundColor: isSelected
                        ? const Color(0xFFF3E5AB)
                        : Colors.transparent,
                    shape: StadiumBorder(
                      side: BorderSide(color: AppColors.cF6DFBA),
                    ),
                    label: Text(
                      filters[index],
                      style: TextFontStyle.headline16w500c202020urbanist,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: getMyOrderRxObj.fillData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Datum> orders = snapshot.data?.data?.data ?? [];

            // Always filter out "Pending" status
            orders = orders.where((item) {
              String apiStatus = item.status?.toLowerCase() ?? "";
              return apiStatus != "pending";
            }).toList();

            if (selectedFilter != "All") {
              orders = orders.where((item) {
                String apiStatus = item.status?.toLowerCase() ?? "";
                String filterValue = selectedFilter.toLowerCase();

                return apiStatus == filterValue ||
                    apiStatus.replaceAll('_', ' ') == filterValue ||
                    apiStatus.replaceAll('-', ' ') == filterValue;
              }).toList();
            }

            if (orders.isEmpty) {
              final isCelebrity = appData.read(kkeyUserRole) == 'celebrity';
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isCelebrity
                          ? "No orders yet"
                          : "Have an occasion coming up?",
                      style: TextFontStyle.headline16w500c202020urbanist
                          .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (!isCelebrity) ...[
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateToReplacement(
                            Routes.navberScreen,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: const Color(0xFFE85C2B),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            "Start browsing",
                            style: TextFontStyle.headline16w500c202020urbanist
                                .copyWith(
                                  color: const Color(0xFFE85C2B),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.only(top: 10.h),
              physics: const BouncingScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderList(
                  name: order.celebrity?.name ?? "N/A",
                  role: order.celebrity?.role?.name ?? "User",
                  amount: "\$${order.price ?? 0}",
                  status: order.status ?? "Pending",
                  image: order.celebrity?.avatar ?? kDefaultProfileImage,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(
                    "Failed to load orders. Please try again.",
                    style: TextFontStyle.headline16w500c202020urbanist,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CustomShimmer(type: ShimmerType.orderListShimmer),
            );
          }
        },
      ),
    );
  }
}
