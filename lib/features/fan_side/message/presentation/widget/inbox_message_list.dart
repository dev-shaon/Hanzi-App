import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tc_mcandy/features/fan_side/message/model/inbox_response_model.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_bubble.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_utils.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/providers/chat_provider.dart';

class InboxMessageList extends StatelessWidget {
  final ScrollController scrollController;
  final int currentUserId;
  final String otherUserAvatar;
  final bool isCelebrity;
  final Set<int> downloadedMessageIds;
  final Function(Message) onDownload;
  final Function(Message, int) onReview;

  const InboxMessageList({
    super.key,
    required this.scrollController,
    required this.currentUserId,
    required this.otherUserAvatar,
    required this.isCelebrity,
    required this.downloadedMessageIds,
    required this.onDownload,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        final messages = chatProvider.cList;

        if (messages.isEmpty) {
          return Center(
            child: Text(
              'No messages yet',
              style: TextStyle(
                color: AppColors.c7C7C7C,
                fontSize: 14.sp,
              ),
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          reverse: true,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            final isMe = msg.sender?.id == currentUserId;
            final olderMsg = index + 1 < messages.length
                ? messages[index + 1]
                : null;
            final showSeparator = isDifferentDay(
              msg.createdAt,
              olderMsg?.createdAt,
            );

            return Column(
              children: [
                if (showSeparator && msg.createdAt != null)
                  _DateSeparator(
                    label: formatDateSeparator(msg.createdAt!),
                  ),
                ChatBubble(
                  message: msg,
                  isMe: isMe,
                  avatarUrl: isMe ? null : otherUserAvatar,
                  timeLabel: formatBubbleTime(msg.createdAt),
                  isCelebrity: isCelebrity,
                  currentUserId: currentUserId,
                  onDownloadTap: () => onDownload(msg),
                  onReviewTap: (rating) => onReview(msg, rating),
                  isDownloaded: downloadedMessageIds.contains(msg.id),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _DateSeparator extends StatelessWidget {
  final String label;
  const _DateSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.c7C7C7C,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
