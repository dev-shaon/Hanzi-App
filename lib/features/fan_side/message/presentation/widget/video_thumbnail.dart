import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/full_screen_video.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnail extends StatefulWidget {
  final String url;
  final bool showDownloadIcon;
  final VoidCallback onDownloadTap;

  const VideoThumbnail({
    super.key,
    required this.url,
    required this.showDownloadIcon,
    required this.onDownloadTap,
  });

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  VideoPlayerController? _ctrl;
  bool _initialized = false;

  bool get _isLocal => !widget.url.startsWith('http');

  @override
  void initState() {
    super.initState();
    _ctrl = _isLocal
        ? VideoPlayerController.file(File(widget.url))
        : VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _ctrl!.initialize().then((_) {
      if (mounted) setState(() => _initialized = true);
    });
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenVideo(url: widget.url, isLocal: _isLocal),
        ),
      ),
      child: SizedBox(
        width: 220.w,
        height: 180.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video frame / dark placeholder
            _initialized
                ? VideoPlayer(_ctrl!)
                : Container(color: Colors.black87),

            // Dim overlay
            Container(color: Colors.black.withValues(alpha: 0.25)),

            // Play icon (centre)
            const Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 48,
              ),
            ),

            // Download icon — top-right, fan side only, keyed videos only
            if (widget.showDownloadIcon)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: widget.onDownloadTap,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                      size: 20.r,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
