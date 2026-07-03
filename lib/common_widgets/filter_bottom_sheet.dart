import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/row_widget.dart';
import 'package:tc_mcandy/common_widgets/two_button.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/model/profession_category_model/profession_category_model.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(
    String? priceRange,
    String? sortByPrice, {
    int? categoryId,
    String? categoryName,
  })
  onApply;
  final String? initialPriceRange;
  final String? initialSortByPrice;
  final int? initialCategoryId;
  final bool showSubCategories;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    this.initialPriceRange,
    this.initialSortByPrice,
    this.initialCategoryId,
    this.showSubCategories = true,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int sort = -1;
  int price = -1;
  int category = -1;
  bool delivery = false;

  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  bool _isCategoryLoading = false;
  final TextEditingController _categorySearchController =
      TextEditingController();
  int? _initialCategoryId;

  final List<String?> _priceValues = [
    "0-99",
    "99-199",
    "200-299",
    "300-399",
    "500+",
  ];

  final List<String?> _sortValues = ["low_to_high", "high_to_low"];

  @override
  void initState() {
    super.initState();
    if (widget.initialSortByPrice != null) {
      sort = _sortValues.indexOf(widget.initialSortByPrice);
    }
    if (widget.initialPriceRange != null) {
      price = _priceValues.indexOf(widget.initialPriceRange);
    }
    if (widget.showSubCategories) {
      _fetchCategories();
    }
    _categorySearchController.addListener(_onCategorySearch);
    if (widget.initialCategoryId != null) {
      _initialCategoryId = widget.initialCategoryId;
    }
  }

  @override
  void dispose() {
    _categorySearchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    setState(() => _isCategoryLoading = true);
    await getProfessionCategoryRx.fetchProfessionCategory();
    final model = getProfessionCategoryRx.dataFetcher.valueOrNull;
    if (model is ProfessionCategoryModel && mounted) {
      setState(() {
        _categories = model.data?.categories ?? [];
        _filteredCategories = List.from(_categories);
        _isCategoryLoading = false;
        if (_initialCategoryId != null) {
          final idx = _filteredCategories.indexWhere(
            (c) => c.id == _initialCategoryId,
          );
          if (idx >= 0) category = idx;
        }
      });
    } else if (mounted) {
      setState(() => _isCategoryLoading = false);
    }
  }

  void _onCategorySearch() {
    final query = _categorySearchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = List.from(_categories);
      } else {
        _filteredCategories = _categories
            .where((c) => (c.name?.toLowerCase().contains(query) ?? false))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        color: Color(0xFFFFFDF8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            UIHelper.verticalSpace(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter and sort',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      final selectedCat =
                          (category >= 0 &&
                              category < _filteredCategories.length)
                          ? _filteredCategories[category]
                          : null;
                      widget.onApply(
                        price >= 0 ? _priceValues[price] : null,
                        sort >= 0 ? _sortValues[sort] : null,
                        categoryId: selectedCat?.id,
                        categoryName: selectedCat?.name,
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cFF5C24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(16.h),
            Divider(),
            FilterSection(
              title: 'Sort by',
              child: Column(
                children: [
                  radioTile(
                    'Price: Low - High',
                    0,
                    sort,
                    (v) => setState(() => sort = v),
                  ),
                  radioTile(
                    'Price: High - Low',
                    1,
                    sort,
                    (v) => setState(() => sort = v),
                  ),
                ],
              ),
            ),
            FilterSection(
              title: 'Delivery',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      UIHelper.horizontalSpace(6.w),
                      Text(
                        '⚡ 24 hour delivery',
                        style: TextFontStyle.headline14w400CFFFFFFGlacial,
                      ),
                    ],
                  ),
                  Switch(
                    activeTrackColor: AppColors.c2196F3,
                    activeThumbColor: AppColors.c2196F3,
                    value: delivery,
                    onChanged: (v) => setState(() => delivery = v),
                  ),
                ],
              ),
            ),
            FilterSection(
              title: 'Price',
              child: Column(
                children: [
                  radioTile(
                    '\$0 - \$99',
                    0,
                    price,
                    (v) => setState(() => price = v),
                  ),
                  radioTile(
                    '\$100 - \$199',
                    1,
                    price,
                    (v) => setState(() => price = v),
                  ),
                  radioTile(
                    '\$200 - \$299',
                    2,
                    price,
                    (v) => setState(() => price = v),
                  ),
                  radioTile(
                    '\$300 - \$399',
                    3,
                    price,
                    (v) => setState(() => price = v),
                  ),
                  radioTile(
                    '\$500+',
                    4,
                    price,
                    (v) => setState(() => price = v),
                  ),
                ],
              ),
            ),
            if (widget.showSubCategories)
              FilterSection(
                title: 'Categories',
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _categorySearchController,
                      hintText: 'Search ',
                      prefixIcon: SvgPicture.asset(
                        Assets.icons.search,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    if (_isCategoryLoading)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    else if (_filteredCategories.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(child: Text('No categories found')),
                      )
                    else
                      ..._filteredCategories.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final cat = entry.value;
                        return radioTile(
                          cat.name ?? '',
                          idx,
                          category,
                          (v) => setState(() => category = v),
                        );
                      }),
                  ],
                ),
              ),
            UIHelper.verticalSpace(16.h),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.c8E98A8.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: TwoButton(
                onClear: () {
                  setState(() {
                    sort = -1;
                    price = -1;
                    category = -1;
                  });
                  widget.onApply(null, null);
                  Navigator.pop(context);
                },
                onApply: () {
                  final selectedCat =
                      (category >= 0 && category < _filteredCategories.length)
                      ? _filteredCategories[category]
                      : null;
                  widget.onApply(
                    price >= 0 ? _priceValues[price] : null,
                    sort >= 0 ? _sortValues[sort] : null,
                    categoryId: selectedCat?.id,
                    categoryName: selectedCat?.name,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
            UIHelper.verticalSpaceMedium,
          ],
        ),
      ),
    );
  }

  Widget radioTile(String text, int value, int group, Function(int) onChanged) {
    return RadioListTile<int>(
      value: value,
      // ignore: deprecated_member_use
      groupValue: group,
      // ignore: deprecated_member_use
      onChanged: (v) => onChanged(v!),
      title: Text(text),
      activeColor: AppColors.c2196F3,
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
