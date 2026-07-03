import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/order/presentation/widget/order_list.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/my_order_model.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
      floatingActionButton: SizedBox(
        height: 40.h,
        width: 40.w,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.cFFFFF8,
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
      appBar: AppBar(
        title: CustomAppBar(showFilter: false, title: "Your Orders"),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
        elevation: 10,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: StreamBuilder(
        stream: getMyOrderRxObj.fillData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Datum> orders = snapshot.data?.data?.data ?? [];

            // Filter out "Pending" status
            orders = orders.where((item) {
              String apiStatus = item.status?.toLowerCase() ?? "";
              return apiStatus != "pending";
            }).toList();

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.icons.order.path,
                      height: 100.h,
                      width: 100.w,
                    ),
                    UIHelper.verticalSpace(20.h),
                    Text(
                      "No drafts yet. Once you start a booking, your most recent draft will appear here.",
                      style: TextFontStyle.headline18w600c303030urbanist
                          .copyWith(color: AppColors.c303030),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderList(
                  name: order.celebrity?.name ?? "N/A",
                  role: order.celebrity?.role?.name ?? "User",
                  amount: "\$${order.price ?? 0}",
                  status: order.status ?? "Unknown",
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
                    style: TextFontStyle.headline18w600c303030urbanist,
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
