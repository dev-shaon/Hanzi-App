import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/custom_notification.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Text(
            "Today",
            style: TextFontStyle.headline16w500c7C7C7Curbanist,
          ),
        ),
        Container(
          decoration: BoxDecoration(color: AppColors.cFCF5E9),
          child: Column(
            children: [
              CustomNotification(
                userName: 'Robert Doe',
                actionText: 'shared the meeting',
                title: 'Boctamp Online Course',
                timeText: '3 hours ago',
              ),
              Divider(color: AppColors.cADADAD),
              CustomNotification(
                userName: 'Robert Doe',
                actionText: 'shared the meeting',
                title: 'Boctamp Online Course',
                timeText: '3 hours ago',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Text(
            "Yesterday",
            style: TextFontStyle.headline16w500c7C7C7Curbanist,
          ),
        ),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics:  NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                CustomNotification(
                  userName: 'Robert Doe',
                  actionText: 'has sent email update for',
                  title: 'Secure your account',
                  timeText: index == 1 ? '2 hours ago' : '5 hours ago',
                ),
                Divider(color: AppColors.cADADAD, height: 2.h),
              ],
            );
          },
        ),
      ],
    );
  }
}
