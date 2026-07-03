import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/profile_screen.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/message_screen.dart';
import 'package:tc_mcandy/features/fan_side/following/presentation/following_screen.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/home_screen.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/presentation/leaderboard_screen.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class NavberScreen extends StatefulWidget {
  const NavberScreen({super.key});

  @override
  State<NavberScreen> createState() => _NavberScreenState();
}

class _NavberScreenState extends State<NavberScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LeaderboardScreen(),
    MessageScreen(),
    FollowingScreen(),
    ProfileScreen(),
  ];

  Color iconColor(int index) {
    return _currentIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.c8E98A8, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: AppColors.cFF5C24,
            unselectedItemColor: AppColors.c303030,
            backgroundColor: AppColors.cFFFFF8,
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.homeBlack),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.homeIcon),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.win),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.winOrenge),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                label: 'Leaderboard',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.messageIcon),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.messageOrenge),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                label: 'DMs',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.faverit),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.fevaritOrenge),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                label: 'Following',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.profileIcon),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.profileOrenge),
                    UIHelper.verticalSpace(4.h),
                  ],
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
