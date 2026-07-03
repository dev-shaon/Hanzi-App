import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ThreeSections extends StatefulWidget {
  final String selectedFilter;
  final void Function(String filterKey, String filterLabel) onFilterSelected;

  const ThreeSections({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  State<ThreeSections> createState() => _ThreeSectionsState();
}

class _ThreeSectionsState extends State<ThreeSections> {
  late int selectedIndex;

  // label → API key mapping
  static const List<Map<String, String>> filters = [
    {'label': 'All time', 'key': 'all_time'},
    {'label': 'Last week', 'key': 'last_week'},
    {'label': 'Last month', 'key': 'last_month'},
    {'label': 'Last 30 days', 'key': 'last_30_days'},
    {'label': 'Last 15 days', 'key': 'last_15_days'},
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = filters.indexWhere(
      (f) => f['key'] == widget.selectedFilter,
    );
    if (selectedIndex == -1) selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.cADADAD,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            UIHelper.verticalSpace(20.h),
            GestureDetector(
              onTap: () {
                NavigationService.goBack;
              },
              child: SvgPicture.asset(
                Assets.icons.arrowBack,
                height: 24.h,
                width: 24.w,
              ),
            ),
            UIHelper.verticalSpace(20.h),
            ...List.generate(filters.length, (index) {
              final bool isSelected = selectedIndex == index;
              final filter = filters[index];

              return InkWell(
                onTap: () {
                  setState(() => selectedIndex = index);
                  widget.onFilterSelected(filter['key']!, filter['label']!);
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            isSelected
                                ? Assets.icons.underCircle
                                : Assets.icons.circle,
                          ),
                          UIHelper.horizontalSpace(8.w),
                          Text(
                            filter['label']!,
                            style: TextFontStyle.headline16w500c7C7C7Curbanist
                                .copyWith(color: AppColors.c303030),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: AppColors.cADADAD),
                  ],
                ),
              );
            }),
            UIHelper.verticalSpace(20.h),
          ],
        ),
      ),
    );
  }
}
