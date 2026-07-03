import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String btnName;
  final TextStyle? textStyle;
  final double? borderRadius;
  final Color? bgColor;
  // final Color? fontColor;
  final double? height;
  final double? width;
  // final double? fontSize;
  final bool isGradient;
  final bool? isActive;
  final Color? borderColor;
  final double? borderWidth;
  final bool? isLoading;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.btnName,
    this.textStyle,
    this.isActive = true,
    this.borderRadius,
    this.bgColor,
    this.height,
    this.width,
    // this.fontSize,
    // this.fontColor,
    this.isGradient = true,
    this.borderColor,
    this.borderWidth,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.cBF0707),
            )
          : Container(
              width: width ?? double.infinity,
              height: height ?? 48.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: isActive == true
                  ? ShapeDecoration(
                      color: isGradient ? null : (bgColor ?? AppColors.cFF5C24),
                      gradient: isGradient
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColors.cBF0707, AppColors.cFF5C24],
                            )
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? 22.r,
                        ),
                        side: borderColor != null
                            ? BorderSide(
                                color: borderColor!,
                                width: borderWidth ?? 1,
                              )
                            : BorderSide.none,
                      ),
                    )
                  : ShapeDecoration(
                      color: isGradient ? null : (bgColor ?? AppColors.cFF5C24),
                      gradient: isGradient
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.cBF0707.withValues(alpha: 0.13),
                                AppColors.cFF5C24.withValues(alpha: 0.13),
                              ],
                            )
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? 22.r,
                        ),
                        side: borderColor != null
                            ? BorderSide(
                                color: borderColor!,
                                width: borderWidth ?? 1,
                              )
                            : BorderSide.none,
                      ),
                    ),

              child: FittedBox(
                child: Text(
                  btnName,
                  style:
                      textStyle ?? TextFontStyle.headline16w700cFFFFFFurbanist,
                ),
              ),
            ),
    );
  }
}
