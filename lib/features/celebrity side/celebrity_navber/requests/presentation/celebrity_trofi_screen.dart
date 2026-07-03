import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/presentation/widget/Month_Leader_board.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/presentation/widget/Time_Leader_board.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class CelebrityTrofiScreen extends StatefulWidget {
  const CelebrityTrofiScreen({super.key});

  @override
  State<CelebrityTrofiScreen> createState() => _CelebrityTrofiScreenState();
}

class _CelebrityTrofiScreenState extends State<CelebrityTrofiScreen> {
  String selectedTab = "This Month";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cFFFFF8,
        title: CustomAppBar(title: "Leaderboard", showFilter: false),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 50.h,
                width: 330.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF8F1),
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
                                ? AppColors.cFF5C24
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
                                ? Color(0xFFFF5722)
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
                children: [MonthLeaderBoard(), TimeLeaderBoard()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
