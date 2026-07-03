import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CRButton extends StatefulWidget {
  final String label;
  final ValueChanged<int?>? onChanged;
  final int? initialValue; 

  const CRButton({
    super.key,
    this.label = "Edit",
    this.onChanged,
    this.initialValue, 
  });

  @override
  State<CRButton> createState() => _CRButtonState();
}

class _CRButtonState extends State<CRButton> {
  late bool isCrossSelected;
  late bool isRightSelected;

  @override
  void initState() {
    super.initState();
 
    isCrossSelected = widget.initialValue == 0;
    isRightSelected = widget.initialValue == 1;
  }

  @override
  void didUpdateWidget(CRButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        isCrossSelected = widget.initialValue == 0;
        isRightSelected = widget.initialValue == 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
            color: AppColors.c303030,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isCrossSelected = !isCrossSelected;
                  isRightSelected = false;
                });
                widget.onChanged?.call(isCrossSelected ? 0 : null);
              },
              child: SvgPicture.asset(
                isCrossSelected ? Assets.icons.redCross : Assets.icons.croseBox,
              ),
            ),
            UIHelper.horizontalSpace(12.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  isRightSelected = !isRightSelected;
                  isCrossSelected = false;
                });
                widget.onChanged?.call(isRightSelected ? 1 : null);
              },
              child: SvgPicture.asset(
                isRightSelected ? Assets.icons.greenRight : Assets.icons.rightBox,
              ),
            ),
          ],
        ),
      ],
    );
  }
}