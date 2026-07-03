import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/following/model/fan_follower_model.dart';
import 'package:tc_mcandy/features/fan_side/following/presentation/widget/following_list.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../../networks/api_access.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  int? _unfollowingId;

  @override
  void initState() {
    super.initState();
    _fetchFollowingList();
  }

  Future<void> _fetchFollowingList() async {
    await getFollowingListRxObj.fetchFollowingList();
  }

  void _postFollow(int id) async {
    try {
      setState(() {
        _unfollowingId = id;
      });
      bool success = await postFollowRxObj.postFollow(id: id);
      if (success) {
        setState(() {
          _unfollowingId = null;
        });
        await _fetchFollowingList();
      }
    } catch (e) {
      customToastMessage("Error", "Failed to unfollow");
    } finally {
      setState(() {
        _unfollowingId = null;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _fetchFollowingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Following",
          style: TextFontStyle.headline24w600c303030urbanist,
        ),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.c303030,
        child: StreamBuilder(
          stream: getFollowingListRxObj.fillData,
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 12.h),
                    Text(
                      "Failed to load following list. Pull to refresh.",
                      style: TextFontStyle.headline16w500c202020urbanist,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            FanFollowerModel? get = snapShot.data;

            if (get == null || get.data == null || get.data!.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.icons.runStar),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Keep up with your favorite stars",
                              style:
                                  TextFontStyle.headline18w600c303030urbanist,
                            ),
                            UIHelper.verticalSpaceMedium,
                            Text(
                              "Follow talent for exclusive updates, quick access, and easy booking.",
                              style: TextFontStyle.headline16w500c202020urbanist
                                  .copyWith(color: AppColors.c7C7C7C),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: get.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateToWithArgs(
                          Routes.celebrityDetails,
                          {'id': get.data![index].id},
                        );
                      },
                      child: FollowingList(
                        name: get.data![index].name ?? '',
                        role: get.data![index].profession ?? 'Unknown',
                        avatar:
                            get.data?[index].avatar ??
                            kDefaultProfileImage,
                        onTap: () {
                          _postFollow(get.data![index].id!);
                        },
                        isLoading: _unfollowingId == get.data![index].id,
                      ),
                    ),
                    Divider(color: AppColors.cADADAD, height: 2.h),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
