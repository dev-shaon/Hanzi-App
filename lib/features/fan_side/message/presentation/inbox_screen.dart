import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio_pkg;
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/features/fan_side/message/model/inbox_response_model.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_ber.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/chat_utils.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/download_key_dialogue.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/media_preview_modal.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/inbox_input_bar.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/widget/inbox_message_list.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/networks/api_access.dart';
import 'package:tc_mcandy/providers/chat_provider.dart';
import '../../../../helpers/di.dart';

class InboxScreen extends StatefulWidget {
  final String name;
  final String image;
  final int id;
  final int? roomId;
  final bool isCelebrity;

  const InboxScreen({
    super.key,
    required this.name,
    required this.image,
    required this.id,
    this.roomId,
    this.isCelebrity = false,
  });

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  PusherChannelsClient? client;
  PrivateChannel? _privateChannel;
  StreamSubscription? connectionSubs;
  StreamSubscription<ChannelReadEvent>? somePrivateChannelEventSubs;

  late final String userToken;
  late final int currentUserId;
  int? _loadedForUserId;
  bool _hasText = false;

  final Set<int> _downloadedMessageIds = {};
  String _otherUserName = '';
  String _otherUserAvatar = '';
  bool _otherUserOnline = false;

  @override
  void initState() {
    super.initState();
    userToken = appData.read(kKeyAccessToken);
    currentUserId =
        int.tryParse(appData.read(kKeyUserId)?.toString() ?? '') ?? 0;
    _otherUserName = widget.name;
    _otherUserAvatar = widget.image;

    getInboxMessageRx.clean();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ChatProvider>().clearMessages();
    });

    _messageController.addListener(() {
      final hasText = _messageController.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });

    _connect();
    getInboxMessageRx.getInboxMessage(userId: widget.id);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    connectionSubs?.cancel();
    somePrivateChannelEventSubs?.cancel();
    client?.disconnect();
    super.dispose();
  }

  void _connect() {
    if (widget.roomId == null) return;
    final channelName = 'private-fan-celebrity-chat-room.${widget.roomId}';

    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      host: 'climbiq-goonclimbers.com',
      key: 'd3d9ba606e9065ff0c3d1d566ccf904c',
      port: 8081,
    );

    client = PusherChannelsClient.websocket(
      options: hostOptions,
      connectionErrorHandler: (exception, trace, refresh) async {
        await Future.delayed(const Duration(seconds: 3));
        refresh();
      },
    );

    _privateChannel = client!.privateChannel(
      channelName,
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
            authorizationEndpoint: Uri.parse(
              'https://admin.hanziceleb.com/api/broadcasting/auth',
            ),
            headers: {'Authorization': 'Bearer $userToken'},
          ),
    );

    connectionSubs = client!.onConnectionEstablished.listen((_) {
      _privateChannel!.subscribeIfNotUnsubscribed();
      _bindMessageEvent();
    });
    client!.connect();
  }

  void _bindMessageEvent() {
    somePrivateChannelEventSubs?.cancel();
    somePrivateChannelEventSubs = _privateChannel!
        .bind('App\\Events\\FanCelebrityChatEvent')
        .listen((event) {
          try {
            final raw = json.decode(event.data);
            final Map payload;
            if (raw is Map && raw.containsKey('chat')) {
              payload = raw['chat'] as Map;
            } else if (raw is Map &&
                raw.containsKey('data') &&
                raw['data'] is Map) {
              payload = raw['data'] as Map;
            } else if (raw is Map) {
              payload = raw;
            } else {
              return;
            }

            final senderId =
                (payload["sender_id"] as num?)?.toInt() ??
                (payload["sender"]?["id"] as num?)?.toInt();
            final messageText =
                payload["message"]?.toString() ??
                payload["text"]?.toString() ??
                "";
            final fileUrl =
                payload["file"]?.toString() ?? payload["file_url"]?.toString();
            final fileType = payload["file_type"]?.toString();
            final messageType = payload["message_type"]?.toString();

            String? downloadKey;
            final metaRaw = payload["metadata"];
            if (metaRaw is Map) {
              downloadKey = metaRaw["download_key"]?.toString();
            }

            final isOwnMessage = senderId != null && senderId == currentUserId;
            final isMediaMessage = fileUrl != null && fileUrl.isNotEmpty;
            if (isOwnMessage && !isMediaMessage) return;

            final newMessage = Message(
              message: messageText,
              file: fileUrl,
              fileType: fileType,
              messageType: messageType,
              downloadKey: downloadKey,
              sender: OtherUser(
                id: senderId,
                name: payload["sender"]?["name"]?.toString(),
              ),
              createdAt: payload["created_at"] != null
                  ? DateTime.tryParse(payload["created_at"].toString())
                  : DateTime.now(),
            );

            if (mounted) {
              if (isOwnMessage && isMediaMessage) {
                context.read<ChatProvider>().replaceOptimisticMedia(newMessage);
              } else {
                context.read<ChatProvider>().addMessage(newMessage);
              }
            }
          } catch (e) {
            log('WebSocket parse error: $e');
          }
        });
  }

  void _sendMessage({File? file, bool? generateKey, String? keyCode}) async {
    final message = _messageController.text;
    if (message.trim().isEmpty && file == null) return;

    final newMessage = Message(
      message: message,
      sender: OtherUser(id: currentUserId),
      fileType: file != null
          ? (isVideoUrl(file.path) ? 'video' : 'image')
          : null,
      file: file?.path,
      messageType: generateKey == true ? 'order_delivery' : null,
      downloadKey: keyCode,
      createdAt: DateTime.now(),
    );

    context.read<ChatProvider>().addMessage(newMessage);
    _messageController.clear();

    final success = await sendMessageRxObj.sendMessage(
      userId: widget.id,
      message: message,
      file: file,
      generateKey: generateKey,
      keyCode: keyCode,
    );

    if (mounted && !success) {
      context.read<ChatProvider>().removeMessage(newMessage);
      _messageController.text = message;
    }
    getChatListRxObj.fetchChatList();
  }

  Future<void> _pickMedia() async {
    final XFile? media = await ImagePicker().pickMedia();
    if (media == null || !mounted) return;

    if (widget.isCelebrity) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => MediaPreviewModal(
          file: File(media.path),
          isCelebrity: true,
          onSend: (generateKey, keyCode) {
            Navigator.pop(context);
            _sendMessage(
              file: File(media.path),
              generateKey: generateKey,
              keyCode: keyCode,
            );
          },
        ),
      );
    } else {
      _sendMessage(file: File(media.path));
    }
  }

  void _handleDownloadTap(Message msg) {
    if (msg.isOrderDelivered || _downloadedMessageIds.contains(msg.id)) {
      _downloadVideoDirectly(msg.file ?? msg.metadata?.videoUrl ?? '');
    } else {
      _showKeyDialog(msg);
    }
  }

  Future<void> _downloadVideoDirectly(String url) async {
    customToastMessage("Downloading", "Please wait...");
    try {
      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
      await dio_pkg.Dio().download(url, filePath);
      await Gal.putVideo(filePath);
      if (mounted) {
        customToastMessage("Success", "Video downloaded to gallery!");
      }
    } catch (e) {
      if (mounted) customToastMessage("Error", "Failed to download video");
    }
  }

  void _showKeyDialog(Message msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DownloadKeyDialog(
        messageId: msg.id ?? 0,
        videoUrl: msg.file ?? msg.metadata?.videoUrl ?? '',
        onSuccess: () {
          if (msg.id != null) {
            setState(() => _downloadedMessageIds.add(msg.id!));
            final chatProvider = context.read<ChatProvider>();
            chatProvider.updateMessageOrderStatus(msg.id!, 'delivered');
            chatProvider.addMessage(
              Message(
                message: "Delivery status is updated as delivered",
                messageType: "order_accepted",
                createdAt: DateTime.now(),
                sender: OtherUser(id: 0),
              ),
            );
            if (!widget.isCelebrity) {
              chatProvider.addMessage(
                Message(
                  id: msg.id,
                  message: "You can rate your overall experience.",
                  messageType: "review_request",
                  createdAt: DateTime.now(),
                  sender: OtherUser(id: 0),
                  orderId: msg.orderId,
                  metadata: MessageMetadata(submitted: false),
                ),
              );
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFF8,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 0.1,
        title: ChatBer(
          name: _otherUserName,
          avatar: _otherUserAvatar,
          isOnline: _otherUserOnline,
          isTyping: false,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: getInboxMessageRx.getInboxStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final InboxResponseModel response = snapshot.data;
                      if ((response.data?.otherUser?.id == widget.id ||
                              (widget.roomId != null &&
                                  response.data?.room?.id == widget.roomId)) &&
                          _loadedForUserId != widget.id) {
                        _loadedForUserId = widget.id;
                        final otherUser = response.data?.otherUser;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          if (otherUser != null) {
                            setState(() {
                              _otherUserName = otherUser.name ?? widget.name;
                              _otherUserAvatar =
                                  otherUser.avatar ?? widget.image;
                              _otherUserOnline = otherUser.isOnline ?? false;
                            });
                          }
                          context.read<ChatProvider>().setMessages(
                            response.data?.messages ?? [],
                          );
                        });
                      }
                    }
                    return InboxMessageList(
                      scrollController: _scrollController,
                      currentUserId: currentUserId,
                      otherUserAvatar: _otherUserAvatar,
                      isCelebrity: widget.isCelebrity,
                      downloadedMessageIds: _downloadedMessageIds,
                      onDownload: _handleDownloadTap,
                      onReview: (msg, rating) async {
                        context.read<ChatProvider>().setReviewRating(
                          msg.id!,
                          rating,
                        );
                        final success = await postReviewRx.post(
                          rating: rating,
                          messageId: msg.id!,
                          celebrityId: widget.id,
                        );
                        if (success) {
                          customToastMessage(
                            "Success",
                            "Review submitted successfully",
                          );
                        } else {
                          if (mounted) {
                            // ignore: use_build_context_synchronously
                            context.read<ChatProvider>().setReviewRating(
                              msg.id!,
                              0,
                            );
                          }
                          customToastMessage("Error", postReviewRx.message);
                        }
                      },
                    );
                  },
                ),
              ),
              InboxInputBar(
                controller: _messageController,
                hasText: _hasText,
                onSend: () => _sendMessage(),
                onPickMedia: _pickMedia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
