import 'package:flutter/material.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? ontap; 

  const CustomText({
    super.key,
    required this.title,
    this.subtitle,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextFontStyle.headline16w600c303030urbanist,
        ),

        if (subtitle != null)
          GestureDetector(
            onTap: ontap,
            child: Text(
              subtitle!,
              style: TextFontStyle.headline14w500cFF5C24urbanist,
            ),
          ),
      ],
    );
  }
}
