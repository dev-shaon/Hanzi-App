import 'dart:convert';

class InboxResponseModel {
  bool? status;
  String? message;
  int? code;
  Data? data;
  Pagination? pagination;

  InboxResponseModel({
    this.status,
    this.message,
    this.code,
    this.data,
    this.pagination,
  });

  factory InboxResponseModel.fromRawJson(String str) =>
      InboxResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InboxResponseModel.fromJson(Map<String, dynamic> json) =>
      InboxResponseModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data?.toJson(),
    "pagination": pagination?.toJson(),
  };
}

// ─── Data ─────────────────────────────────────────────────────────────────────

class Data {
  Room? room;
  OtherUser? otherUser;
  List<Message>? messages;
  Subscription? subscription;

  Data({this.room, this.otherUser, this.messages, this.subscription});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    room: json["room"] == null ? null : Room.fromJson(json["room"]),
    otherUser: json["other_user"] == null
        ? null
        : OtherUser.fromJson(json["other_user"]),
    messages: json["messages"] == null
        ? []
        : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    subscription: json["subscription"] == null
        ? null
        : Subscription.fromJson(json["subscription"]),
  );

  Map<String, dynamic> toJson() => {
    "room": room?.toJson(),
    "other_user": otherUser?.toJson(),
    "messages": messages == null
        ? []
        : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "subscription": subscription?.toJson(),
  };
}

// ─── Message ──────────────────────────────────────────────────────────────────

class Message {
  int? id;
  String? message;
  String? file;
  String? fileType;
  String? status;
  num? rating;
  String? type;
  String? messageType;
  dynamic orderId;
  Order? order;
  MessageMetadata? metadata;
  DateTime? createdAt;
  String? humanizeDate;
  bool? isHidden;
  OtherUser? sender;
  OtherUser? receiver;
  String? downloadKey;

  // ✅ metadata.rating কে priority দাও, fallback হিসেবে top-level rating
  num? get effectiveRating => metadata?.rating ?? rating;

  bool get isOrderDelivery => messageType == 'order_delivery';
  bool get hasDownloadKey => downloadKey != null && downloadKey!.isNotEmpty;
  bool get isStatus =>
      messageType == 'order_accepted' || messageType == 'status';
  bool get isReviewPrompt =>
      messageType == 'review_prompt' || messageType == 'review_request';

  // ✅ effectiveRating use করো
  bool get isSubmitted =>
      metadata?.submitted == true ||
      (effectiveRating != null && effectiveRating! > 0);

  bool get isOrderDelivered =>
      order?.status == 'delivered' || order?.status == 'completed';

  Message({
    this.id,
    this.message,
    this.file,
    this.fileType,
    this.status,
    this.type,
    this.messageType,
    this.orderId,
    this.order,
    this.metadata,
    this.createdAt,
    this.humanizeDate,
    this.isHidden,
    this.sender,
    this.receiver,
    this.downloadKey,
    this.rating,
  });

  Message copyWith({
    int? id,
    String? message,
    String? file,
    String? fileType,
    String? status,
    String? type,
    String? messageType,
    dynamic orderId,
    Order? order,
    MessageMetadata? metadata,
    DateTime? createdAt,
    String? humanizeDate,
    bool? isHidden,
    OtherUser? sender,
    OtherUser? receiver,
    String? downloadKey,
    num? rating,
  }) => Message(
    id: id ?? this.id,
    message: message ?? this.message,
    file: file ?? this.file,
    fileType: fileType ?? this.fileType,
    status: status ?? this.status,
    type: type ?? this.type,
    messageType: messageType ?? this.messageType,
    orderId: orderId ?? this.orderId,
    order: order ?? this.order,
    metadata: metadata ?? this.metadata,
    createdAt: createdAt ?? this.createdAt,
    humanizeDate: humanizeDate ?? this.humanizeDate,
    isHidden: isHidden ?? this.isHidden,
    sender: sender ?? this.sender,
    receiver: receiver ?? this.receiver,
    downloadKey: downloadKey ?? this.downloadKey,
    rating: rating ?? this.rating,
  );

  factory Message.fromJson(Map<String, dynamic> json) {
    final metadata = json["metadata"] == null
        ? null
        : MessageMetadata.fromJson(json["metadata"]);
    final order = json["order"] == null ? null : Order.fromJson(json["order"]);

    final rawKey = metadata?.downloadKey ?? order?.downloadKey;
    final downloadKey =
        (rawKey != null && rawKey.isNotEmpty && rawKey != 'null')
        ? rawKey
        : null;

    return Message(
      id: (json["id"] as num?)?.toInt(),
      message: json["message"],
      file: json["file"],
      fileType: json["file_type"],
      status: json["status"],
      rating: json["rating"],
      type: json["type"],
      messageType: json["message_type"],
      orderId: (json["order_id"] as num?)?.toInt(),
      order: order,
      metadata: metadata,
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      humanizeDate: json["humanize_date"],
      isHidden: json["is_hidden"],
      sender: json["sender"] == null
          ? null
          : OtherUser.fromJson(json["sender"]),
      receiver: json["receiver"] == null
          ? null
          : OtherUser.fromJson(json["receiver"]),
      downloadKey: downloadKey,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "file": file,
    "file_type": fileType,
    "status": status,
    "rating": rating,
    "type": type,
    "message_type": messageType,
    "order_id": orderId,
    "order": order?.toJson(),
    "metadata": metadata?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "humanize_date": humanizeDate,
    "is_hidden": isHidden,
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "download_key": downloadKey,
  };
}

// ─── Order ────────────────────────────────────────────────────────────────────

class Order {
  int? id;
  String? uid;
  String? status;
  num? price;
  String? videoUrl;
  String? downloadKey;

  Order({
    this.id,
    this.uid,
    this.status,
    this.price,
    this.videoUrl,
    this.downloadKey,
  });

  Order copyWith({
    int? id,
    String? uid,
    String? status,
    num? price,
    String? videoUrl,
    String? downloadKey,
  }) => Order(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    status: status ?? this.status,
    price: price ?? this.price,
    videoUrl: videoUrl ?? this.videoUrl,
    downloadKey: downloadKey ?? this.downloadKey,
  );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: (json["id"] as num?)?.toInt(),
    uid: json["uid"],
    status: json["status"],
    price: json["price"],
    videoUrl: json["video_url"],
    downloadKey: json["download_key"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "status": status,
    "price": price,
    "video_url": videoUrl,
    "download_key": downloadKey,
  };
}

// ─── MessageMetadata ──────────────────────────────────────────────────────────

class MessageMetadata {
  num? price;
  String? orderUid;
  String? videoUrl;
  String? downloadKey;
  String? packageName;
  bool? submitted;
  List<int>? ratingOptions;
  String? acceptedAt;
  num? rating; // ✅ নতুন
  int? reviewId; // ✅ নতুন

  MessageMetadata({
    this.price,
    this.orderUid,
    this.videoUrl,
    this.downloadKey,
    this.packageName,
    this.submitted,
    this.ratingOptions,
    this.acceptedAt,
    this.rating, // ✅ নতুন
    this.reviewId, // ✅ নতুন
  });

  MessageMetadata copyWith({
    num? price,
    String? orderUid,
    String? videoUrl,
    String? downloadKey,
    String? packageName,
    bool? submitted,
    List<int>? ratingOptions,
    String? acceptedAt,
    num? rating, // ✅ নতুন
    int? reviewId, // ✅ নতুন
  }) => MessageMetadata(
    price: price ?? this.price,
    orderUid: orderUid ?? this.orderUid,
    videoUrl: videoUrl ?? this.videoUrl,
    downloadKey: downloadKey ?? this.downloadKey,
    packageName: packageName ?? this.packageName,
    submitted: submitted ?? this.submitted,
    ratingOptions: ratingOptions ?? this.ratingOptions,
    acceptedAt: acceptedAt ?? this.acceptedAt,
    rating: rating ?? this.rating,
    reviewId: reviewId ?? this.reviewId,
  );

  factory MessageMetadata.fromJson(Map<String, dynamic> json) =>
      MessageMetadata(
        price: json["price"],
        orderUid: json["order_uid"],
        videoUrl: json["video_url"],
        downloadKey: json["download_key"]?.toString(),
        packageName: json["package_name"],
        submitted: json["submitted"],
        ratingOptions: json["rating_options"] == null
            ? []
            : List<int>.from(json["rating_options"]!.map((x) => x)),
        acceptedAt: json["accepted_at"],
        // ✅ metadata.rating parse করো (String হিসেবে আসতে পারে)
        rating: json["rating"] != null
            ? num.tryParse(json["rating"].toString())
            : null,
        reviewId: (json["review_id"] as num?)?.toInt(), // ✅ নতুন
      );

  Map<String, dynamic> toJson() => {
    "price": price,
    "order_uid": orderUid,
    "video_url": videoUrl,
    "download_key": downloadKey,
    "package_name": packageName,
    "submitted": submitted,
    "rating_options": ratingOptions == null
        ? []
        : List<dynamic>.from(ratingOptions!.map((x) => x)),
    "accepted_at": acceptedAt,
    "rating": rating, // ✅ নতুন
    "review_id": reviewId, // ✅ নতুন
  };
}

// ─── OtherUser ────────────────────────────────────────────────────────────────

class OtherUser {
  int? id;
  String? name;
  String? email;
  String? avatar;
  DateTime? lastActivityAt;
  String? role;
  bool? isOnline;

  OtherUser({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.lastActivityAt,
    this.role,
    this.isOnline,
  });

  OtherUser copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    DateTime? lastActivityAt,
    String? role,
    bool? isOnline,
  }) => OtherUser(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    lastActivityAt: lastActivityAt ?? this.lastActivityAt,
    role: role ?? this.role,
    isOnline: isOnline ?? this.isOnline,
  );

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: (json["id"] as num?)?.toInt(),
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    lastActivityAt: json["last_activity_at"] == null
        ? null
        : DateTime.tryParse(json["last_activity_at"]),
    role: json["role"],
    isOnline: json["is_online"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "last_activity_at": lastActivityAt?.toIso8601String(),
    "role": role,
    "is_online": isOnline,
  };
}

// ─── Room ─────────────────────────────────────────────────────────────────────

class Room {
  int? id;
  int? fanId;
  int? celebrityId;

  Room({this.id, this.fanId, this.celebrityId});

  Room copyWith({int? id, int? fanId, int? celebrityId}) => Room(
    id: id ?? this.id,
    fanId: fanId ?? this.fanId,
    celebrityId: celebrityId ?? this.celebrityId,
  );

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: (json["id"] as num?)?.toInt(),
    fanId: (json["fan_id"] as num?)?.toInt(),
    celebrityId: (json["celebrity_id"] as num?)?.toInt(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fan_id": fanId,
    "celebrity_id": celebrityId,
  };
}

// ─── Subscription ─────────────────────────────────────────────────────────────

class Subscription {
  int? id;
  String? status;
  dynamic expiresAt;

  Subscription({this.id, this.status, this.expiresAt});

  Subscription copyWith({int? id, String? status, dynamic expiresAt}) =>
      Subscription(
        id: id ?? this.id,
        status: status ?? this.status,
        expiresAt: expiresAt ?? this.expiresAt,
      );

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: (json["id"] as num?)?.toInt(),
    status: json["status"],
    expiresAt: json["expires_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "expires_at": expiresAt,
  };
}

// ─── Pagination ───────────────────────────────────────────────────────────────

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  String? firstPageUrl;
  String? lastPageUrl;
  dynamic nextPageUrl;
  dynamic prevPageUrl;
  int? from;
  int? to;
  String? path;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    this.from,
    this.to,
    this.path,
  });

  Pagination copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    String? firstPageUrl,
    String? lastPageUrl,
    dynamic nextPageUrl,
    dynamic prevPageUrl,
    int? from,
    int? to,
    String? path,
  }) => Pagination(
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    perPage: perPage ?? this.perPage,
    total: total ?? this.total,
    firstPageUrl: firstPageUrl ?? this.firstPageUrl,
    lastPageUrl: lastPageUrl ?? this.lastPageUrl,
    nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    prevPageUrl: prevPageUrl ?? this.prevPageUrl,
    from: from ?? this.from,
    to: to ?? this.to,
    path: path ?? this.path,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
    firstPageUrl: json["first_page_url"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
    from: json["from"],
    to: json["to"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
    "first_page_url": firstPageUrl,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
    "from": from,
    "to": to,
    "path": path,
  };
}
