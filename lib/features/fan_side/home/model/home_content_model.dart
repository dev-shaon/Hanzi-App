// To parse this JSON data, do
//
//     final homeContentModel = homeContentModelFromJson(jsonString);

import 'dart:convert';

import 'package:tc_mcandy/constants/app_constants.dart';

HomeContentModel homeContentModelFromJson(String str) =>
    HomeContentModel.fromJson(json.decode(str));

String homeContentModelToJson(HomeContentModel data) =>
    json.encode(data.toJson());

class HomeContentModel {
  List<Category>? categories;
  List<Celebrity>? featuredCelebrities;
  List<Celebrity>? topCelebrities;
  List<Celebrity>? recentCelebrities;

  HomeContentModel({
    this.categories,
    this.featuredCelebrities,
    this.topCelebrities,
    this.recentCelebrities,
  });

  factory HomeContentModel.fromJson(Map<String, dynamic> json) =>
      HomeContentModel(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x)),
              ),
        featuredCelebrities: json["featured_celebrities"] == null
            ? []
            : List<Celebrity>.from(
                json["featured_celebrities"]!.map((x) => Celebrity.fromJson(x)),
              ),
        topCelebrities: json["top_celebrities"] == null
            ? []
            : List<Celebrity>.from(
                json["top_celebrities"]!.map((x) => Celebrity.fromJson(x)),
              ),
        recentCelebrities: json["recent_celebrities"] == null
            ? []
            : List<Celebrity>.from(
                json["recent_celebrities"]!.map((x) => Celebrity.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "featured_celebrities": featuredCelebrities == null
        ? []
        : List<dynamic>.from(featuredCelebrities!.map((x) => x.toJson())),
    "top_celebrities": topCelebrities == null
        ? []
        : List<dynamic>.from(topCelebrities!.map((x) => x.toJson())),
    "recent_celebrities": recentCelebrities == null
        ? []
        : List<dynamic>.from(recentCelebrities!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: (json["id"] as num?)?.toInt(),
        name: json["name"],
        image: json["image"] ?? kDefaultProfileImage,
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "image": image};
}

class Celebrity {
  int? id;
  String? name;
  String? avatar;
  String? profession;
  String? startPrice;
  num? averageRating;
  num? completedOrders;
  String? tier;

  Celebrity({
    this.id,
    this.name,
    this.avatar,
    this.profession,
    this.startPrice,
    this.averageRating,
    this.completedOrders,
    this.tier,
  });

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
        id: (json["id"] as num?)?.toInt(),
        name: json["name"],
        avatar: json["avatar"] ?? kDefaultProfileImage,
        profession: json["profession"],
        startPrice: json["startPrice"],
        averageRating: json["averageRating"],
        completedOrders: json["completedOrders"],
        tier: json["tier"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "profession": profession,
    "startPrice": startPrice,
    "averageRating": averageRating,
    "completedOrders": completedOrders,
    "tier": tier,
  };
}
