import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyBadge extends StatelessWidget {
  final String keyCode;
  const KeyBadge({super.key, required this.keyCode});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: '#$keyCode'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF2E6),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$keyCode',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => _copy(context),
            child: Icon(
              Icons.copy_rounded,
              size: 16.r,
              color: Colors.orange.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
