import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/filter_bottom_sheet.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/home/model/featured_celebrity_model.dart'
    as featured_model;
import 'package:tc_mcandy/features/fan_side/home/presentation/widget/list_creator_card.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ShowAllFeaturedScreen extends StatefulWidget {
  final String title;

  const ShowAllFeaturedScreen({super.key, required this.title});

  @override
  State<ShowAllFeaturedScreen> createState() => _ShowAllFeaturedScreenState();
}

class _ShowAllFeaturedScreenState extends State<ShowAllFeaturedScreen> {
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  String? _selectedPriceRange;
  String? _selectedSortByPrice;
  String? _selectedCategoryName;

  List<featured_model.Datum> _allItems = [];
  List<featured_model.Datum> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _allItems = [];
      _filteredItems = [];
    });

    try {
      int currentPage = 1;
      int lastPage = 1;

      do {
        await getFeaturedCelebrityRxObj.fetchFeaturedCelebrity(
          page: currentPage,
        );
        final snapshot = getFeaturedCelebrityRxObj.dataFetcher.value;
        if (snapshot is featured_model.FeaturedCelebrityModel) {
          final newItems = snapshot.data ?? [];
          _allItems.addAll(newItems);
          lastPage = snapshot.pagination?.lastPage ?? 1;
          currentPage++;
        } else {
          break;
        }
      } while (currentPage <= lastPage);

      setState(() {
        _filteredItems = List.from(_allItems);
        _applyFilters();
      });
    } catch (e) {
      log("Error fetching featured celebrities: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _applyFilters);
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      List<featured_model.Datum> result = List.from(_allItems);

      if (query.isNotEmpty) {
        result = result
            .where(
              (c) =>
                  (c.name?.toLowerCase().contains(query) ?? false) ||
                  (c.profession?.toLowerCase().contains(query) ?? false),
            )
            .toList();
      }

      if (_selectedCategoryName != null && _selectedCategoryName!.isNotEmpty) {
        result = result
            .where(
              (c) =>
                  c.profession?.toLowerCase() ==
                  _selectedCategoryName!.toLowerCase(),
            )
            .toList();
      }

      if (_selectedPriceRange != null && _selectedPriceRange!.isNotEmpty) {
        result = result.where((c) {
          final price = double.tryParse(c.startPrice ?? '') ?? 0;
          if (_selectedPriceRange == '500+') return price >= 500;
          final parts = _selectedPriceRange!.split('-');
          if (parts.length == 2) {
            final min = double.tryParse(parts[0]) ?? 0;
            final max = double.tryParse(parts[1]) ?? double.infinity;
            return price >= min && price <= max;
          }
          return true;
        }).toList();
      }

      if (_selectedSortByPrice != null) {
        result.sort((a, b) {
          final priceA = double.tryParse(a.startPrice ?? '') ?? 0;
          final priceB = double.tryParse(b.startPrice ?? '') ?? 0;
          return _selectedSortByPrice == 'low_to_high'
              ? priceA.compareTo(priceB)
              : priceB.compareTo(priceA);
        });
      }

      _filteredItems = result;
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => FilterBottomSheet(
        initialPriceRange: _selectedPriceRange,
        initialSortByPrice: _selectedSortByPrice,
        onApply:
            (priceRange, sortByPrice, {int? categoryId, String? categoryName}) {
              setState(() {
                _selectedPriceRange = priceRange;
                _selectedSortByPrice = sortByPrice;
                _selectedCategoryName = categoryName;
              });
              _applyFilters();
            },
      ),
    );
  }

  String _getTierIcon(String? tier) {
    if (tier == null) return Assets.icons.star1;
    final lower = tier.toLowerCase();
    if (lower == 'vip') return Assets.icons.star2;
    if (lower == 'foundation') return Assets.icons.star3;
    return Assets.icons.star1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: widget.title, onFilterTap: _showFilterSheet),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormField(
                controller: _searchController,
                prefixIcon: SvgPicture.asset(Assets.icons.search),
                hintText: "Search for your favorite celebrity",
              ),
              UIHelper.verticalSpace(20.h),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final items = _filteredItems;
    final total = items.length;
    final bool showShimmer = _isLoading && items.isEmpty;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isLoading && items.isEmpty ? "" : "$total results",
            style: TextFontStyle.headline16w500c7C7C7Curbanist,
          ),
          UIHelper.verticalSpace(12.h),
          Expanded(
            child: showShimmer
                ? const CustomShimmer(type: ShimmerType.verticalCreatorGrid)
                : items.isEmpty
                ? const Center(child: Text("No celebrity found"))
                : RefreshIndicator(
                    onRefresh: _fetchData,
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListCreatorCard(
                          title: item.name ?? "",
                          onTap: () {
                            NavigationService.navigateToWithArgs(
                              Routes.celebrityDetails,
                              {'id': item.id},
                            );
                          },
                          subtitle: item.profession ?? "",
                          tstar: item.averageRating?.toString() ?? "0",
                          hour: "24hr",
                          price: "\$${item.startPrice}",
                          icon: _getTierIcon(item.tier),
                          avatar: item.avatar ?? kDefaultProfileImage,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
