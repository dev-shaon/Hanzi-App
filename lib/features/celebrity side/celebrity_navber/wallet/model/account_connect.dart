// To parse this JSON data, do
//
//     final accountConnectModel = accountConnectModelFromJson(jsonString);

import 'dart:convert';

AccountConnectModel accountConnectModelFromJson(String str) => AccountConnectModel.fromJson(json.decode(str));

String accountConnectModelToJson(AccountConnectModel data) => json.encode(data.toJson());

class AccountConnectModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    AccountConnectModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    factory AccountConnectModel.fromJson(Map<String, dynamic> json) => AccountConnectModel(
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
    String? onboardingUrl;
    String? accountId;

    Data({
        this.onboardingUrl,
        this.accountId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        onboardingUrl: json["onboarding_url"],
        accountId: json["account_id"],
    );

    Map<String, dynamic> toJson() => {
        "onboarding_url": onboardingUrl,
        "account_id": accountId,
    };
}
