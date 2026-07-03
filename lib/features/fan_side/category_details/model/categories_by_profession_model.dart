// To parse this JSON data, do
//
//     final categoryByProfessionModel = categoryByProfessionModelFromJson(jsonString);

import 'dart:convert';

CategoryByProfessionModel categoryByProfessionModelFromJson(String str) =>
    CategoryByProfessionModel.fromJson(json.decode(str));

String categoryByProfessionModelToJson(CategoryByProfessionModel data) =>
    json.encode(data.toJson());

class CategoryByProfessionModel {
  bool? status;
  String? message;
  int? code;
  Data? data;
  Pagination? pagination;

  CategoryByProfessionModel({
    this.status,
    this.message,
    this.code,
    this.data,
    this.pagination,
  });

  factory CategoryByProfessionModel.fromJson(Map<String, dynamic> json) =>
      CategoryByProfessionModel(
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

class Data {
  Category? category;
  List<Celebrity>? celebrities;

  Data({this.category, this.celebrities});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
    celebrities: json["celebrities"] == null
        ? []
        : List<Celebrity>.from(
            json["celebrities"]!.map((x) => Celebrity.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "celebrities": celebrities == null
        ? []
        : List<dynamic>.from(celebrities!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;

  Category({this.id, this.name, this.slug, this.image});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: (json["id"] as num?)?.toInt(),
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
  };
}

class Celebrity {
  int? id;
  String? name;
  String? avatar;
  String? profession;
  String? startPrice;
  num? averageRating;

  String? tier;

  Celebrity({
    this.id,
    this.name,
    this.avatar,
    this.profession,
    this.startPrice,
    this.averageRating,
    this.tier,
  });

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
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
