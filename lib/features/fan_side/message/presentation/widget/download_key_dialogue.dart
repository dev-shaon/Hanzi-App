import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio_pkg;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import '../../../../../helpers/ui_helpers.dart';
import '../../../../../networks/api_access.dart';

class DownloadKeyDialog extends StatefulWidget {
  final int messageId;
  final String videoUrl;
  final VoidCallback? onSuccess;

  const DownloadKeyDialog({
    super.key,
    required this.messageId,
    required this.videoUrl,
    this.onSuccess,
  });

  @override
  State<DownloadKeyDialog> createState() => _DownloadKeyDialogState();
}

class _DownloadKeyDialogState extends State<DownloadKeyDialog> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isVerifying = false;
  String? _error;

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onDigitChanged(String value) {
    if (_error != null) setState(() => _error = null);
  }

  Future<void> _onDownload() async {
    final entered = _pinController.text.trim();

    if (entered.length < 6) {
      setState(() => _error = 'Please enter all 6 digits.');
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final success = await postAcceptOrderRx.post(
        downloadKey: entered,
        messageId: widget.messageId,
      );

      if (!success) {
        if (mounted) {
          setState(() {
            _isVerifying = false;
            _error = 'Incorrect key. Please try again.';
          });
          _pinController.clear();
          _focusNode.requestFocus();
        }
        return;
      }

      // ✅ Key সঠিক — আগে dialog বন্ধ করো এবং onSuccess call করো
      if (mounted) {
        Navigator.of(context).pop();
        widget.onSuccess?.call();
      }

      // ✅ Background এ download চলবে — dialog বন্ধ হওয়ার পরেও
      _startBackgroundDownload(widget.videoUrl);
    } catch (e) {
      log('❌ [DOWNLOAD] Error: $e');
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _error = 'Something went wrong. Please try again.';
        });
      }
    }
  }

  // ✅ Background download — UI block করে না
  void _startBackgroundDownload(String url) async {
    if (url.isEmpty) return;

    try {
      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

      await dio_pkg.Dio().download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            log('📥 Download: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      await Gal.putVideo(filePath);

      try {
        await File(filePath).delete();
      } catch (_) {}

      customToastMessage("Success", "Video downloaded to gallery!");
    } catch (e) {
      log('❌ [BG DOWNLOAD] Error: $e');
      customToastMessage("Error", "Download failed. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icons.logoPng.image(height: 40.h),
            UIHelper.verticalSpace(12.h),
            FittedBox(
              child: Text(
                'Please enter the download key',
                style: TextFontStyle.headline20w600c202020urbanist.copyWith(
                  color: AppColors.c303030,
                ),
              ),
            ),
            UIHelper.verticalSpace(6.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextFontStyle.headline16w400c303030urbanist.copyWith(
                  color: AppColors.c7C7C7C,
                ),
                children: [
                  const TextSpan(
                    text:
                        'Once you will download the video,\nproject status will be ',
                  ),
                  TextSpan(
                    text: 'delivered.',
                    style: TextFontStyle.headline16w400c303030urbanist.copyWith(
                      color: AppColors.c34A853,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),

            Pinput(
              controller: _pinController,
              focusNode: _focusNode,
              length: 6,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: _onDigitChanged,
              defaultPinTheme: PinTheme(
                width: 36.w,
                height: 36.h,
                textStyle: TextFontStyle.headline16w400c303030urbanist.copyWith(
                  color: AppColors.c303030,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.cC7C7C7),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 36.w,
                height: 36.h,
                textStyle: TextFontStyle.headline16w400c303030urbanist.copyWith(
                  color: AppColors.c303030,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.c34A853, width: 1),
                ),
              ),
            ),

            if (_error != null) ...[
              SizedBox(height: 10.h),
              Text(
                _error!,
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
                textAlign: TextAlign.center,
              ),
            ],

            UIHelper.verticalSpace(20.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: const LinearGradient(
                    colors: [AppColors.cBF0707, AppColors.cFF5C24],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton.icon(
                  onPressed: _isVerifying ? null : _onDownload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  icon: _isVerifying
                      ? SizedBox(
                          width: 18.w,
                          height: 18.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                          size: 20.r,
                        ),
                  label: Text(
                    _isVerifying ? 'Verifying...' : 'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
