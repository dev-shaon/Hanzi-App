import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PlayCart extends StatefulWidget {
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? title;
  final VoidCallback onTap;

  const PlayCart({
    super.key,
    this.thumbnailUrl,
    this.videoUrl,
    this.title,
    required this.onTap,
  });

  @override
  State<PlayCart> createState() => _PlayCartState();
}

class _PlayCartState extends State<PlayCart> {
  Uint8List? _thumbnail;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    final url = widget.videoUrl;
    if (url == null || url.isEmpty || url.contains('tc_mcandy.test')) return;

    final thumb = await VideoThumbnail.thumbnailData(
      video: url,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );
    if (mounted) setState(() => _thumbnail = thumb);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: _thumbnail != null
                  ? Image.memory(
                      _thumbnail!,
                      height: 158.h,
                      width: 120.w,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 158.h,
                      width: 120.w,
                      color: Colors.black12,
                      child: const Icon(
                        Icons.video_library,
                        color: Colors.grey,
                      ),
                    ),
            ),
            SvgPicture.asset(Assets.icons.stopIcon, height: 24.h, width: 24.w),
            Positioned(
              bottom: 8.h,
              left: -20,
              right: 0,
              child: Text(
                widget.title ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
