import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/model/celebrity_details_model.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/order_plan_widget.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class PlaceOrder extends StatefulWidget {
  final int id;
  const PlaceOrder({super.key, required this.id});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Package> _packages = [];
  String amountItem = "";
  int? packageId;
  bool _tabInitialized = false;
  bool _isDmLoading = false;

  @override
  void initState() {
    super.initState();
    _getOrderDetails();
  }

  void _getOrderDetails() async {
    await getCelebrityDetailsRxObj.fetchCelebrityDetails(id: widget.id);
  }

  void _initTabController(List<Package> packages) {
    if (_tabInitialized && _tabController?.length == packages.length) return;

    _tabController?.dispose();
    _packages = packages;
    _tabController = TabController(length: packages.length, vsync: this);
    _tabInitialized = true;

    if (packages.isNotEmpty) {
      amountItem = packages[0].price ?? "";
      packageId = packages[0].id;
    }

    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        setState(() {
          amountItem = _packages[_tabController!.index].price ?? "";
          packageId = _packages[_tabController!.index].id;
        });
        log("Selected amount: $amountItem, packageId: $packageId");
      }
    });
  }

  Future<void> _sendDM() async {
    try {
      setState(() => _isDmLoading = true);
      String? clientSecret = await postChatPaymentRxObj.post(
        celebrityId: widget.id,
      );
      if (clientSecret != null) {
        await _presentPaymentSheet(clientSecret);
      }
    } catch (e) {
      log(e.toString());
      customToastMessage("Error", kErrorGeneric);
    } finally {
      if (mounted) setState(() => _isDmLoading = false);
    }
  }

  Future<void> _presentPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "TC MCandy",
          style: ThemeMode.light,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      if (mounted) {
        customToastMessage("Success", "Message sent successfully!");
        NavigationService.goBack;
      }
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        customToastMessage("Cancelled", "Payment cancelled");
      } else {
        customToastMessage("Error", e.error.message ?? "Payment failed");
      }
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
        title: const CustomAppBar(title: "Place an order", showFilter: false),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SafeArea(
          child: StreamBuilder(
            stream: getCelebrityDetailsRxObj.fillData,
            builder: (context, asyncSnapshot) {
              if (!asyncSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = asyncSnapshot.data!;
              final packages = data.data?.packages ?? [];

              if (packages.isEmpty) {
                return const Center(child: Text("No packages available"));
              }

              _initTabController(packages);

              if (_tabController == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.data?.mainTitle ??
                        "I will make videos for your special occasions.",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(16.h),

                  Text(
                    data.data?.bio ??
                        "You can purchase a custom video that will make your occasions more special.",
                    style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
                      color: AppColors.c303030,
                    ),
                  ),

                  UIHelper.verticalSpace(28.h),

                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.cFF5C24,
                    labelColor: AppColors.cFF5C24,
                    unselectedLabelColor: AppColors.c303030,
                    labelStyle: TextFontStyle.headline16w600c303030urbanist,
                    tabs: packages
                        .map<Tab>((p) => Tab(text: '\$${p.price ?? "0"}'))
                        .toList(),
                  ),

                  UIHelper.verticalSpace(20.h),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: packages.map<Widget>((p) {
                        return OrderPlanWidget(
                          title: p.name ?? "",
                          description: p.description ?? "",
                          revisions: p.revisionLimit ?? "0",
                          deliveryDays: p.deliveryDays ?? "0",
                          isEditable: (p.editable ?? 0) == 1,
                        );
                      }).toList(),
                    ),
                  ),

                  CustomButton(
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                        Routes.placeAnOrderScreen,
                        {
                          "amount": amountItem,
                          "packageId": packageId,
                          "packageName": packages[_tabController!.index].name,
                          "packageDetails":
                              packages[_tabController!.index].description,
                          "revisions":
                              packages[_tabController!.index].revisionLimit,
                          "deliveryDays":
                              packages[_tabController!.index].deliveryDays,
                          "editable": packages[_tabController!.index].editable,
                        },
                      );
                    },
                    btnName: "Continue \$$amountItem",
                  ),

                  if (data.data?.isSubscribed != true) ...[  
                    UIHelper.verticalSpace(12.h),
                    CustomButton(
                      borderColor: AppColors.cFF5C24,
                      isGradient: false,
                      onTap: _isDmLoading ? null : () => _sendDM(),
                      btnName: _isDmLoading
                          ? "Processing..."
                          : "Send a message \$2.99",
                      bgColor: AppColors.cFCF5E9,
                      textStyle: TextFontStyle.headline16w700cFFFFFFurbanist
                          .copyWith(color: AppColors.cFF5C24),
                    ),
                  ],

                  UIHelper.verticalSpace(12.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
