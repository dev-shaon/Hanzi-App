import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class WalletDonutChart extends StatelessWidget {
  final double totalEarnings;
  final double orderEarnings;
  final double subscriptionEarnings;

  const WalletDonutChart({
    super.key,
    this.totalEarnings = 0,
    this.orderEarnings = 0,
    this.subscriptionEarnings = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double orderRatio = totalEarnings > 0
        ? (orderEarnings / totalEarnings).clamp(0.0, 1.0)
        : 0.75;

    return SizedBox(
      width: 220.w,
      height: 220.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(220.w, 220.w),
            painter: DonutChartPainter(orderRatio: orderRatio),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$${totalEarnings.toStringAsFixed(2)}',
                style: TextFontStyle.headline24w600c303030urbanist,
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'USD',
                style: TextFontStyle.headline20w600c303030urbanist.copyWith(
                  color: AppColors.c7C7C7C,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double orderRatio;

  DonutChartPainter({this.orderRatio = 0.75});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 35.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Order earnings arc (orange)
    paint.color = const Color(0xFFFF5A1F);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2,
      2 * pi * orderRatio,
      false,
      paint,
    );

    // Subscription earnings arc (purple)
    paint.color = const Color(0xFF8B7CFF);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2 + 2 * pi * orderRatio,
      2 * pi * (1 - orderRatio),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) =>
      oldDelegate.orderRatio != orderRatio;
}
