import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class FqaList extends StatefulWidget {
  const FqaList({super.key});

  @override
  State<FqaList> createState() => _FqaListState();
}

class _FqaListState extends State<FqaList> {
  int _expandedIndex = -1;

  final List<String> questions = [
    "What is Hanzi?",
    "How to apply for a campaign?",
    "How to know status of a campaign?",
    "How to know status of a campaign?",
    "How to apply for a campaign?",
    "How to know status of a campaign?",
  ];

  final String answer =
      "At Viral Pitch we expect at a day’s start is you, better and happier than yesterday. "
      "We have got you covered share your concern or check our frequently asked questions listed below. "
      "At Viral Pitch we expect at a day’s start is you, better and happier than yesterday. "
      "We have got you covered share your concern.";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(questions.length, (index) {
        final bool isExpanded = _expandedIndex == index;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _expandedIndex = isExpanded ? -1 : index;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      questions[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SvgPicture.asset(
                    isExpanded
                        ? Assets.icons.minus
                        : Assets.icons.addIcon,
                  ),
                ],
              ),
            ),

            if (isExpanded) ...[
              UIHelper.verticalSpace(12.h),
              Text(
                answer,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],

            UIHelper.verticalSpace(16.h),
            Divider(color: AppColors.c7C7C7C),
            UIHelper.verticalSpace(16.h),
          ],
        );
      }),
    );
  }
}
