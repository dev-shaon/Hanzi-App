import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/features/fan_side/home/model/home_content_model.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/widget/category_card.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/widget/creator_card.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/widget/custom_text.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/widget/home_ber.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/widget/order_card.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  void fetchCategory() async {
    await getHomeContentRxObj.getHomeContent();
  }

  String _getTierIcon(String? tier) {
    if (tier == null) return Assets.icons.star1;
    final lowercaseTier = tier.toLowerCase();
    if (lowercaseTier == 'vip') return Assets.icons.star2;
    if (lowercaseTier == 'foundation') return Assets.icons.star3;
    return Assets.icons.star1;
  }

  List<Map<String, dynamic>> orders = [
    {'title': 'Under \$25', 'price': '\$25', 'priceRange': 25},
    {'title': 'Under \$50', 'price': '\$50', 'priceRange': 50},
    {'title': 'Under \$100', 'price': '\$100', 'priceRange': 100},
    {'title': 'Under \$200', 'price': '\$200', 'priceRange': 200},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 50.h,
        width: 50.w,
        child: FloatingActionButton(
          heroTag: 'homeSupportFab',
          onPressed: () {
            NavigationService.navigateTo(Routes.customerSupportScreen);
          },
          backgroundColor: AppColors.cFFFFF8,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.cC7C7C7, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: SvgPicture.asset(
              Assets.icons.aiIcon,
              height: 60.h,
              width: 60.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: EdgeInsets.symmetric(horizontal: 20.w),
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder(
            stream: getHomeContentRxObj.fillData,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Failed to load content. Please try again.",
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final bool isLoading =
                  asyncSnapshot.connectionState == ConnectionState.waiting;

              HomeContentModel? get = asyncSnapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const HomeBer(),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomFormField(
                      onTap: () =>
                          NavigationService.navigateTo(Routes.searchScreen),
                      isRead: true,
                      hintText: "Search for your favorite celebrity",
                      prefixIcon: SvgPicture.asset(Assets.icons.search),
                    ),
                  ),
                  UIHelper.verticalSpace(24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(title: 'Personalized videos by category'),
                  ),
                  UIHelper.verticalSpace(18.h),

                  isLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: const CustomShimmer(
                            type: ShimmerType.categoryGridShimmer,
                            shrinkWrap: true,
                            itemCount: 6,
                          ),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 2.5,
                              ),
                          itemCount: get?.categories?.length ?? 0,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              text: get?.categories?[index].name ?? "Unknown",
                              onTap: () {
                                NavigationService.navigateToWithArgs(
                                  Routes.categoryByProfession,
                                  {
                                    'title': get?.categories?[index].name,
                                    'id': get?.categories?[index].id,
                                  },
                                );
                              },
                              imageurls: get?.categories?[index].image ?? "",
                            );
                          },
                        ),

                  UIHelper.verticalSpace(32.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(
                      title: "HanZi's Picks",
                      subtitle: get?.featuredCelebrities?.isEmpty ?? true
                          ? ""
                          : "Show All",
                      ontap: () {
                        NavigationService.navigateToWithArgs(
                          Routes.showAllFeatured,
                          {'title': "HanZi's Picks"},
                        );
                      },
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  isLoading
                      ? SizedBox(
                          height: 255.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: const CustomShimmer(
                              type: ShimmerType.creatorCardShimmer,
                            ),
                          ),
                        )
                      : get?.featuredCelebrities?.isEmpty ?? true
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Text("No HanZi's Picks Found"),
                          ),
                        )
                      : SizedBox(
                          height: 255.h,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: get?.featuredCelebrities?.length ?? 0,
                            itemBuilder: (context, index) {
                              final isLastIndex =
                                  index ==
                                  (get?.featuredCelebrities?.length ?? 0) - 1;
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: isLastIndex ? 12.w : 0,
                                ),
                                child: CreatorCard(
                                  avatar:
                                      get?.featuredCelebrities?[index].avatar ??
                                      "",
                                  onTap: () {
                                    NavigationService.navigateToWithArgs(
                                      Routes.celebrityDetails,
                                      {
                                        'id':
                                            get?.featuredCelebrities?[index].id,
                                      },
                                    );
                                  },
                                  title:
                                      get?.featuredCelebrities?[index].name ??
                                      "Unknown",
                                  subtitle:
                                      get
                                          ?.featuredCelebrities?[index]
                                          .profession ??
                                      "Unknown",
                                  icon: _getTierIcon(
                                    get?.featuredCelebrities?[index].tier,
                                  ),
                                  tstar:
                                      get
                                          ?.featuredCelebrities?[index]
                                          .averageRating
                                          .toString() ??
                                      "0",
                                  hour: "1h",
                                  price:
                                      "\$${get?.featuredCelebrities?[index].startPrice ?? 0}+",
                                ),
                              );
                            },
                          ),
                        ),

                  UIHelper.verticalSpace(22.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(title: "Top 10 on HanZi"),
                  ),
                  UIHelper.verticalSpace(12.h),
                  SizedBox(
                    height: 255.h,
                    child: isLoading
                        ? const CustomShimmer(
                            type: ShimmerType.creatorCardShimmer,
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: get?.topCelebrities?.length ?? 0,
                            itemBuilder: (context, index) {
                              final isLastIndex =
                                  index ==
                                  (get?.topCelebrities?.length ?? 0) - 1;
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: isLastIndex ? 12.w : 0,
                                ),
                                child: CreatorCard(
                                  avatar:
                                      get?.topCelebrities?[index].avatar ?? "",
                                  onTap: () {
                                    NavigationService.navigateToWithArgs(
                                      Routes.celebrityDetails,
                                      {'id': get?.topCelebrities?[index].id},
                                    );
                                  },
                                  title:
                                      get?.topCelebrities?[index].name ??
                                      "Unknown",
                                  subtitle:
                                      get?.topCelebrities?[index].profession ??
                                      "Unknown",
                                  icon: _getTierIcon(
                                    get?.topCelebrities?[index].tier,
                                  ),
                                  tstar:
                                      get?.topCelebrities?[index].averageRating
                                          .toString() ??
                                      "0",
                                  hour: "1h",
                                  price:
                                      "\$${get?.topCelebrities?[index].startPrice ?? 0}+",
                                ),
                              );
                            },
                          ),
                  ),

                  UIHelper.verticalSpace(22.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(
                      title: "New And Trending",
                      subtitle: "Show All",
                      ontap: () {
                        NavigationService.navigateToWithArgs(
                          Routes.showAllRecent,
                          {'title': "New And Trending"},
                        );
                      },
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  SizedBox(
                    height: 255.h,
                    child: isLoading
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: const CustomShimmer(
                              type: ShimmerType.creatorCardShimmer,
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: get?.recentCelebrities?.length ?? 0,
                            itemBuilder: (context, index) {
                              final isLastIndex =
                                  index ==
                                  (get?.recentCelebrities?.length ?? 0) - 1;
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: isLastIndex ? 12.w : 0,
                                ),
                                child: CreatorCard(
                                  avatar:
                                      get?.recentCelebrities?[index].avatar ??
                                      "",
                                  onTap: () {
                                    NavigationService.navigateToWithArgs(
                                      Routes.celebrityDetails,
                                      {'id': get?.recentCelebrities?[index].id},
                                    );
                                  },
                                  title:
                                      get?.recentCelebrities?[index].name ??
                                      "Unknown",
                                  subtitle:
                                      get
                                          ?.recentCelebrities?[index]
                                          .profession ??
                                      "Unknown",
                                  icon: _getTierIcon(
                                    get?.recentCelebrities?[index].tier,
                                  ),
                                  tstar:
                                      get
                                          ?.recentCelebrities?[index]
                                          .averageRating
                                          .toString() ??
                                      "0",
                                  hour: "1h",
                                  price:
                                      "\$${get?.recentCelebrities?[index].startPrice ?? 0}+",
                                ),
                              );
                            },
                          ),
                  ),

                  UIHelper.verticalSpace(22.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(title: "Order by price"),
                  ),
                  UIHelper.verticalSpace(12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 2.5,
                          ),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final data = orders[index];
                        return OrderCard(
                          text: data['title'] ?? "",
                          price: data['price'] ?? "",

                          onTap: () {
                            NavigationService.navigateToWithArgs(
                              Routes.showAllByPrice,
                              {
                                'title': data['title'] ?? '',
                                'priceRange': data['priceRange'] ?? 0,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  UIHelper.verticalSpace(22.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
