import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';

class SetPrice extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool showEnabledBorder;
  final VoidCallback? onTap;

  const SetPrice({
    super.key,
    this.controller,
    this.hintText,
    this.showEnabledBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextFontStyle.headline14w600c303030urbanist,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextFontStyle.headline16w400c303030urbanist,
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            border: InputBorder.none,
            prefixText: '\$ ',
            prefixStyle: TextFontStyle.headline16w500c202020urbanist,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
