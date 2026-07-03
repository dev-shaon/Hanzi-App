import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/full_screen_image.dart';

class ImageBubble extends StatelessWidget {
  final String url;
  const ImageBubble({super.key, required this.url});

  bool get _isLocal => !url.startsWith('http');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenImage(url: url, isLocal: _isLocal),
        ),
      ),
      child: SizedBox(
        width: 220.w,
        height: 180.h,
        child: _isLocal
            ? Image.file(File(url), fit: BoxFit.cover)
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, _, _) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}
