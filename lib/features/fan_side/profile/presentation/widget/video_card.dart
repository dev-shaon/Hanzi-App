import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final VoidCallback? onTap;
  final String? videoUrl;

  const VideoCard({super.key, this.onTap, this.videoUrl});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    final url = widget.videoUrl;
    if (url == null || url.isEmpty || url.contains('tc_mcandy.test')) return;

    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller!.initialize();
    await _controller!.seekTo(Duration.zero);
    if (mounted) setState(() => _isInitialized = true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            _isInitialized && _controller != null
                ? SizedBox(
                    width: 160.w,
                    height: 210.h,
                    child: VideoPlayer(_controller!),
                  )
                : Container(
                    width: 160.w,
                    height: 210.h,
                    color: Colors.black26,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.icons.stopIcon,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
            Positioned.fill(
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.stopIcon,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
