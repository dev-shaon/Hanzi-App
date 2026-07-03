// To parse this JSON data, do
//
//     final leaderBoardModel = leaderBoardModelFromJson(jsonString);

import 'dart:convert';

import 'package:tc_mcandy/constants/app_constants.dart';

LeaderBoardModel leaderBoardModelFromJson(String str) =>
    LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) =>
    json.encode(data.toJson());

class LeaderBoardModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;

  LeaderBoardModel({this.status, this.message, this.code, this.data});

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
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
  String? avatar;
  String? profession;
  String? startPrice;
  num? averageRating;
  num? rank;
  num? deliveredOrdersCount;
  num? totalReviews;

  Datum({
    this.id,
    this.name,
    this.avatar,
    this.profession,
    this.startPrice,
    this.averageRating,
    this.rank,
    this.deliveredOrdersCount,
    this.totalReviews,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: (json["id"] as num?)?.toInt(),
    name: json["name"],
    avatar:
        json["avatar"] ??
        kDefaultProfileImage,
    profession: json["profession"],
    startPrice: json["startPrice"],
    averageRating: json["averageRating"],
    rank: json["rank"],
    deliveredOrdersCount: json["delivered_orders_count"],
    totalReviews: json["total_reviews"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "profession": profession,
    "startPrice": startPrice,
    "averageRating": averageRating,
    "rank": rank,
    "delivered_orders_count": deliveredOrdersCount,
    "total_reviews": totalReviews,
  };
}
