import 'dart:convert';

class CelebrityDetailsModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  CelebrityDetailsModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory CelebrityDetailsModel.fromRawJson(String str) =>
      CelebrityDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CelebrityDetailsModel.fromJson(Map<String, dynamic> json) =>
      CelebrityDetailsModel(
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
  dynamic phone;
  dynamic avatar;
  String? profession;
  String? startPrice;
  String? tier;
  List<String>? deliveryDaysRange;
  String? bio;
  String? mainTitle;
  String? description;
  List<String>? serviceTypes;
  int? age;
  DateTime? birthday;
  String? gender;
  String? totem;
  String? joinedDate;
  List<String>? tags;
  List<Package>? packages;
  num? averageRating;
  String? status;
  bool? isSubscribed;
  List<CelebrityVideo>? videos;
  bool? isFollowing;
  List<CelebrityReview>? reviews;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.profession,
    this.startPrice,
    this.tier,
    this.deliveryDaysRange,
    this.bio,
    this.mainTitle,
    this.description,
    this.serviceTypes,
    this.age,
    this.birthday,
    this.gender,
    this.totem,
    this.joinedDate,
    this.tags,
    this.packages,
    this.averageRating,
    this.status,
    this.isSubscribed,
    this.videos,
    this.isFollowing,
    this.reviews,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        profession: json["profession"],
        startPrice: json["startPrice"],
        tier: json["tier"],
        deliveryDaysRange: json["delivery_days_range"] == null
            ? []
            : List<String>.from(json["delivery_days_range"]!.map((x) => x)),
        bio: json["bio"],
        mainTitle: json["main_title"],
        description: json["description"],
        serviceTypes: json["service_types"] == null
            ? []
            : List<String>.from(json["service_types"]!.map((x) => x)),
        age: json["age"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        gender: json["gender"],
        totem: json["totem"],
        joinedDate: json["joined_date"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"]!.map((x) => Package.fromJson(x))),
        averageRating: json["averageRating"],
        status: json["status"],
        isSubscribed: json["isSubscribed"],
        videos: json["videos"] == null
            ? []
            : List<CelebrityVideo>.from(
                json["videos"]!.map((x) => CelebrityVideo.fromJson(x))),
        isFollowing: json["is_following"],
        reviews: json["reviews"] == null
            ? []
            : List<CelebrityReview>.from(
                json["reviews"]!.map((x) => CelebrityReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "profession": profession,
        "startPrice": startPrice,
        "tier": tier,
        "delivery_days_range": deliveryDaysRange == null
            ? []
            : List<dynamic>.from(deliveryDaysRange!.map((x) => x)),
        "bio": bio,
        "main_title": mainTitle,
        "description": description,
        "service_types": serviceTypes == null
            ? []
            : List<dynamic>.from(serviceTypes!.map((x) => x)),
        "age": age,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "totem": totem,
        "joined_date": joinedDate,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "averageRating": averageRating,
        "status": status,
        "isSubscribed": isSubscribed,
        "videos": videos == null
            ? []
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "is_following": isFollowing,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class CelebrityVideo {
  int? id;
  String? videoUrl;

  CelebrityVideo({
    this.id,
    this.videoUrl,
  });

  factory CelebrityVideo.fromJson(Map<String, dynamic> json) => CelebrityVideo(
        id: json["id"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_url": videoUrl,
      };
}

class CelebrityReview {
  int? id;
  int? fanId;
  int? celebrityId;
  num? rating;
  String? review;
  DateTime? createdAt;
  Fan? fan;

  CelebrityReview({
    this.id,
    this.fanId,
    this.celebrityId,
    this.rating,
    this.review,
    this.createdAt,
    this.fan,
  });

  factory CelebrityReview.fromJson(Map<String, dynamic> json) => CelebrityReview(
        id: json["id"],
        fanId: json["fan_id"],
        celebrityId: json["celebrity_id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        fan: json["fan"] == null ? null : Fan.fromJson(json["fan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fan_id": fanId,
        "celebrity_id": celebrityId,
        "rating": rating,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
        "fan": fan?.toJson(),
      };
}

class Fan {
  int? id;
  String? name;
  String? avatar;

  Fan({
    this.id,
    this.name,
    this.avatar,
  });

  factory Fan.fromJson(Map<String, dynamic> json) => Fan(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}

class Package {
  int? id;
  String? name;
  String? price;
  String? description;
  String? deliveryDays;
  String? revisionLimit;
  int? editable;

  Package({
    this.id,
    this.name,
    this.price,
    this.description,
    this.deliveryDays,
    this.revisionLimit,
    this.editable,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        deliveryDays: json["delivery_days"],
        revisionLimit: json["revision_limit"],
        editable: json["editable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "delivery_days": deliveryDays,
        "revision_limit": revisionLimit,
        "editable": editable,
      };
}
