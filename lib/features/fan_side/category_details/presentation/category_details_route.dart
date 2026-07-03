// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
// import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
// import 'package:tc_mcandy/common_widgets/filter_bottom_sheet.dart';
// import 'package:tc_mcandy/constants/app_constants.dart';
// import 'package:tc_mcandy/constants/text_font_style.dart';
// import 'package:tc_mcandy/features/fan_side/home/model/home_content_model.dart';
// import 'package:tc_mcandy/features/fan_side/home/presentation/widget/list_creator_card.dart';
// import 'package:tc_mcandy/gen/assets.gen.dart';
// import 'package:tc_mcandy/gen/colors.gen.dart';
// import 'package:tc_mcandy/helpers/all_routes.dart';
// import 'package:tc_mcandy/helpers/navigation_service.dart';
// import 'package:tc_mcandy/helpers/ui_helpers.dart';
// import 'package:tc_mcandy/networks/api_access.dart';

// class CategoryDetailsRoute extends StatefulWidget {
//   final String title;
//   final List<Celebrity> initialCelebrities;

//   const CategoryDetailsRoute({
//     super.key,
//     required this.title,
//     required this.initialCelebrities,
//   });

//   @override
//   State<CategoryDetailsRoute> createState() => _CategoryDetailsRouteState();
// }

// class _CategoryDetailsRouteState extends State<CategoryDetailsRoute> {
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   Timer? _debounce;

//   String? _selectedPriceRange;
//   String? _selectedSortByPrice;

//   List<Celebrity> _filteredCelebrities = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredCelebrities = List.from(widget.initialCelebrities);
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _scrollController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 300), _filterLocalList);
//   }

//   void _filterLocalList() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       List<Celebrity> result = List.from(widget.initialCelebrities);

//       if (query.isNotEmpty) {
//         result = result
//             .where(
//               (c) =>
//                   (c.name?.toLowerCase().contains(query) ?? false) ||
//                   (c.profession?.toLowerCase().contains(query) ?? false),
//             )
//             .toList();
//       }

//       if (_selectedPriceRange != null && _selectedPriceRange!.isNotEmpty) {
//         result = result.where((c) {
//           final price = double.tryParse(c.startPrice ?? '') ?? 0;
//           if (_selectedPriceRange == '500+') return price >= 500;
//           final parts = _selectedPriceRange!.split('-');
//           if (parts.length == 2) {
//             final min = double.tryParse(parts[0]) ?? 0;
//             final max = double.tryParse(parts[1]) ?? double.infinity;
//             return price >= min && price <= max;
//           }
//           return true;
//         }).toList();
//       }

//       if (_selectedSortByPrice != null) {
//         result.sort((a, b) {
//           final priceA = double.tryParse(a.startPrice ?? '') ?? 0;
//           final priceB = double.tryParse(b.startPrice ?? '') ?? 0;
//           return _selectedSortByPrice == 'low_to_high'
//               ? priceA.compareTo(priceB)
//               : priceB.compareTo(priceA);
//         });
//       }

//       _filteredCelebrities = result;
//     });
//   }

//   Future<void> _refreshData() async {
//     await getHomeContentRxObj.getHomeContent();
//     setState(() {
//       _filteredCelebrities = List.from(widget.initialCelebrities);
//     });
//   }

//   void _showFilterSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => FilterBottomSheet(
//         initialPriceRange: _selectedPriceRange,
//         initialSortByPrice: _selectedSortByPrice,
//         onApply:
//             (priceRange, sortByPrice, {int? categoryId, String? categoryName}) {
//               setState(() {
//                 _selectedPriceRange = priceRange;
//                 _selectedSortByPrice = sortByPrice;
//               });
//               _filterLocalList();
//             },
//       ),
//     );
//   }

//   String _getTierIcon(String? tier) {
//     if (tier == null) return Assets.icons.star1;
//     final lower = tier.toLowerCase();
//     if (lower == 'vip') return Assets.icons.star2;
//     if (lower == 'foundation') return Assets.icons.star3;
//     return Assets.icons.star1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: SizedBox(
//         height: 50.h,
//         width: 50.w,
//         child: FloatingActionButton(
//           onPressed: () {},
//           backgroundColor: AppColors.cFFFFF8,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: AppColors.cC7C7C7, width: 2.w),
//             borderRadius: BorderRadius.circular(30.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 8.h),
//             child: SvgPicture.asset(
//               Assets.icons.aiIcon,
//               height: 60.h,
//               width: 60.w,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         title: CustomAppBar(title: widget.title, onFilterTap: _showFilterSheet),
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         behavior: HitTestBehavior.opaque,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomFormField(
//                 controller: _searchController,
//                 prefixIcon: SvgPicture.asset(Assets.icons.search),
//                 hintText: "Search for your favorite celebrity",
//               ),
//               UIHelper.verticalSpace(20.h),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${_filteredCelebrities.length} results",
//                       style: TextFontStyle.headline16w500c7C7C7Curbanist,
//                     ),
//                     UIHelper.verticalSpace(12.h),
//                     Expanded(
//                       child: _filteredCelebrities.isEmpty
//                           ? Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "No celebrity found",
//                                     style: TextFontStyle
//                                         .headline18w600c303030urbanist,
//                                   ),
//                                   UIHelper.verticalSpace(10.h),
//                                   Text(
//                                     "Try searching for something else",
//                                     style: TextFontStyle
//                                         .headline14w400cADADADurbanist,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : RefreshIndicator(
//                               onRefresh: _refreshData,
//                               child: GridView.builder(
//                                 controller: _scrollController,
//                                 physics: const AlwaysScrollableScrollPhysics(
//                                   parent: BouncingScrollPhysics(),
//                                 ),
//                                 itemCount: _filteredCelebrities.length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       mainAxisSpacing: 12.h,
//                                       crossAxisSpacing: 16.w,
//                                       childAspectRatio: 0.7,
//                                     ),
//                                 itemBuilder: (context, index) {
//                                   final item = _filteredCelebrities[index];
//                                   return ListCreatorCard(
//                                     title: item.name ?? "",
//                                     onTap: () {
//                                       NavigationService.navigateToWithArgs(
//                                         Routes.celebrityDetails,
//                                         {'id': item.id},
//                                       );
//                                     },
//                                     subtitle: item.profession ?? "",
//                                     tstar:
//                                         item.averageRating?.toString() ?? "0",
//                                     hour: "24hr",
//                                     price: item.startPrice ?? "0",
//                                     icon: _getTierIcon(item.tier),
//                                     avatar: item.avatar ?? kDefaultProfileImage,
//                                   );
//                                 },
//                               ),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
