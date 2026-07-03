import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/model/celebrity_package_model.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/order_plan_widget.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _tabInitialized = false;

  @override
  void initState() {
    super.initState();
    _celebrityPackage();
  }

  void _celebrityPackage() async {
    await getCelebrityPackageRxObj.fetchCelebrityPackageData();
  }

  void _initTabController(List<Package> packages) {
    if (_tabInitialized && _tabController?.length == packages.length) return;

    _tabController?.dispose();
    _tabController = TabController(length: packages.length, vsync: this);
    _tabInitialized = true;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
        title: Text(
          "Packages",
          style: TextFontStyle.headline24w600c303030urbanist,
        ),
        centerTitle: true,
        actions: [
          if (appData.read(kkeyIsManager) != true)
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(Routes.editPackages);
                },
                child: SvgPicture.asset(
                  Assets.icons.editIcon,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
        ],
      ),
      body: StreamBuilder(
        stream: getCelebrityPackageRxObj.fillData,
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = asyncSnapshot.data!;
          final post = data.data?.post;
          final packages = (post?.packages ?? []);

          if (packages.isEmpty) {
            return const Center(child: Text("No packages available"));
          }

          _initTabController(packages);

          if (_tabController == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post?.mainTitle ??
                      "I will make videos for your special occasions.",
                  style: TextFontStyle.headline24w600c303030urbanist,
                ),
                UIHelper.verticalSpace(16.h),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final desc = post?.description ?? "";
                    final textPainter = TextPainter(
                      text: TextSpan(
                        text: desc,
                        style: TextFontStyle.headline14w400CFFFFFFGlacial
                            .copyWith(color: AppColors.c303030),
                      ),
                      maxLines: 3,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    return _DescriptionWidget(
                      description: desc,
                      isOverflow: textPainter.didExceedMaxLines,
                    );
                  },
                ),

                UIHelper.verticalSpace(28.h),

                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.cFF5C24,
                  labelColor: AppColors.cFF5C24,
                  unselectedLabelColor: AppColors.c303030,
                  labelStyle: TextFontStyle.headline16w600c303030urbanist,
                  tabs: packages
                      .map<Tab>((p) => Tab(text: '\$${p.price ?? "0"}'))
                      .toList(),
                ),

                UIHelper.verticalSpace(20.h),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: packages.map<Widget>((p) {
                      return OrderPlanWidget(
                        title: p.packageName ?? "",
                        description: p.description ?? "",
                        revisions: p.revisionLimit ?? "0",
                        deliveryDays: p.deliveryDays ?? "0",
                        isEditable: (p.editable ?? 0) == 1,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DescriptionWidget extends StatefulWidget {
  final String description;
  final bool isOverflow;

  const _DescriptionWidget({
    required this.description,
    required this.isOverflow,
  });

  @override
  State<_DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<_DescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextFontStyle.headline14w400CFFFFFFGlacial.copyWith(
            color: AppColors.c303030,
          ),
        ),
        if (widget.isOverflow)
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Text(
              _isExpanded ? 'See less' : 'See more',
              style: TextFontStyle.headline14w500cFF5C24urbanist.copyWith(
                color: AppColors.c34A853,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}
