import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CustomDateField extends StatefulWidget {
  final String hint;
  final String? value;
  final ValueChanged<String> onChanged;

  const CustomDateField({
    super.key,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime _selectedDate = DateTime.now();

  void _openDatePicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.cFFA46C),
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: SizedBox(
            height: 300.h,
            width: double.maxFinite,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.cFF5C24,
                  onPrimary: AppColors.cFFFFFF,
                  onSurface: AppColors.c303030,
                ),
              ),
              child: CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now().add(const Duration(days: 365 * 50)),
                onDateChanged: (date) {
                  _selectedDate = date;
                },
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextFontStyle.headline14w500cFF5C24urbanist,
              ),
            ),
            TextButton(
              onPressed: () {
                widget.onChanged(
                  "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                );
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextFontStyle.headline14w500cFF5C24urbanist,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDatePicker(context),
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.cADADAD),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(Assets.icons.date),
                UIHelper.horizontalSpace(10.w),
                Text(
                  widget.value ?? widget.hint,
                  style: TextFontStyle.headline16w400c303030urbanist.copyWith(
                    color: widget.value == null
                        ? AppColors.c7C7C7C
                        : AppColors.c303030,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(Assets.icons.arrowDownFigma, height: 20.h),
          ],
        ),
      ),
    );
  }
}
