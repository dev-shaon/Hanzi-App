import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/package_container.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/pop_up.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import '../../../../common_widgets/custom_toast.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/api_access.dart';

class SetPackages extends StatefulWidget {
  final String celebrityBio;
  final List<String> videoCategory; // ✅ List
  final List<String> serviceTags; // ✅ List

  const SetPackages({
    super.key,
    required this.celebrityBio,
    required this.videoCategory,
    required this.serviceTags,
  });

  @override
  State<SetPackages> createState() => _SetPackagesState();
}

class _SetPackagesState extends State<SetPackages> {
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController price1Controller = TextEditingController();
  final TextEditingController price2Controller = TextEditingController();
  final TextEditingController price3Controller = TextEditingController();
  final TextEditingController packageName1Controller = TextEditingController();
  final TextEditingController packageName2Controller = TextEditingController();
  final TextEditingController packageName3Controller = TextEditingController();
  final TextEditingController offeringDetails1Controller =
      TextEditingController();
  final TextEditingController offeringDetails2Controller =
      TextEditingController();
  final TextEditingController offeringDetails3Controller =
      TextEditingController();

  bool isActive = false;
  bool isLoading = false;
  Map<String, dynamic> packageData = {};
  final List<int> deliveryDays = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    final controllers = [
      titleController,
      detailsController,
      price1Controller,
      price2Controller,
      price3Controller,
      packageName1Controller,
      packageName2Controller,
      packageName3Controller,
      offeringDetails1Controller,
      offeringDetails2Controller,
      offeringDetails3Controller,
    ];

    for (final controller in controllers) {
      controller.addListener(_checkFields);
    }
  }

  void _checkFields() {
    final prices = [price1Controller, price2Controller, price3Controller];
    final packageNames = [
      packageName1Controller,
      packageName2Controller,
      packageName3Controller,
    ];
    final packageDescriptions = [
      offeringDetails1Controller,
      offeringDetails2Controller,
      offeringDetails3Controller,
    ];

    final bool hasMainInfo =
        titleController.text.trim().isNotEmpty &&
        detailsController.text.trim().isNotEmpty;

    bool areAllPackagesComplete = true;
    for (int i = 0; i < 3; i++) {
      final bool hasPackageInfo =
          prices[i].text.trim().isNotEmpty &&
          packageNames[i].text.trim().isNotEmpty &&
          packageDescriptions[i].text.trim().isNotEmpty &&
          deliveryDays[i] > 0;

      if (!hasPackageInfo) {
        areAllPackagesComplete = false;
        break;
      }
    }

    setState(() {
      isActive = hasMainInfo && areAllPackagesComplete;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    price1Controller.dispose();
    price2Controller.dispose();
    price3Controller.dispose();
    packageName1Controller.dispose();
    packageName2Controller.dispose();
    packageName3Controller.dispose();
    offeringDetails1Controller.dispose();
    offeringDetails2Controller.dispose();
    offeringDetails3Controller.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      setState(() => isLoading = true);

      final packageDataList = packageData['packages'] as List? ?? [];

      final packages = List.generate(3, (i) {
        final names = [
          packageName1Controller,
          packageName2Controller,
          packageName3Controller,
        ];
        final prices = [price1Controller, price2Controller, price3Controller];
        final offerings = [
          offeringDetails1Controller,
          offeringDetails2Controller,
          offeringDetails3Controller,
        ];

        return {
          'package_name': names[i].text,
          'price': prices[i].text,
          'description': offerings[i].text,
          'revision_limit': packageDataList.isNotEmpty
              ? packageDataList[i]['revisions']
              : 0,
          'delivery_days': packageDataList.isNotEmpty
              ? packageDataList[i]['delivery_days']
              : 0,
          'editable': packageDataList.isNotEmpty
              ? (packageDataList[i]['cr_value'] ?? 0)
              : 0,
        };
      });

      bool success = await celebrityPostRxObj.post(
        categoryId: appData.read(kkeyCategoryId) ?? 0,
        celebrityBio: widget.celebrityBio,
        mainTitle: titleController.text,
        description: detailsController.text,
        serviceTypes: widget.serviceTags,
        tags: widget.videoCategory,
        status: 1,
        packages: packages,
      );

      if (success) {
        customToastMessage("Success", "Profile created successfully");
        appData.write(kkeyhasPackage, true);
        NavigationService.navigateTo(Routes.newOrderScreen);
      }
    } catch (e) {
      customToastMessage("Error", e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: "", showFilter: false),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ContinuePopup(
                    title: 'Pro tip',
                    subtitle:
                        'Starting your price lower helps you receive orders early on. Try completing your first order at the suggested price to help get you off to a hot start',
                  ),
                );
              },
              child: SvgPicture.asset(Assets.icons.iIcon),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set your pack packages.",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Define 3 pages for your fans, so that they can choose the necessary package whatever they need.",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist,
                  ),
                  UIHelper.verticalSpace(33.h),
                  CustomFormField(
                    controller: titleController,
                    hintText: "Main title",
                  ),
                  UIHelper.verticalSpace(16.h),
                  CustomFormField(
                    controller: detailsController,
                    maxline: 6,
                    minline: 6,
                    hintText: "Description",
                  ),
                  UIHelper.verticalSpace(16.h),
                  PackageContainer(
                    price1Controller: price1Controller,
                    price2Controller: price2Controller,
                    price3Controller: price3Controller,
                    packageName1Controller: packageName1Controller,
                    packageName2Controller: packageName2Controller,
                    packageName3Controller: packageName3Controller,
                    offeringDetails1Controller: offeringDetails1Controller,
                    offeringDetails2Controller: offeringDetails2Controller,
                    offeringDetails3Controller: offeringDetails3Controller,
                    onPackageDataChanged: (data) {
                      packageData = data;

                      final packageList = data['packages'] as List? ?? [];
                      for (int i = 0; i < deliveryDays.length; i++) {
                        if (i < packageList.length) {
                          deliveryDays[i] = packageList[i]['delivery_days'] ?? 0;
                        } else {
                          deliveryDays[i] = 0;
                        }
                      }

                      _checkFields();
                    },
                  ),
                  UIHelper.verticalSpace(50.h),
                  CustomButton(
                    isGradient: true,
                    isActive: isActive,
                    isLoading: isLoading,
                    btnName: "Continue",
                    onTap: isActive ? _submit : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
