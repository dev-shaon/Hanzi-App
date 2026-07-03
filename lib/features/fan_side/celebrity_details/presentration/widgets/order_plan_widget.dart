import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class OrderPlanWidget extends StatefulWidget {
  final String title;
  final String description;
  final String revisions;
  final String deliveryDays;
  final bool isEditable;

  const OrderPlanWidget({
    super.key,
    required this.title,
    required this.description,
    required this.revisions,
    required this.deliveryDays,
    this.isEditable = false,
  });

  @override
  State<OrderPlanWidget> createState() => _OrderPlanWidgetState();
}

class _OrderPlanWidgetState extends State<OrderPlanWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextFontStyle.headline20w600c303030urbanist,
          ),
          UIHelper.verticalSpace(20.h),

          LayoutBuilder(
            builder: (context, constraints) {
              final textSpan = TextSpan(
                text: widget.description,
                style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                  color: AppColors.c303030,
                ),
              );
              final textPainter = TextPainter(
                text: textSpan,
                maxLines: 3,
                textDirection: TextDirection.ltr,
              )..layout(maxWidth: constraints.maxWidth);

              final isOverflow = textPainter.didExceedMaxLines;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.description,
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                      color: AppColors.c303030,
                    ),
                  ),
                  if (isOverflow)
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: Text(
                        _isExpanded ? 'See less' : 'See more',
                        style: TextFontStyle.headline14w500cFF5C24urbanist
                            .copyWith(
                              color: AppColors.c34A853,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                ],
              );
            },
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
                widget.revisions,
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
                widget.deliveryDays,
                style: TextFontStyle.headline16w500c202020urbanist,
              ),
            ],
          ),

          Divider(color: AppColors.c303030),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Edit", style: TextFontStyle.headline16w500c202020urbanist),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  widget.isEditable
                      ? Assets.icons.rightIcon
                      : Assets.icons.crossIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
