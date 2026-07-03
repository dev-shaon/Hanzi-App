import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/message/model/chat_list_model.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/active_list.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_list.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/di.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

import '../../../../constants/app_constants.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with RouteAware {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _timeRefreshTimer;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    getChatListRxObj.fetchChatList();

    _searchController.addListener(() {
      setState(
        () => _searchQuery = _searchController.text.trim().toLowerCase(),
      );
    });

    _timeRefreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) getChatListRxObj.fetchChatList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route as PageRoute);
    }
  }

  @override
  void didPopNext() {
    getChatListRxObj.fetchChatList();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _searchController.dispose();
    _timeRefreshTimer?.cancel();
    _pollTimer?.cancel();
    super.dispose();
  }

  String _timeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 30) return 'Now';
    if (diff.inMinutes < 1) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Widget _buildEmptyState() {
    final isCelebrity = appData.read(kkeyUserRole) == 'celebrity';
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cC7C7C799),
        color: AppColors.cFFFFFF,
      ),
      child: Column(
        children: [
          Text(
            isCelebrity
                ? "No message is showing"
                : "Chat with your favorite celebrities",
            style: TextFontStyle.headline18w600c303030urbanist,
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            isCelebrity
                ? "When any fan DM you or start a order. His inbox will be shown here."
                : "Just click on any profile to chat or find more people",
            style: TextFontStyle.headline16w500c7C7C7Curbanist,
            textAlign: TextAlign.center,
          ),
          if (!isCelebrity) ...[
            UIHelper.verticalSpace(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Start chatting",
                  style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                    color: AppColors.cFF5C24,
                  ),
                  textAlign: TextAlign.center,
                ),
                UIHelper.horizontalSpace(4.w),
                SvgPicture.asset(Assets.icons.orengeNext),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
        title: Text(
          "Messages",
          style: TextFontStyle.headline24w600c303030urbanist,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: StreamBuilder(
          stream: getChatListRxObj.fillData,
          builder: (context, snapshot) {
            List<Room> rooms = [];
            if (snapshot.hasData && snapshot.data is ChatListModel) {
              final model = snapshot.data as ChatListModel;
              rooms = model.data?.rooms ?? [];
            }

            final onlineRooms = rooms
                .where((r) => r.user?.isOnline == true)
                .toList();

            final filtered = _searchQuery.isEmpty
                ? rooms
                : rooms
                      .where(
                        (r) => (r.user?.name ?? '').toLowerCase().contains(
                          _searchQuery,
                        ),
                      )
                      .toList();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    UIHelper.verticalSpace(16.h),
                    if (rooms.isNotEmpty) ...[
                      CustomFormField(
                        controller: _searchController,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        prefixIcon: SvgPicture.asset(Assets.icons.search),
                        hintText: "Search here...",
                      ),
                      UIHelper.verticalSpace(16.h),
                    ],
                    if (onlineRooms.isNotEmpty)
                      SizedBox(
                        height: 88.h,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: onlineRooms.length,
                          itemBuilder: (context, index) {
                            final room = onlineRooms[index];
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: GestureDetector(
                                onTap: () {
                                  NavigationService.navigateToWithArgs(
                                    Routes.inboxScreen,
                                    {
                                      'id': room.user?.id,
                                      'roomId': room.roomId,
                                      'name': room.user?.name ?? '',
                                      'image': room.user?.avatar ?? '',
                                      'isCelebrity':
                                          appData.read(kkeyUserRole) ==
                                          'celebrity',
                                    },
                                  );
                                },
                                child: ActiveList(
                                  text: room.user?.name ?? '',
                                  imageUrl:
                                      room.user?.avatar ?? kDefaultProfileImage,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (onlineRooms.isNotEmpty) UIHelper.verticalSpace(10.h),
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        rooms.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else if (filtered.isEmpty)
                      _buildEmptyState()
                    else
                      ListView.builder(
                        itemCount: filtered.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final room = filtered[index];
                          final unread = room.unreadCount ?? 0;
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              NavigationService.navigateToWithArgs(
                                Routes.inboxScreen,
                                {
                                  'id': room.user?.id,
                                  'roomId': room.roomId,
                                  'name': room.user?.name ?? '',
                                  'image': room.user?.avatar ?? '',
                                  'isCelebrity':
                                      appData.read(kkeyUserRole) == 'celebrity',
                                },
                              );
                            },
                            child: Column(
                              children: [
                                ChatList(
                                  title: room.user?.name ?? '',
                                  subtitle: room.lastMessage?.message ?? '',
                                  mini: _timeAgo(room.lastMessage?.createdAt),
                                  imageUrl:
                                      room.user?.avatar ?? kDefaultProfileImage,
                                  load: unread > 0 ? '$unread' : null,
                                ),
                                Divider(color: AppColors.cADADAD, height: 2.h),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
