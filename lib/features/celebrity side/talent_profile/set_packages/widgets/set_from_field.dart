import 'package:flutter/material.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class SetFromField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const SetFromField({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,       
      minLines: 1,  
      controller: controller,
      keyboardType: TextInputType.multiline,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextFontStyle.headline14w400cADADADurbanist,

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.c8E98A8),
        ),

        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.cFF5C24),
        ),
      ),
    );
  }
}

