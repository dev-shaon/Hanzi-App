// To parse this JSON data, do
//
//     final celebrityProfileModel = celebrityProfileModelFromJson(jsonString);

import 'dart:convert';

CelebrityProfileModel celebrityProfileModelFromJson(String str) =>
    CelebrityProfileModel.fromJson(json.decode(str));

String celebrityProfileModelToJson(CelebrityProfileModel data) =>
    json.encode(data.toJson());

class CelebrityProfileModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  CelebrityProfileModel({this.status, this.message, this.code, this.data});

  factory CelebrityProfileModel.fromJson(Map<String, dynamic> json) =>
      CelebrityProfileModel(
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
  int? id;
  String? name;
  String? email;
  dynamic avatar;
  DateTime? otpVerifiedAt;
  DateTime? lastActivityAt;
  String? status;
  String? role;
  bool? isOnline;
  Profile? profile;
  List<Role>? roles;

  Data({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.otpVerifiedAt,
    this.lastActivityAt,
    this.status,
    this.role,
    this.isOnline,
    this.profile,
    this.roles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: (json["id"] as num?)?.toInt(),
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        otpVerifiedAt: json["otp_verified_at"] == null
            ? null
            : DateTime.parse(json["otp_verified_at"]),
        lastActivityAt: json["last_activity_at"] == null
            ? null
            : DateTime.parse(json["last_activity_at"]),
        status: json["status"],
        role: json["role"],
        isOnline: json["is_online"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "otp_verified_at": otpVerifiedAt?.toIso8601String(),
    "last_activity_at": lastActivityAt?.toIso8601String(),
    "status": status,
    "role": role,
    "is_online": isOnline,
    "profile": profile?.toJson(),
    "roles": roles == null
        ? []
        : List<dynamic>.from(roles!.map((x) => x.toJson())),
  };
}

class Profile {
  int? id;
  int? userId;
  dynamic address;
  dynamic city;
  dynamic state;
  String? country;
  dynamic zipCode;
  String? username;
  String? displayName;
  String? phoneCode;
  String? phone;
  DateTime? dob;
  dynamic gender;
  String? bio;
  String? socialPlatform;
  DateTime? createdAt;
  DateTime? updatedAt;

  Profile({
    this.id,
    this.userId,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.username,
    this.displayName,
    this.phoneCode,
    this.phone,
    this.dob,
    this.gender,
    this.bio,
    this.socialPlatform,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: (json["id"] as num?)?.toInt(),
        userId: (json["user_id"] as num?)?.toInt(),
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        username: json["username"],
        displayName: json["display_name"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"],
        bio: json["bio"],
        socialPlatform: json["social_platform"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "zip_code": zipCode,
    "username": username,
    "display_name": displayName,
    "phone_code": phoneCode,
    "phone": phone,
    "dob":
        "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "bio": bio,
    "social_platform": socialPlatform,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Role {
  int? id;
  String? name;
  String? guardName;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  String? modelType;
  int? modelId;
  int? roleId;

  Pivot({this.modelType, this.modelId, this.roleId});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelType: json["model_type"],
    modelId: json["model_id"],
    roleId: json["role_id"],
  );

  Map<String, dynamic> toJson() => {
    "model_type": modelType,
    "model_id": modelId,
    "role_id": roleId,
  };
}
