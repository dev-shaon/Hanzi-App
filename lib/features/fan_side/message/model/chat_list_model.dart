// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

ChatListModel chatListModelFromJson(String str) => ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    ChatListModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
    };
}

class Data {
    List<Room>? rooms;

    Data({
        this.rooms,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        rooms: json["rooms"] == null ? [] : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
    };
}

class Room {
    int? roomId;
    User? user;
    LastMessage? lastMessage;
    num? unreadCount;
    Subscription? subscription;

    Room({
        this.roomId,
        this.user,
        this.lastMessage,
        this.unreadCount,
        this.subscription,
    });

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomId: (json["room_id"] as num?)?.toInt(),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
        unreadCount: json["unread_count"],
        subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    );

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "user": user?.toJson(),
        "last_message": lastMessage?.toJson(),
        "unread_count": unreadCount,
        "subscription": subscription?.toJson(),
    };
}

class LastMessage {
    int? id;
    String? message;
    dynamic fileType;
    String? status;
    DateTime? createdAt;
    String? humanizeDate;
    bool? isMine;

    LastMessage({
        this.id,
        this.message,
        this.fileType,
        this.status,
        this.createdAt,
        this.humanizeDate,
        this.isMine,
    });

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: (json["id"] as num?)?.toInt(),
        message: json["message"],
        fileType: json["file_type"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        humanizeDate: json["humanize_date"],
        isMine: json["is_mine"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "file_type": fileType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "humanize_date": humanizeDate,
        "is_mine": isMine,
    };
}

class Subscription {
    String? status;
    dynamic expiresAt;

    Subscription({
        this.status,
        this.expiresAt,
    });

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        status: json["status"],
        expiresAt: json["expires_at"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "expires_at": expiresAt,
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? avatar;
    bool? isOnline;
    DateTime? lastActivityAt;

    User({
        this.id,
        this.name,
        this.email,
        this.avatar,
        this.isOnline,
        this.lastActivityAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: (json["id"] as num?)?.toInt(),
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        isOnline: json["is_online"],
        lastActivityAt: json["last_activity_at"] == null ? null : DateTime.parse(json["last_activity_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "is_online": isOnline,
        "last_activity_at": lastActivityAt?.toIso8601String(),
    };
}
