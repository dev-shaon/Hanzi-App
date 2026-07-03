// To parse this JSON data, do
//
//     final professionCategoryModel = professionCategoryModelFromJson(jsonString);

import 'dart:convert';

ProfessionCategoryModel professionCategoryModelFromJson(String str) => ProfessionCategoryModel.fromJson(json.decode(str));

String professionCategoryModelToJson(ProfessionCategoryModel data) => json.encode(data.toJson());

class ProfessionCategoryModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    ProfessionCategoryModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    factory ProfessionCategoryModel.fromJson(Map<String, dynamic> json) => ProfessionCategoryModel(
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
    List<Category>? categories;

    Data({
        this.categories,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class Category {
    int? id;
    String? name;
    String? slug;
    String? image;
    String? status;

    Category({
        this.id,
        this.name,
        this.slug,
        this.image,
        this.status,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "status": status,
    };
}
