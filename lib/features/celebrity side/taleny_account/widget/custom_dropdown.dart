import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        value: value,

        hint: Row(
          children: [
            SvgPicture.asset(Assets.icons.people, height: 24.h, width: 24.w),
            UIHelper.horizontalSpace(8.w),
            Text(
              hint,
              style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
                color: AppColors.c7C7C7C,
              ),
            ),
          ],
        ),

        selectedItemBuilder: (context) {
          return items.map((item) {
            return Row(
              children: [
                Transform.translate(
                  offset: Offset(-10, 0),
                  child: SvgPicture.asset(
                    Assets.icons.people,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),

                // UIHelper.horizontalSpace(8.w),
                Text(item, style: TextFontStyle.headline16w400c303030urbanist),
              ],
            );
          }).toList();
        },

        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextFontStyle.headline16w400c303030urbanist,
            ),
          );
        }).toList(),

        onChanged: onChanged,

        buttonStyleData: ButtonStyleData(
          height: 48.h,
          padding: EdgeInsets.only(left: 0.w, right: 12.w), 
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.c7C7C7C),
          ),
        ),

        iconStyleData: IconStyleData(
          icon: SvgPicture.asset(Assets.icons.arrowDownFigma, height: 20.h),
        ),

        dropdownStyleData: DropdownStyleData(
          maxHeight: 220.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.cFF5C24.withValues(alpha: 0.4)),
          ),
          padding: EdgeInsets.all(8.w),
        ),

        menuItemStyleData: MenuItemStyleData(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          selectedMenuItemBuilder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.cFF5C24.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.centerLeft,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
