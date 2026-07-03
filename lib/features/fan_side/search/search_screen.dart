import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/search/widgets/custom_search_tile.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (_searchController.text.isEmpty) {
      getSearchFilterRxObj.clear();
      setState(() {
        _hasSearched = false;
        _isLoading = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchData();
    });
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });
    getSearchFilterRxObj.clear();
    await getSearchFilterRxObj.fetchSearchFilter(
      search: _searchController.text,
    );
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
        child: Column(
          children: [
            UIHelper.verticalSpace(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack,
                    child: SvgPicture.asset(
                      Assets.icons.arrowBack,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: CustomFormField(
                      controller: _searchController,
                      focusBorderColor: AppColors.cADADAD,
                      hintText: "Search",
                    ),
                  ),
                ],
              ),
            ),

            UIHelper.verticalSpace(20.h),

            if (!_hasSearched)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent search",
                      style: TextFontStyle.headline16w500c202020urbanist,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.clear,
                          height: 12.h,
                          width: 12.w,
                        ),
                        Text(
                          " Clear All",
                          style: TextFontStyle.headline12w500c7C7C7CCurbanist,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            UIHelper.verticalSpace(12.h),

            if (_hasSearched)
              Expanded(
                child: StreamBuilder(
                  stream: getSearchFilterRxObj.fillData,
                  builder: (context, asyncSnapshot) {
                    final celebrities = asyncSnapshot.data?.data ?? [];
                    final total =
                        asyncSnapshot.data?.pagination?.total ??
                        celebrities.length;

                    if (_isLoading) {
                      return const CustomShimmer(type: ShimmerType.listShimmer);
                    }

                    if (celebrities.isEmpty) {
                      return Center(
                        child: Text(
                          "No results found",
                          style: TextFontStyle.headline16w500c202020urbanist,
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "$total results",
                            style: TextFontStyle.headline16w500c7C7C7Curbanist,
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Expanded(
                          child: ListView.builder(
                            itemCount: celebrities.length,
                            itemBuilder: (context, index) {
                              final item = celebrities[index];
                              return CustomSearchTile(
                                onTap: () {
                                  NavigationService.navigateToWithArgs(
                                    Routes.celebrityDetails,
                                    {'id': item.id},
                                  );
                                },
                                avatar:
                                    item.avatar ??
                                    kDefaultProfileImage,
                                name: item.name ?? "",
                                category: item.profession ?? "",
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }
}
