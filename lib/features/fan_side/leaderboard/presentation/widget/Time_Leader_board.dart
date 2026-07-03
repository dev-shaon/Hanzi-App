import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_network_image.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/model/leaderboard_model.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/presentation/widget/rank_list.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class TimeLeaderBoard extends StatefulWidget {
  const TimeLeaderBoard({super.key});

  @override
  State<TimeLeaderBoard> createState() => _TimeLeaderBoardState();
}

class _TimeLeaderBoardState extends State<TimeLeaderBoard> {
  bool _isLoading = false;
  List<Datum> _leaderboardData = [];

  @override
  void initState() {
    super.initState();
    _getLeaderBoard();
  }

  Future<void> _getLeaderBoard() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    await getLeaderBoardRxObj.fetchLeaderboard();
    if (!mounted) return;
    final model = getLeaderBoardRxObj.fillData.valueOrNull;
    if (model is LeaderBoardModel && model.data != null) {
      setState(() => _leaderboardData = model.data!.take(10).toList());
    }
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  Datum? _getByRank(int rank) {
    try {
      return _leaderboardData.firstWhere((e) => e.rank == rank);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int? currentUserId = int.tryParse(appData.read(kKeyUserId)?.toString() ?? '');

    final first = _getByRank(1);
    final second = _getByRank(2);
    final third = _getByRank(3);

    final rest = _leaderboardData.where((e) => (e.rank ?? 0) > 3).toList()
      ..sort((a, b) => (a.rank ?? 0).compareTo(b.rank ?? 0));

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    double dynamicHeight = rest.isEmpty ? 250.h : 160.h + (rest.length * 78.h);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cC7C7C7),
            color: AppColors.cFFFFF8.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top 10 Leaderboard 🏆',
                style: TextFontStyle.headline20w600c303030urbanist,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Personalized videos from the top talent on HanZi ✨',
                style: TextFontStyle.headline16w500c7C7C7Curbanist,
              ),
            ],
          ),
        ),
        UIHelper.verticalSpace(160.h),
        Container(
          width: double.infinity,
          height: dynamicHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            image: DecorationImage(
              image: AssetImage(Assets.images.ranck.path),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 2nd place — left
              if (second != null)
                Positioned(
                  top: -100.h,
                  left: 20.w,
                  child: _TopRankCard(
                    datum: second,
                    isHighlighted: second.id == currentUserId,
                  ),
                ),

              // 1st place — center
              if (first != null)
                Positioned(
                  top: -125.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _TopRankCard(
                      datum: first,
                      isHighlighted: first.id == currentUserId,
                    ),
                  ),
                ),

              // King crown — center
              Positioned(
                top: -160.h,
                left: 0,
                right: 0,
                child: Center(child: SvgPicture.asset(Assets.icons.king)),
              ),

              // 3rd place — right
              if (third != null)
                Positioned(
                  top: -95.h,
                  right: 20.w,
                  child: _TopRankCard(
                    datum: third,
                    isHighlighted: third.id == currentUserId,
                  ),
                ),

              // Ranks 4–10
              Positioned(
                top: 150.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ListView.separated(
                    itemCount: rest.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, _) => UIHelper.verticalSpace(6.h),
                    itemBuilder: (context, index) {
                      return RankList(
                        datum: rest[index],
                        isHighlighted: rest[index].id == currentUserId,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Top 3 Card ──────────────────────────────────────────────────────────────

class _TopRankCard extends StatelessWidget {
  final Datum datum;
  final bool isHighlighted;

  const _TopRankCard({required this.datum, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    const highlightColor = Color(0xFFFF5F44);
    return SizedBox(
      width: 90.w,
      child: Column(
        children: [
          Container(
            decoration: isHighlighted
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: highlightColor, width: 3),
                  )
                : null,
            child: ClipOval(
              child: CustomNetworkImage(
                urls: datum.avatar ?? '',
                height: 68.h,
                width: 68.w,
              ),
            ),
          ),
          UIHelper.verticalSpace(9.h),
          Text(
            datum.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextFontStyle.headline12w400c303030urbanist.copyWith(
              fontWeight: FontWeight.w600,
              color: isHighlighted ? highlightColor : AppColors.c303030,
            ),
          ),
        ],
      ),
    );
  }
}
