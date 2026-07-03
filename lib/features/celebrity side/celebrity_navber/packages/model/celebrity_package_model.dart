// To parse this JSON data, do
//
//     final celebrityPackageModel = celebrityPackageModelFromJson(jsonString);

import 'dart:convert';

CelebrityPackageModel celebrityPackageModelFromJson(String str) => CelebrityPackageModel.fromJson(json.decode(str));

String celebrityPackageModelToJson(CelebrityPackageModel data) => json.encode(data.toJson());

class CelebrityPackageModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    CelebrityPackageModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    factory CelebrityPackageModel.fromJson(Map<String, dynamic> json) => CelebrityPackageModel(
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
    Post? post;

    Data({
        this.post,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
    );

    Map<String, dynamic> toJson() => {
        "post": post?.toJson(),
    };
}

class Post {
    int? id;
    int? celebrityId;
    int? categoryId;
    String? celebrityBio;
    String? mainTitle;
    String? description;
    List<String>? serviceTypes;
    List<String>? tags;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Package>? packages;

    Post({
        this.id,
        this.celebrityId,
        this.categoryId,
        this.celebrityBio,
        this.mainTitle,
        this.description,
        this.serviceTypes,
        this.tags,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.packages,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        celebrityId: json["celebrity_id"],
        categoryId: json["category_id"],
        celebrityBio: json["celebrity_bio"],
        mainTitle: json["main_title"],
        description: json["description"],
        serviceTypes: json["service_types"] == null ? [] : List<String>.from(json["service_types"]!.map((x) => x)),
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "celebrity_id": celebrityId,
        "category_id": categoryId,
        "celebrity_bio": celebrityBio,
        "main_title": mainTitle,
        "description": description,
        "service_types": serviceTypes == null ? [] : List<dynamic>.from(serviceTypes!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "packages": packages == null ? [] : List<dynamic>.from(packages!.map((x) => x.toJson())),
    };
}

class Package {
    int? id;
    int? celebrityPostId;
    String? packageName;
    String? description;
    String? price;
    String? deliveryDays;
    String? revisionLimit;
    int? editable;

    Package({
        this.id,
        this.celebrityPostId,
        this.packageName,
        this.description,
        this.price,
        this.deliveryDays,
        this.revisionLimit,
        this.editable,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        celebrityPostId: json["celebrity_post_id"],
        packageName: json["package_name"],
        description: json["description"],
        price: json["price"],
        deliveryDays: json["delivery_days"],
        revisionLimit: json["revision_limit"],
        editable: json["editable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "celebrity_post_id": celebrityPostId,
        "package_name": packageName,
        "description": description,
        "price": price,
        "delivery_days": deliveryDays,
        "revision_limit": revisionLimit,
        "editable": editable,
    };
}
