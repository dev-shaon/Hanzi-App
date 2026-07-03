import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class NumberFiled extends StatelessWidget {
  final Function(String countryCode, String phoneNumber) onChanged;
  final TextEditingController controller;

  const NumberFiled({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      initialCountryCode: 'BD',
      disableLengthCheck: true,
      style: TextFontStyle.headline16w400c303030urbanist,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        filled: true,
        fillColor: AppColors.cFFFFFF,
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: AppColors.cADADAD),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: AppColors.cADADAD),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: AppColors.cFF5C24),
        ),
      ),

      onChanged: (phone) {
        log(phone.completeNumber);
        onChanged(phone.countryCode, phone.number);
      },
    );
  }
}
