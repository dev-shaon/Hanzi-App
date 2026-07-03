// To parse this JSON data, do
//
//     final managerListModel = managerListModelFromJson(jsonString);

import 'dart:convert';

ManagerListModel managerListModelFromJson(String str) => ManagerListModel.fromJson(json.decode(str));

String managerListModelToJson(ManagerListModel data) => json.encode(data.toJson());

class ManagerListModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;

  ManagerListModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory ManagerListModel.fromJson(Map<String, dynamic> json) => ManagerListModel(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? email;
  dynamic phone;
  String? invitationStatus;
  DateTime? invitationSentAt;
  DateTime? invitationAcceptedAt;
  String? status;
  DateTime? createdAt;

  Datum({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.invitationStatus,
    this.invitationSentAt,
    this.invitationAcceptedAt,
    this.status,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    invitationStatus: json["invitation_status"],
    invitationSentAt: json["invitation_sent_at"] == null ? null : DateTime.parse(json["invitation_sent_at"]),
    invitationAcceptedAt: json["invitation_accepted_at"] == null ? null : DateTime.parse(json["invitation_accepted_at"]),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "invitation_status": invitationStatus,
    "invitation_sent_at": invitationSentAt?.toIso8601String(),
    "invitation_accepted_at": invitationAcceptedAt?.toIso8601String(),
    "status": status,
    "created_at": createdAt?.toIso8601String(),
  };
}
