import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class CountryField extends StatefulWidget {
  final Function(Country) onSelect;

  const CountryField({super.key, required this.onSelect});

  @override
  State<CountryField> createState() => _CountryFieldState();
}

class _CountryFieldState extends State<CountryField> {
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.cADADAD),
        color: AppColors.cFFFFFF,
      ),
      child: ListTile(
        dense: true,
        horizontalTitleGap: -5.w,
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            countryListTheme: CountryListThemeData(
              bottomSheetHeight: 400.h,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              inputDecoration: InputDecoration(
                hintText: 'Search country',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: SvgPicture.asset(Assets.icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            onSelect: (Country country) {
              setState(() {
                selectedCountry = country;
              });
              widget.onSelect(country);
            },
          );
        },
        leading: selectedCountry == null
            ? SvgPicture.asset(Assets.icons.country)
            : Text(
                selectedCountry!.flagEmoji,
                style: TextFontStyle.headline16w400c303030urbanist.copyWith(
                  color: AppColors.c303030,
                ),
              ),
        title: Text(
          selectedCountry == null ? "Country" : selectedCountry!.name,
          style: TextFontStyle.headline16w400c303030urbanist.copyWith(
            color: selectedCountry == null
                ? AppColors.c7C7C7C
                : AppColors.c303030,
          ),
        ),

        trailing: SvgPicture.asset(Assets.icons.arrowDownFigma),
      ),
    );
  }
}
