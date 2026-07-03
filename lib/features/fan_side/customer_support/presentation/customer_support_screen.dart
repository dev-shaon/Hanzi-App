import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:intl/intl.dart';

class _ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  _ChatMessage({required this.text, required this.isMe, required this.time});
}

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasText = false;

  final List<_ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      final hasText = _messageController.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isMe: true, time: DateTime.now()));
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Groups messages by date and returns a list of widgets
  /// with date separators inserted between groups.
  List<Widget> _buildMessageList() {
    final List<Widget> widgets = [];
    DateTime? lastDate;

    for (int i = 0; i < _messages.length; i++) {
      final msg = _messages[i];
      final msgDate = DateTime(msg.time.year, msg.time.month, msg.time.day);

      if (lastDate == null || msgDate != lastDate) {
        widgets.add(_buildDateSeparator(msg.time));
        lastDate = msgDate;
      }

      widgets.add(_buildMessageBubble(msg));
    }

    return widgets;
  }

  Widget _buildDateSeparator(DateTime date) {
    final formatted = DateFormat(
      "MMM dd 'AT' hh:mm a",
    ).format(date).toUpperCase();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: Text(
          formatted,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.c7C7C7C,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage msg) {
    final timeStr = DateFormat('hh:mm a').format(msg.time).toLowerCase();

    if (msg.isMe) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.cFF5C24,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            UIHelper.verticalSpace(4.h),
            Text(
              timeStr,
              style: TextStyle(fontSize: 11.sp, color: AppColors.c7C7C7C),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: AppColors.cFCF5E9,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.messageOrenge,
                  width: 16.w,
                  height: 16.h,
                ),
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cF0F0F0,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: AppColors.c303030,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    timeStr,
                    style: TextStyle(fontSize: 11.sp, color: AppColors.c7C7C7C),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFF8,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 0.5,
        leading: InkWell(
          onTap: () => NavigationService.goBack,
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: SvgPicture.asset(
              Assets.icons.arrowBack,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
        title: Text(
          'Customer Support',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.c303030,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              // Chat messages area
              Expanded(
                child: _messages.isEmpty
                    ? Center(
                        child: Text(
                          'No messages yet.\nSend a message to get started.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.c7C7C7C,
                            fontSize: 14.sp,
                          ),
                        ),
                      )
                    : ListView(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        physics: const BouncingScrollPhysics(),
                        children: _buildMessageList(),
                      ),
              ),

              // Input area
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.cFCF5E9,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.c303030.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        textInputAction: TextInputAction.newline,
                        maxLines: 5,
                        minLines: 1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.c303030,
                        ),
                        decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.c7C7C7C,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                      ),
                    ),
                    if (!_hasText) ...[
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            Assets.icons.fileIcon,
                            height: 24.h,
                            width: 24.w,
                            colorFilter: ColorFilter.mode(
                              AppColors.c5F400E,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(16.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            Assets.icons.cameraIcon,
                            height: 20.h,
                            width: 20.w,
                            colorFilter: ColorFilter.mode(
                              AppColors.c5F400E,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (_hasText)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: GestureDetector(
                          onTap: _sendMessage,
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: AppColors.c5F400E,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
