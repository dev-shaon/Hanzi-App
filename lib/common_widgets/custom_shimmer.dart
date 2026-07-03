import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

enum ShimmerType {
  /// Vertical list shimmer — used in SearchScreen (height: 50.h)
  listShimmer,

  /// Vertical list shimmer with horizontal padding — used in RequestsScreen (height: 70.h)
  orderListShimmer,

  /// 2-column grid shimmer — used in CategoryDetailsRoute & HomeScreen category section
  categoryGridShimmer,

  /// Horizontal creator-card shimmer with image + text lines — used in HomeScreen
  creatorCardShimmer,

  /// Horizontal plain-box shimmer (parametric width/height) — used in CelebrityDetails videos
  horizontalBoxShimmer,

  /// Profile header shimmer: circle avatar + text lines — used in CelebrityDetails header
  headerShimmer,

  /// 2-column vertical grid shimmer with creator cards
  verticalCreatorGrid,
}

class CustomShimmer extends StatelessWidget {
  final ShimmerType type;

  /// Item count for list/grid/horizontal shimmers. Default: 4.
  final int itemCount;

  /// Used only for [ShimmerType.horizontalBoxShimmer]
  final double? boxWidth;

  /// Used only for [ShimmerType.horizontalBoxShimmer]
  final double? boxHeight;

  /// Used only for [ShimmerType.categoryGridShimmer] when inside a scrollable column
  final bool shrinkWrap;

  const CustomShimmer({
    super.key,
    required this.type,
    this.itemCount = 4,
    this.boxWidth,
    this.boxHeight,
    this.shrinkWrap = false,
  });

  // ─── shared shimmer wrapper ───────────────────────────────────────────────
  Widget _shimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }

  // ─── 1. listShimmer ───────────────────────────────────────────────────────
  Widget _buildListShimmer() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, _) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: _shimmer(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }

  // ─── 2. orderListShimmer ──────────────────────────────────────────────────
  Widget _buildOrderListShimmer() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, _) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: _shimmer(
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }

  // ─── 3. categoryGridShimmer ───────────────────────────────────────────────
  Widget _buildCategoryGridShimmer() {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (_, _) => _shimmer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }

  // ─── 4. creatorCardShimmer ────────────────────────────────────────────────
  Widget _buildCreatorCardShimmer() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, _) => Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: _shimmer(child: _creatorCard()),
      ),
    );
  }

  Widget _creatorCard() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          UIHelper.verticalSpace(10.h),
          Container(
            width: 90.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Container(
            width: 65.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          UIHelper.verticalSpace(8.h),
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              UIHelper.horizontalSpace(4.w),
              Container(
                width: 25.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              Container(
                width: 12.w,
                height: 12.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              UIHelper.horizontalSpace(4.w),
              Container(
                width: 25.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(5.h),
          Container(
            width: 45.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  // ─── 5. horizontalBoxShimmer ──────────────────────────────────────────────
  Widget _buildHorizontalBoxShimmer() {
    final w = (boxWidth ?? 150).w;
    final h = (boxHeight ?? 180).h;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, _) => Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: _shimmer(
          child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  // ─── 6. headerShimmer ────────────────────────────────────────────────────
  Widget _buildHeaderShimmer() {
    return _shimmer(
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          UIHelper.horizontalSpace(12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Container(
                width: 80.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── 7. verticalCreatorGridShimmer ───────────────────────────────────────
  Widget _gridCreatorCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1, // Exact square for the profile/thumbnail image
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        UIHelper.verticalSpace(10.h),
        Container(
          width: 100.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        UIHelper.verticalSpace(6.h),
        Container(
          width: 70.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        UIHelper.verticalSpace(10.h),
        Row(
          children: [
            Container(
              width: 12.w,
              height: 12.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            UIHelper.horizontalSpace(4.w),
            Container(
              width: 20.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            UIHelper.horizontalSpace(12.w),
            Container(
              width: 12.w,
              height: 12.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            UIHelper.horizontalSpace(4.w),
            Container(
              width: 20.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(10.h),
        Container(
          width: 60.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalCreatorGridShimmer() {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio:
            0.62, // Adjusted for the extra text/meta rows in grid vision
      ),
      itemBuilder: (_, _) => _shimmer(child: _gridCreatorCard()),
    );
  }

  // ─── build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ShimmerType.listShimmer:
        return _buildListShimmer();
      case ShimmerType.orderListShimmer:
        return _buildOrderListShimmer();
      case ShimmerType.categoryGridShimmer:
        return _buildCategoryGridShimmer();
      case ShimmerType.creatorCardShimmer:
        return _buildCreatorCardShimmer();
      case ShimmerType.horizontalBoxShimmer:
        return _buildHorizontalBoxShimmer();
      case ShimmerType.headerShimmer:
        return _buildHeaderShimmer();
      case ShimmerType.verticalCreatorGrid:
        return _buildVerticalCreatorGridShimmer();
    }
  }
}
