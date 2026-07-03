import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:video_player/video_player.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/helpers/share_helper.dart';

import '../../../../../networks/api_access.dart';

class VideoScreen extends StatefulWidget {
  final String? videoUrl;
  final int? id;
  const VideoScreen({super.key, this.videoUrl, this.id});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isMuted = false;
  bool _hasVideoError = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _isSaved = getSaveVideoRxObj.isVideoSaved(widget.videoUrl);
    final url = widget.videoUrl ?? '';

    if (url.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        customToastMessage("Error", "Video URL is invalid");
        NavigationService.goBack;
      });
      return;
    }

    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller!
        .initialize()
        .then((_) {
          if (!mounted) return;
          setState(() => _isInitialized = true);
          _controller?.play();
        })
        .catchError((_) {
          if (mounted) {
            setState(() => _hasVideoError = true);
            customToastMessage("Error", "This video format is not supported");
          }
        });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
    log(widget.id.toString());
  }

  void _saveVideo() async {
    final originalSaved = _isSaved;
    setState(() {
      _isSaved = !_isSaved;
    });

    // Optimistically update the list so SavedVideoScreen reacts instantly
    getSaveVideoRxObj.toggleLocalSave(widget.videoUrl, widget.id);

    try {
      bool success = await postSaveVideoRxObj.post(
        id: widget.id,
        videoUrl: widget.videoUrl,
      );
      if (!success) {
        if (mounted) {
          setState(() {
            _isSaved = originalSaved;
          });
          getSaveVideoRxObj.toggleLocalSave(widget.videoUrl, widget.id);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaved = originalSaved;
        });
        getSaveVideoRxObj.toggleLocalSave(widget.videoUrl, widget.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox.expand(
            child: _hasVideoError
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "This video can't be played on this device.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : (_isInitialized && _controller != null
                      ? Center(
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => NavigationService.goBack,
                        child: SvgPicture.asset(
                          Assets.icons.arrowBack,
                          height: 24.h,
                          width: 24.w,
                          colorFilter: ColorFilter.mode(
                            AppColors.cFFFFFF,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Holiday",
                        style: TextFontStyle.headline20w500c303030urbanist
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      UIHelper.verticalSpace(30.h),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.videoUrl != null) {
                            ShareHelper.shareVideo(
                              videoUrl: widget.videoUrl!,
                              text: "Check out this video!",
                            );
                          }
                        },
                        child: SvgPicture.asset(
                          Assets.icons.sheareIcon,
                          height: 24.h,
                          width: 24.w,
                          colorFilter: ColorFilter.mode(
                            AppColors.cFFFFFF,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (_controller == null) return;
                          setState(() {
                            _isMuted = !_isMuted;
                            _controller!.value.volume == 0
                                ? _controller!.setVolume(1)
                                : _controller!.setVolume(0);
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.c000000.withValues(
                            alpha: 0.5,
                          ),
                          child: SvgPicture.asset(
                            _isMuted ? Assets.icons.mute : Assets.icons.unmute,
                            height: 24.h,
                            width: 24.w,
                            colorFilter: ColorFilter.mode(
                              AppColors.cFFFFFF,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),
                      GestureDetector(
                        onTap: () => _saveVideo(),
                        child: CircleAvatar(
                          backgroundColor: AppColors.c000000.withValues(
                            alpha: 0.5,
                          ),
                          child: Icon(
                            _isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: AppColors.cFFFFFF,
                            size: 24.r,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),
                      GestureDetector(
                        onTap: () {
                          if (widget.videoUrl != null) {
                            ShareHelper.shareVideo(
                              videoUrl: widget.videoUrl!,
                              text: "Check out this video!",
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.c000000.withValues(
                            alpha: 0.5,
                          ),
                          child: SvgPicture.asset(
                            Assets.icons.whiteShare,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(30.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
