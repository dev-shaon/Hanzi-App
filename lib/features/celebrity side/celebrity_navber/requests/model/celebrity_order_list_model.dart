// To parse this JSON data, do
//
//     final celebrityOrderListModel = celebrityOrderListModelFromJson(jsonString);

import 'dart:convert';

CelebrityOrderListModel celebrityOrderListModelFromJson(String str) =>
    CelebrityOrderListModel.fromJson(json.decode(str));

String celebrityOrderListModelToJson(CelebrityOrderListModel data) =>
    json.encode(data.toJson());

class CelebrityOrderListModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  CelebrityOrderListModel({this.status, this.message, this.code, this.data});

  factory CelebrityOrderListModel.fromJson(Map<String, dynamic> json) =>
      CelebrityOrderListModel(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null
        ? []
        : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null
        ? []
        : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  String? uid;
  int? celebrityId;
  int? fanId;
  int? packageId;
  num? price;
  String? videoScript;
  dynamic videoUrl;
  dynamic downloadKey;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Celebrity? celebrity;
  Celebrity? fan;
  Package? package;
  Transaction? transaction;

  Datum({
    this.id,
    this.uid,
    this.celebrityId,
    this.fanId,
    this.packageId,
    this.price,
    this.videoScript,
    this.videoUrl,
    this.downloadKey,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.celebrity,
    this.fan,
    this.package,
    this.transaction,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uid: json["uid"],
    celebrityId: json["celebrity_id"],
    fanId: json["fan_id"],
    packageId: json["package_id"],
    price: json["price"],
    videoScript: json["video_script"],
    videoUrl: json["video_url"],
    downloadKey: json["download_key"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    celebrity: json["celebrity"] == null
        ? null
        : Celebrity.fromJson(json["celebrity"]),
    fan: json["fan"] == null ? null : Celebrity.fromJson(json["fan"]),
    package: json["package"] == null ? null : Package.fromJson(json["package"]),
    transaction: json["transaction"] == null
        ? null
        : Transaction.fromJson(json["transaction"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "celebrity_id": celebrityId,
    "fan_id": fanId,
    "package_id": packageId,
    "price": price,
    "video_script": videoScript,
    "video_url": videoUrl,
    "download_key": downloadKey,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "celebrity": celebrity?.toJson(),
    "fan": fan?.toJson(),
    "package": package?.toJson(),
    "transaction": transaction?.toJson(),
  };
}

class Celebrity {
  int? id;
  String? name;
  String? avatar;
  String? role;
  bool? isOnline;

  Celebrity({this.id, this.name, this.avatar, this.role, this.isOnline});

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    role: json["role"],
    isOnline: json["is_online"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "role": role,
    "is_online": isOnline,
  };
}

class Package {
  int? id;
  String? packageName;
  String? price;
  String? deliveryDays;

  Package({this.id, this.packageName, this.price, this.deliveryDays});

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    packageName: json["package_name"],
    price: json["price"],
    deliveryDays: json["delivery_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_name": packageName,
    "price": price,
    "delivery_days": deliveryDays,
  };
}

class Transaction {
  int? id;
  int? orderId;
  String? trxId;
  String? status;

  Transaction({this.id, this.orderId, this.trxId, this.status});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    orderId: json["order_id"],
    trxId: json["trx_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "trx_id": trxId,
    "status": status,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(url: json["url"], label: json["label"], active: json["active"]);

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
