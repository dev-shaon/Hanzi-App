import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/presentation/widget/Month_Leader_board.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/presentation/widget/Time_Leader_board.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedTab = "This Month";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cFFFFF8,
        title: Text(
          "Leaderboard",
          style: TextFontStyle.headline24w600c303030urbanist,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 50.h,
                width: 330.w,
                decoration: BoxDecoration(
                  color:  Color(0xFFFFF8F1),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "This Month";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedTab == "This Month"
                                ?  AppColors.cFF5C24
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "This Month",
                            style: TextStyle(
                              color: selectedTab == "This Month"
                                  ? AppColors.cFFFFFF
                                  : AppColors.c515978,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
          
          
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "All Time";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedTab == "All Time"
                                ?  Color(0xFFFF5722)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "All Time",
                            style: TextStyle(
                              color: selectedTab == "All Time"
                                  ? AppColors.cFFFFFF
                                  : AppColors.c515978,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              UIHelper.verticalSpaceMedium,
          
              IndexedStack(
                index: selectedTab == "This Month" ? 0 : 1,
                children:  [
                  MonthLeaderBoard(),
                  TimeLeaderBoard(),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}


