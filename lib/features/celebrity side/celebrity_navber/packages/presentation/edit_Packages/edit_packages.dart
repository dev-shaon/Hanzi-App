import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/model/celebrity_package_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/pop_up.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import '../../../../../../networks/api_access.dart';
import '../../../../talent_profile/set_packages/widgets/package_container.dart';

class EditPackages extends StatefulWidget {
  const EditPackages({super.key});

  @override
  State<EditPackages> createState() => _EditPackagesState();
}

class _EditPackagesState extends State<EditPackages> {
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

  bool _dataLoaded = false;
  bool _isSaving = false;
  final List<int> _revisions = [0, 0, 0];
  final List<int> _deliveryDays = [0, 0, 0];
  final List<int?> _crValues = [0, 0, 0];
  final List<int?> _packageIds = [null, null, null];
  int? _postId;

  @override
  void initState() {
    super.initState();
    _celebrityPackage();
  }

  void _celebrityPackage() async {
    await getCelebrityPackageRxObj.fetchCelebrityPackageData();
  }

  void _prefillControllers(Post? post) {
    if (_dataLoaded) return;
    _dataLoaded = true;

    _postId = post?.id;
    final packages = (post?.packages ?? []);

    titleController.text = post?.mainTitle ?? "";
    detailsController.text = post?.description ?? "";

    if (packages.isNotEmpty) {
      _packageIds[0] = packages[0].id;
      packageName1Controller.text = packages[0].packageName ?? "";
      price1Controller.text = packages[0].price ?? "";
      offeringDetails1Controller.text = packages[0].description ?? "";
      _revisions[0] = int.tryParse(packages[0].revisionLimit ?? "0") ?? 0;
      _deliveryDays[0] = int.tryParse(packages[0].deliveryDays ?? "0") ?? 0;
      _crValues[0] = packages[0].editable ?? 0;
    }
    if (packages.length > 1) {
      _packageIds[1] = packages[1].id;
      packageName2Controller.text = packages[1].packageName ?? "";
      price2Controller.text = packages[1].price ?? "";
      offeringDetails2Controller.text = packages[1].description ?? "";
      _revisions[1] = int.tryParse(packages[1].revisionLimit ?? "0") ?? 0;
      _deliveryDays[1] = int.tryParse(packages[1].deliveryDays ?? "0") ?? 0;
      _crValues[1] = packages[1].editable ?? 0;
    }
    if (packages.length > 2) {
      _packageIds[2] = packages[2].id;
      packageName3Controller.text = packages[2].packageName ?? "";
      price3Controller.text = packages[2].price ?? "";
      offeringDetails3Controller.text = packages[2].description ?? "";
      _revisions[2] = int.tryParse(packages[2].revisionLimit ?? "0") ?? 0;
      _deliveryDays[2] = int.tryParse(packages[2].deliveryDays ?? "0") ?? 0;
      _crValues[2] = packages[2].editable ?? 0;
    }
  }

  Future<void> _savePackages() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    if (_postId == null) {
      customToastMessage('Error', 'Post ID not found');
      setState(() => _isSaving = false);
      return;
    }

    log('Package IDs: $_packageIds');
    log('Post ID: $_postId');

    final success = await editedCelebrityPackageRxObj.post(
      id: _postId!,
      mainTitle: titleController.text.trim(),
      description: detailsController.text.trim(),

      packageId0: _packageIds[0]?.toString() ?? '',
      packageName0: packageName1Controller.text.trim(),
      price0: price1Controller.text.trim(),
      packageDescription0: offeringDetails1Controller.text.trim(),
      revisionLimit0: _revisions[0].toString(),
      deliveryDays0: _deliveryDays[0].toString(),
      editable0: _crValues[0]?.toString() ?? '0',

      packageId1: _packageIds[1]?.toString() ?? '',
      packageName1: packageName2Controller.text.trim(),
      price1: price2Controller.text.trim(),
      packageDescription1: offeringDetails2Controller.text.trim(),
      revisionLimit1: _revisions[1].toString(),
      deliveryDays1: _deliveryDays[1].toString(),
      editable1: _crValues[1]?.toString() ?? '0',

      packageId2: _packageIds[2]?.toString() ?? '',
      packageName2: packageName3Controller.text.trim(),
      price2: price3Controller.text.trim(),
      packageDescription2: offeringDetails3Controller.text.trim(),
      revisionLimit2: _revisions[2].toString(),
      deliveryDays2: _deliveryDays[2].toString(),
      editable2: _crValues[2]?.toString() ?? '0',
    );

    setState(() => _isSaving = false);

    if (success) {
      customToastMessage('Success', 'Packages updated successfully');
      NavigationService.goBack;
      _celebrityPackage();
    }
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
        child: StreamBuilder(
          stream: getCelebrityPackageRxObj.fillData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final post = snapshot.data!.data?.post;
            _prefillControllers(post);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpace(16.h),
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
                      initialRevisions: _revisions,
                      initialDeliveryDays: _deliveryDays,
                      initialCrValues: _crValues,
                      packageIds: _packageIds,
                      onPackageDataChanged: (data) {
                        final packages = data['packages'] as List;
                        setState(() {
                          _revisions[0] = packages[0]['revisions'];
                          _revisions[1] = packages[1]['revisions'];
                          _revisions[2] = packages[2]['revisions'];
                          _deliveryDays[0] = packages[0]['delivery_days'];
                          _deliveryDays[1] = packages[1]['delivery_days'];
                          _deliveryDays[2] = packages[2]['delivery_days'];
                          _crValues[0] = packages[0]['cr_value'];
                          _crValues[1] = packages[1]['cr_value'];
                          _crValues[2] = packages[2]['cr_value'];
                        });
                      },
                    ),
                    UIHelper.verticalSpace(50.h),
                    CustomButton(
                      isGradient: true,
                      isActive: !_isSaving,
                      btnName: _isSaving ? "Saving..." : "Save",
                      onTap: () {
                        _savePackages();
                      },
                    ),
                    UIHelper.verticalSpace(20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}
