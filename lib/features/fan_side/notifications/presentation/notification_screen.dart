import 'package:flutter/material.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/activity_screen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(showFilter: false, title: "Notification"),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: AppColors.cFCF5E9,
              child: TabBar(
                indicatorColor: AppColors.cFF5C24,
                labelColor: AppColors.cFF5C24,
                unselectedLabelColor: AppColors.c7C7C7C,

                tabs: [
                  Tab(text: 'Recent activity'),
                  Tab(text: 'Unread'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ActivityScreen(),
            Center(child: Text('Unread')),
          ],
        ),
      ),
    );
  }
}
