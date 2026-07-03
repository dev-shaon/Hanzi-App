import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/message/model/inbox_response_model.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_utils.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/image_bubble.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/key_badge.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/video_thumbnail.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final String? avatarUrl;
  final String timeLabel;
  final bool isCelebrity;
  final int currentUserId;
  final VoidCallback onDownloadTap;
  final Future<void> Function(int)? onReviewTap;
  final bool isDownloaded;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.avatarUrl,
    required this.timeLabel,
    required this.isCelebrity,
    required this.currentUserId,
    required this.onDownloadTap,
    this.onReviewTap,
    this.isDownloaded = false,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isReviewPrompt && message.isSubmitted) {
      if ((message.effectiveRating ?? 0) <= 0) {
        return const SizedBox.shrink();
      }
      return _buildStatusBubble();
    }

    if (message.isStatus) {
      return _buildStatusBubble();
    }
    if (message.isReviewPrompt && !isCelebrity && !message.isSubmitted) {
      return _buildReviewPrompt(context);
    }
    if (message.isReviewPrompt && isCelebrity && !message.isSubmitted) {
      return const SizedBox.shrink();
    }

    final hasMedia = message.file != null && message.file!.isNotEmpty;
    final isVideo =
        hasMedia && (message.fileType == 'video' || isVideoUrl(message.file));
    final hasText = message.message?.isNotEmpty == true;

    final isOrderDelivered = message.isOrderDelivered;

    final showKeyBadge =
        isCelebrity &&
        isMe &&
        isVideo &&
        (message.downloadKey?.isNotEmpty ?? false) &&
        !isOrderDelivered;

    final showDownloadIcon =
        !isCelebrity &&
        !isMe &&
        isVideo &&
        message.hasDownloadKey &&
        !isOrderDelivered &&
        !isDownloaded;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AppColors.cF0F0F0,
              backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty)
                  ? CachedNetworkImageProvider(avatarUrl!)
                  : null,
              child: (avatarUrl == null || avatarUrl!.isEmpty)
                  ? Icon(Icons.person, size: 18.r, color: AppColors.c7C7C7C)
                  : null,
            ),
            SizedBox(width: 6.w),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.68,
            ),
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.cFF5C24 : AppColors.cF0F0F0,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (hasMedia)
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                            bottomLeft: Radius.circular(hasText ? 0 : 16.r),
                            bottomRight: Radius.circular(hasText ? 0 : 16.r),
                          ),
                          child: isVideo
                              ? VideoThumbnail(
                                  url: message.file!,
                                  showDownloadIcon: showDownloadIcon,
                                  onDownloadTap: onDownloadTap,
                                )
                              : ImageBubble(url: message.file!),
                        ),
                      if (hasText)
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: hasMedia ? 4.h : 8.h,
                            bottom: 6.h,
                          ),
                          child: IntrinsicWidth(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  message.message!,
                                  style: TextStyle(
                                    color: isMe
                                        ? AppColors.cFFFFFF
                                        : AppColors.c000000,
                                    fontSize: 14.sp,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    timeLabel,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: isMe
                                          ? Colors.white.withValues(alpha: 0.75)
                                          : AppColors.c7C7C7C,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (showKeyBadge) ...[
                  UIHelper.verticalSpace(6.h),
                  KeyBadge(keyCode: message.downloadKey!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBubble() {
    final bool isRating = message.isReviewPrompt && message.isSubmitted;

    final int ratingValue = message.effectiveRating?.toInt() ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Center(
        child: Container(
          width: 0.8.sw,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            border: Border.all(color: AppColors.cC7C7C7.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              if (isRating) ...[
                Text(
                  isCelebrity
                      ? "Fan gives you a rating."
                      : "Thanks for your valuable ratings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.c7C7C7C,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => _buildStar(index, ratingValue),
                  ),
                ),
              ] else
                FittedBox(
                  child: Text(
                    message.message ??
                        "Delivery status is updated as delivered",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                      color: AppColors.c34A853,
                    ),
                  ),
                ),
              UIHelper.verticalSpace(4.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  timeLabel,
                  style: TextStyle(fontSize: 10.sp, color: AppColors.c7C7C7C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewPrompt(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Center(
        child: Container(
          width: 0.8.sw,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            border: Border.all(color: AppColors.cC7C7C7.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Text(
                "You can rate your overall experience.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.c303030, fontSize: 14.sp),
              ),
              UIHelper.verticalSpace(12.h),
              _StarRatingWidget(
                // ✅ effectiveRating use করো
                initialRating: message.effectiveRating ?? 0,
                onRatingSelected: (rating) async {
                  await onReviewTap?.call(rating);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStar(int index, int currentRating) {
    final bool isSelected = index < currentRating;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        height: 28.h,
        width: 28.w,
        decoration: const BoxDecoration(
          color: AppColors.cF0F0F0,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.icons.starIcon,
            height: 14.h,
            width: 14.w,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.cFF5C24 : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _StarRatingWidget extends StatefulWidget {
  final num initialRating;
  final Future<void> Function(int) onRatingSelected;

  const _StarRatingWidget({
    required this.initialRating,
    required this.onRatingSelected,
  });

  @override
  State<_StarRatingWidget> createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<_StarRatingWidget> {
  late int _currentRating;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            return GestureDetector(
              onTap: () {
                if (widget.initialRating > 0) return;
                setState(() => _currentRating = starIndex);
              },
              child: Container(
                height: 28.h,
                width: 28.w,
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: const BoxDecoration(
                  color: Color(0xffDDDDDD),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.icons.starIcon,
                    height: 14.h,
                    width: 14.w,
                    colorFilter: ColorFilter.mode(
                      starIndex <= _currentRating
                          ? AppColors.c303030
                          : AppColors.cFFFFFF,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (_currentRating > 0 && widget.initialRating == 0) ...[
          UIHelper.verticalSpace(12.h),
          SizedBox(
            // width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting
                  ? null
                  : () async {
                      setState(() => _isSubmitting = true);
                      try {
                        await widget.onRatingSelected(_currentRating);
                      } finally {
                        if (mounted) {
                          setState(() => _isSubmitting = false);
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cFFFFF8,
                foregroundColor: AppColors.cFF5C24,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99.r),
                  side: BorderSide(color: AppColors.cFFB49A),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                elevation: 0,
              ),
              child: _isSubmitting
                  ? SizedBox(
                      height: 18.h,
                      width: 18.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Submit",
                      style: TextFontStyle.headline16w600cFFFFFFurbanist
                          .copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.cFF5C24,
                          ),
                    ),
            ),
          ),
        ],
      ],
    );
  }
}
