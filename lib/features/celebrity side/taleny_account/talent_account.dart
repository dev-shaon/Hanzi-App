import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/taleny_account/widget/country_field.dart';
import 'package:tc_mcandy/features/celebrity%20side/taleny_account/widget/custom_date_field.dart';
import 'package:tc_mcandy/features/celebrity%20side/taleny_account/widget/custom_dropdown.dart';
import 'package:tc_mcandy/features/celebrity%20side/taleny_account/widget/number_field.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:country_picker/country_picker.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class TalentAccount extends StatefulWidget {
  const TalentAccount({super.key});

  @override
  State<TalentAccount> createState() => _TalentAccountState();
}

class _TalentAccountState extends State<TalentAccount> {
  final TextEditingController displaynameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String? selectedPlatform;
  String? selectedDate;
  String? phoneCode;
  String? phoneNumber;
  Country? selectedCountry;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    displaynameController.addListener(_onFormChanged);
    usernameController.addListener(_onFormChanged);
    numberController.addListener(_onFormChanged);
    urlController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  bool get isActive {
    if (selectedPlatform != null && urlController.text.isEmpty) {
      return false;
    }
    // return true;

    return displaynameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        phoneNumber != null &&
        selectedDate != null &&
        selectedCountry != null &&
        selectedPlatform != null;
  }

  void _submitData() async {
    dynamic userId = appData.read(kKeyUserId);
    log("User id : $userId");
    if (userId == null) {
      log("User id is missing");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      bool success = await postTalentProfileRx.post(
        displayName: displaynameController.text,
        userId: userId.toString(),
        userName: usernameController.text,
        phoneCode: phoneCode,
        phoneNumber: phoneNumber,
        dateOfBirth: selectedDate,
        socialPlatform: selectedPlatform,
        country: selectedCountry?.name,
        bio: noteController.text,
      );

      if (success) {
        if (mounted) {
          NavigationService.navigateTo(Routes.accountComfirmScreen);
          customToastMessage("Success", "Account created successfully");
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      customToastMessage("Error", e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    displaynameController.dispose();
    usernameController.dispose();
    numberController.dispose();
    urlController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Complete your account",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                ),

                UIHelper.verticalSpace(40.h),

                CustomFormField(
                  controller: displaynameController,
                  prefixIcon: SvgPicture.asset(Assets.icons.person),
                  hintText: "Display name",
                ),

                UIHelper.verticalSpace(16.h),

                CustomFormField(
                  controller: usernameController,
                  prefixIcon: SvgPicture.asset(Assets.icons.person),
                  hintText: "User_name",
                ),

                UIHelper.verticalSpace(16.h),

                NumberFiled(
                  controller: numberController,
                  onChanged: (code, number) {
                    phoneCode = code;
                    phoneNumber = number;
                    setState(() {});
                  },
                ),

                UIHelper.verticalSpace(16.h),

                CustomDateField(
                  hint: "Date of birth",
                  value: selectedDate,
                  onChanged: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),

                UIHelper.verticalSpace(16.h),

                CountryField(
                  onSelect: (country) {
                    setState(() {
                      selectedCountry = country;
                    });
                  },
                ),

                UIHelper.verticalSpace(16.h),

                CustomDropdown(
                  hint: 'Largest following platform',
                  value: selectedPlatform,
                  items: [
                    'Facebook',
                    'Instagram',
                    'Twitter',
                    'Tiktok',
                    'YouTube',
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedPlatform = value;
                    });
                  },
                ),

                if (selectedPlatform != null) ...[
                  UIHelper.verticalSpace(16.h),
                  CustomFormField(
                    controller: urlController,
                    prefixIcon: SvgPicture.asset(Assets.icons.fileIcon),
                    hintText: "URL",
                  ),
                ],

                UIHelper.verticalSpace(16.h),

                CustomFormField(
                  controller: noteController,
                  maxline: 6,
                  minline: 6,
                  maxLength: 250,
                  onChanged: (_) => setState(() {}),
                  hintText: "Anything else we should know about you?",
                ),

                UIHelper.verticalSpace(30.h),

                CustomButton(
                  onTap: isActive ? _submitData : null,
                  btnName: "Submit",
                  isGradient: true,
                  isActive: isActive,
                  isLoading: isLoading,
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
