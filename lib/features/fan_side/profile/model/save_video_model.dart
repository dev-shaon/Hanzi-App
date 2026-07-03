// To parse this JSON data, do
//
//     final saveVideosModel = saveVideosModelFromJson(jsonString);

import 'dart:convert';

SaveVideosModel saveVideosModelFromJson(String str) =>
    SaveVideosModel.fromJson(json.decode(str));

String saveVideosModelToJson(SaveVideosModel data) =>
    json.encode(data.toJson());

class SaveVideosModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;

  SaveVideosModel({this.status, this.message, this.code, this.data});

  factory SaveVideosModel.fromJson(Map<String, dynamic> json) =>
      SaveVideosModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? fanId;
  int? celebrityId;
  String? videoUrl;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Celebrity? celebrity;

  Datum({
    this.id,
    this.fanId,
    this.celebrityId,
    this.videoUrl,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.celebrity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    fanId: json["fan_id"],
    celebrityId: json["celebrity_id"],
    videoUrl: json["video_url"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    celebrity: json["celebrity"] == null
        ? null
        : Celebrity.fromJson(json["celebrity"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fan_id": fanId,
    "celebrity_id": celebrityId,
    "video_url": videoUrl,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "celebrity": celebrity?.toJson(),
  };
}

class Celebrity {
  int? id;
  String? name;
  String? slug;
  String? email;
  dynamic otp;
  dynamic otpExpiresAt;
  DateTime? otpVerifiedAt;
  dynamic resetPasswordToken;
  dynamic resetPasswordTokenExpireAt;
  dynamic avatar;
  DateTime? lastActivityAt;
  dynamic stripeCustomerId;
  String? stripeAccountId;
  dynamic stripeSubscriptionId;
  dynamic planId;
  String? status;
  String? isOwner;
  String? isFeatured;
  int? reviewsDisabled;
  String? tier;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  bool? isOnline;

  Celebrity({
    this.id,
    this.name,
    this.slug,
    this.email,
    this.otp,
    this.otpExpiresAt,
    this.otpVerifiedAt,
    this.resetPasswordToken,
    this.resetPasswordTokenExpireAt,
    this.avatar,
    this.lastActivityAt,
    this.stripeCustomerId,
    this.stripeAccountId,
    this.stripeSubscriptionId,
    this.planId,
    this.status,
    this.isOwner,
    this.isFeatured,
    this.reviewsDisabled,
    this.tier,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.isOnline,
  });

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    email: json["email"],
    otp: json["otp"],
    otpExpiresAt: json["otp_expires_at"],
    otpVerifiedAt: json["otp_verified_at"] == null
        ? null
        : DateTime.parse(json["otp_verified_at"]),
    resetPasswordToken: json["reset_password_token"],
    resetPasswordTokenExpireAt: json["reset_password_token_expire_at"],
    avatar: json["avatar"],
    lastActivityAt: json["last_activity_at"] == null
        ? null
        : DateTime.parse(json["last_activity_at"]),
    stripeCustomerId: json["stripe_customer_id"],
    stripeAccountId: json["stripe_account_id"],
    stripeSubscriptionId: json["stripe_subscription_id"],
    planId: json["plan_id"],
    status: json["status"],
    isOwner: json["is_owner"],
    isFeatured: json["is_featured"],
    reviewsDisabled: json["reviews_disabled"],
    tier: json["tier"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    role: json["role"],
    isOnline: json["is_online"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "email": email,
    "otp": otp,
    "otp_expires_at": otpExpiresAt,
    "otp_verified_at": otpVerifiedAt?.toIso8601String(),
    "reset_password_token": resetPasswordToken,
    "reset_password_token_expire_at": resetPasswordTokenExpireAt,
    "avatar": avatar,
    "last_activity_at": lastActivityAt?.toIso8601String(),
    "stripe_customer_id": stripeCustomerId,
    "stripe_account_id": stripeAccountId,
    "stripe_subscription_id": stripeSubscriptionId,
    "plan_id": planId,
    "status": status,
    "is_owner": isOwner,
    "is_featured": isFeatured,
    "reviews_disabled": reviewsDisabled,
    "tier": tier,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "role": role,
    "is_online": isOnline,
  };
}
