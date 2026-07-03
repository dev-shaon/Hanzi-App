// To parse this JSON data, do
//
//     final featuredCelebrityModel = featuredCelebrityModelFromJson(jsonString);

import 'dart:convert';

FeaturedCelebrityModel featuredCelebrityModelFromJson(String str) => FeaturedCelebrityModel.fromJson(json.decode(str));

String featuredCelebrityModelToJson(FeaturedCelebrityModel data) => json.encode(data.toJson());

class FeaturedCelebrityModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;
  Pagination? pagination;

  FeaturedCelebrityModel({
    this.status,
    this.message,
    this.code,
    this.data,
    this.pagination,
  });

  factory FeaturedCelebrityModel.fromJson(Map<String, dynamic> json) => FeaturedCelebrityModel(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Datum {
  int? id;
  String? name;
  String? avatar;
  String? profession;
  String? startPrice;
  num? averageRating;
  String? tier;

  Datum({
    this.id,
    this.name,
    this.avatar,
    this.profession,
    this.startPrice,
    this.averageRating,
    this.tier,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: (json["id"] as num?)?.toInt(),
        name: json["name"],
        avatar: json["avatar"],
        profession: json["profession"],
        startPrice: json["startPrice"],
        averageRating: json["averageRating"],
        tier: json["tier"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "profession": profession,
    "startPrice": startPrice,
    "averageRating": averageRating,
    "tier": tier,
  };
}

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
