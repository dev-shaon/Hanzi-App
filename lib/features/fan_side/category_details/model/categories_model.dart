import 'dart:convert';

class CategoriesModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    CategoriesModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    CategoriesModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        CategoriesModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory CategoriesModel.fromRawJson(String str) => CategoriesModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
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

    Data copyWith({
        List<Category>? categories,
    }) => 
        Data(
            categories: categories ?? this.categories,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

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
    dynamic image;
    String? status;

    Category({
        this.id,
        this.name,
        this.slug,
        this.image,
        this.status,
    });

    Category copyWith({
        int? id,
        String? name,
        String? slug,
        dynamic image,
        String? status,
    }) => 
        Category(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            image: image ?? this.image,
            status: status ?? this.status,
        );

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: (json["id"] as num?)?.toInt(),
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
