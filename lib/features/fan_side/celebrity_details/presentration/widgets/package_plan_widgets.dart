import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class PackagePlanWidget extends StatefulWidget {
  final String packageName;
  final String packageDetails;
  final dynamic revisions;
  final dynamic deliveryDays;
  final int editable;

  const PackagePlanWidget({
    super.key,
    required this.packageName,
    required this.packageDetails,
    required this.revisions,
    required this.deliveryDays,
    required this.editable,
  });

  @override
  State<PackagePlanWidget> createState() => _PackagePlanWidgetState();
}

class _PackagePlanWidgetState extends State<PackagePlanWidget> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    final details = widget.packageDetails;
    final isLong = details.length > 100;
    final displayText = _showMore || !isLong
        ? details
        : '${details.substring(0, 100)}... ';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.packageName,
          style: TextFontStyle.headline20w600c303030urbanist,
        ),
        UIHelper.verticalSpace(20.h),
        RichText(
          text: TextSpan(
            text: displayText,
            style: TextFontStyle.headline16w500c202020urbanist.copyWith(
              color: AppColors.c303030,
            ),
            children: isLong
                ? [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () => setState(() => _showMore = !_showMore),
                        child: Text(
                          _showMore ? ' See less' : 'See more',
                          style: TextFontStyle.headline14w500cFF5C24urbanist
                              .copyWith(
                                color: AppColors.c34A853,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        UIHelper.verticalSpace(28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Revisions",
              style: TextFontStyle.headline16w500c202020urbanist,
            ),
            Text(
              "${widget.revisions}",
              style: TextFontStyle.headline16w500c202020urbanist,
            ),
          ],
        ),
        Divider(color: AppColors.c303030),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Days",
              style: TextFontStyle.headline16w500c202020urbanist,
            ),
            Text(
              "${widget.deliveryDays}",
              style: TextFontStyle.headline16w500c202020urbanist,
            ),
          ],
        ),
        Divider(color: AppColors.c303030),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Edit", style: TextFontStyle.headline16w500c202020urbanist),
            widget.editable == 1
                ? SvgPicture.asset(Assets.icons.rightIcon)
                : SvgPicture.asset(Assets.icons.crossIcon),
          ],
        ),
      ],
    );
  }
}
