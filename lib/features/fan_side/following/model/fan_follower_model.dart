// To parse this JSON data, do
//
//     final fanFollowerModel = fanFollowerModelFromJson(jsonString);

import 'dart:convert';

FanFollowerModel fanFollowerModelFromJson(String str) =>
    FanFollowerModel.fromJson(json.decode(str));

String fanFollowerModelToJson(FanFollowerModel data) =>
    json.encode(data.toJson());

class FanFollowerModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;

  FanFollowerModel({this.status, this.message, this.code, this.data});

  factory FanFollowerModel.fromJson(Map<String, dynamic> json) =>
      FanFollowerModel(
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
  String? name;
  String? email;
  dynamic avatar;
  dynamic profession;
  dynamic bio;
  dynamic minPrice;
  String? status;

  Datum({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.profession,
    this.bio,
    this.minPrice,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    profession: json["profession"],
    bio: json["bio"],
    minPrice: json["min_price"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "profession": profession,
    "bio": bio,
    "min_price": minPrice,
    "status": status,
  };
}
