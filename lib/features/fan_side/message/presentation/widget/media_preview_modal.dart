import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_utils.dart';
import 'package:video_player/video_player.dart';

class MediaPreviewModal extends StatefulWidget {
  final File file;
  final bool isCelebrity;

  final void Function(bool generateKey, String? keyCode) onSend;

  const MediaPreviewModal({
    super.key,
    required this.file,
    required this.isCelebrity,
    required this.onSend,
  });

  @override
  State<MediaPreviewModal> createState() => MediaPreviewModalState();
}

class MediaPreviewModalState extends State<MediaPreviewModal> {
  bool _generateKey = false;
  String? _generatedCode;

  late bool _isVideo;
  VideoPlayerController? _videoCtrl;

  @override
  void initState() {
    super.initState();
    final path = widget.file.path.toLowerCase();
    _isVideo =
        path.endsWith('.mp4') || path.endsWith('.mov') || path.endsWith('.mkv');
    if (_isVideo) {
      _videoCtrl = VideoPlayerController.file(widget.file)
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _videoCtrl?.dispose();
    super.dispose();
  }

  void _onCheckboxChanged(bool? value) {
    final enabled = value ?? false;
    setState(() {
      _generateKey = enabled;
      _generatedCode = enabled ? generateDownloadKey() : null;
    });
  }

  void _copyCode(BuildContext context) {
    if (_generatedCode == null) return;
    Clipboard.setData(ClipboardData(text: '#$_generatedCode'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              height: 300.h,
              width: double.infinity,
              child: ColoredBox(
                color: Colors.black,
                child: _isVideo
                    ? (_videoCtrl?.value.isInitialized == true
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: _videoCtrl!.value.aspectRatio,
                                  child: VideoPlayer(_videoCtrl!),
                                ),
                                const Icon(
                                  Icons.play_circle_outline,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()))
                    : Image.file(widget.file, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          if (widget.isCelebrity)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF2E6),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Without Generating A Download Key. He Can't Download The "
                    "${_isVideo ? 'Video' : 'Image'}.",
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                  ),
                  SizedBox(height: 8.h),

                  // Checkbox row
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _generateKey,
                          activeColor: Colors.green,
                          onChanged: _onCheckboxChanged,
                        ),
                        Text(
                          'Generate Key.',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),

                  // Generated code display
                  if (_generateKey && _generatedCode != null) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '#$_generatedCode',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _copyCode(context),
                            child: Icon(
                              Icons.copy_rounded,
                              size: 20.r,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

          SizedBox(height: 20.h),

          ElevatedButton(
            onPressed: () => widget.onSend(_generateKey, _generatedCode),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
              backgroundColor: Colors.orange.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            child: Text(
              'Send',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
