import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/model/profession_category_model/profession_category_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/widgets/profession_dropdown.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/widgets/professionals_container.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/categories_by_profession_model.dart';

class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({super.key});

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  @override
  void initState() {
    super.initState();
    _getProfessionCategory();
  }

  void _getProfessionCategory() async {
    await getProfessionCategoryRx.fetchProfessionCategory();
  }

  String? selectedPlatform;
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: "", showFilter: false),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: StreamBuilder(
            stream: getProfessionCategoryRx.fillData,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (asyncSnapshot.hasError) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text("Failed to load professions. Please try again."),
                    ],
                  ),
                );
              }

              final ProfessionCategoryModel? get = asyncSnapshot.data;

              final List<String> categoryList = (get?.data?.categories ?? [])
                  .map((e) => e.name ?? "")
                  .where((e) => e.isNotEmpty)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What are you most known for?",
                    style: TextFontStyle.headline24w600c303030urbanist,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Help fans find you by adding what you're known for, Your profession displays under your photo across the site. so use what's most relevant and notable.",
                    style: TextFontStyle.headline16w500c7C7C7Curbanist,
                  ),
                  UIHelper.verticalSpace(33.h),
                  Text(
                    "Profession",
                    style: TextFontStyle.headline16w500cADADADurbanist.copyWith(
                      color: AppColors.c303030,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  ProfessionDropdown(
                    hint: 'Select Profession',
                    value: selectedPlatform,
                    items: categoryList,
                    onChanged: (value) {
                      setState(() {
                        selectedPlatform = value;
                        selectedCategoryId = get?.data?.categories
                            ?.firstWhere((e) => e.name == value)
                            .id;
                      });
                      if (selectedCategoryId != null) {
                        getCategoryByProfessionRxObj.fetchCategoryByProfession(
                          selectedCategoryId!,
                        );
                      }
                    },
                  ),
                  UIHelper.verticalSpace(27.h),
                  selectedCategoryId == null
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Profession",
                              style: TextFontStyle.headline16w500cADADADurbanist
                                  .copyWith(color: AppColors.c303030),
                            ),
                            UIHelper.verticalSpace(8.h),
                            StreamBuilder(
                              stream: getCategoryByProfessionRxObj.fillData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 255.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                final CategoryByProfessionModel? categoryData =
                                    snapshot.data as CategoryByProfessionModel?;
                                final celebritiesList =
                                    categoryData?.data?.celebrities ?? [];

                                if (celebritiesList.isEmpty) {
                                  return SizedBox(
                                    height: 255.h,
                                    child: const Center(
                                      child: Text("No professionals found."),
                                    ),
                                  );
                                }

                                final displayList = celebritiesList
                                    .take(5)
                                    .toList();

                                return SizedBox(
                                  height: 255.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: displayList.length,
                                    itemBuilder: (context, index) {
                                      final item = displayList[index];
                                      return Padding(
                                        padding: EdgeInsets.only(right: 12.w),
                                        child: ProfessionalsContainer(
                                          imageUrl: item.avatar ?? '',
                                          name: item.name ?? '',
                                          profession: item.profession ?? '',
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  Spacer(),
                  CustomButton(
                    onTap: selectedPlatform != null
                        ? () {
                            appData.write(kkeyCategoryId, selectedCategoryId);
                            NavigationService.navigateTo(
                              Routes.aboutProfession,
                            );
                          }
                        : null,
                    isActive: selectedPlatform != null,
                    btnName: "Continue",
                  ),
                  UIHelper.verticalSpace(20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
