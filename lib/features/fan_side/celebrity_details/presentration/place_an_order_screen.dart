import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/constants/validation.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/order_success_screen.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/package_plan_widgets.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class PlaceAnOrderScreen extends StatefulWidget {
  final String amount;
  final int packageId;
  final String packageName;
  final String packageDetails;
  final dynamic revisions;
  final dynamic deliveryDays;
  final int editable;

  const PlaceAnOrderScreen({
    super.key,
    required this.amount,
    required this.packageId,
    required this.packageName,
    required this.packageDetails,
    required this.revisions,
    required this.deliveryDays,
    required this.editable,
  });

  @override
  State<PlaceAnOrderScreen> createState() => _PlaceAnOrderScreenState();
}

class _PlaceAnOrderScreenState extends State<PlaceAnOrderScreen> {
  final TextEditingController videoScriptController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isScriptNotEmpty = false;

  @override
  void initState() {
    super.initState();
    videoScriptController.addListener(() {
      final notEmpty = videoScriptController.text.trim().isNotEmpty;
      if (notEmpty != _isScriptNotEmpty) {
        setState(() => _isScriptNotEmpty = notEmpty);
      }
    });
  }

  @override
  void dispose() {
    videoScriptController.dispose();
    super.dispose();
  }

  void _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() => isLoading = true);

      String? clientSecret = await postPlaceOrderRxObj.post(
        id: widget.packageId,
        videoScript: videoScriptController.text,
      );

      if (clientSecret != null) {
        await _presentPaymentSheet(clientSecret);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
          (route) => false,
        );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
        title: CustomAppBar(title: "Place an order", showFilter: false),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "\$ ${widget.amount}",
                    style: TextFontStyle.headline20w600c303030urbanist.copyWith(
                      color: AppColors.cFF5C24,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                Divider(color: AppColors.cFF5C24, thickness: 1.5.h),
                UIHelper.verticalSpace(16.h),
                PackagePlanWidget(
                  packageName: widget.packageName,
                  packageDetails: widget.packageDetails,
                  revisions: widget.revisions,
                  deliveryDays: widget.deliveryDays,
                  editable: widget.editable,
                ),
                UIHelper.verticalSpace(28.h),
                Text(
                  "Video script",
                  style: TextFontStyle.headline20w600c303030urbanist,
                ),
                UIHelper.verticalSpace(12.h),
                CustomFormField(
                  validator: messageValidator,
                  maxline: 8,
                  minline: 8,
                  controller: videoScriptController,
                  hintText: "Type here your video requirements...",
                ),
                UIHelper.verticalSpace(100.h),
                CustomButton(
                  onTap: _isScriptNotEmpty ? _placeOrder : null,
                  btnName: "Place the order",
                  isLoading: isLoading,
                  isActive: _isScriptNotEmpty,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
