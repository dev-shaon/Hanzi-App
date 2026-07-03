import 'package:flutter/material.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomRichText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
  text: TextSpan(
    text: text1,

    style: TextFontStyle.headline16w500c7C7C7Curbanist,
    children:  <TextSpan>[

      TextSpan(text: text2, style: TextFontStyle.headline16w500c202020urbanist),
    ],
  ),
);
  }
}