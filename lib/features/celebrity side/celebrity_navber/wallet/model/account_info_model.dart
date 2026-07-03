// To parse this JSON data, do
//
//     final accountInfoModel = accountInfoModelFromJson(jsonString);

import 'dart:convert';

AccountInfoModel accountInfoModelFromJson(String str) => AccountInfoModel.fromJson(json.decode(str));

String accountInfoModelToJson(AccountInfoModel data) => json.encode(data.toJson());

class AccountInfoModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    AccountInfoModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    factory AccountInfoModel.fromJson(Map<String, dynamic> json) => AccountInfoModel(
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
    String? accountId;
    String? email;
    bool? chargesEnabled;
    bool? payoutsEnabled;
    int? stripeOnboarded;
    bool? detailsSubmitted;

    Data({
        this.accountId,
        this.email,
        this.chargesEnabled,
        this.payoutsEnabled,
        this.stripeOnboarded,
        this.detailsSubmitted,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountId: json["account_id"],
        email: json["email"],
        chargesEnabled: json["charges_enabled"],
        payoutsEnabled: json["payouts_enabled"],
        stripeOnboarded: json["stripe_onboarded"],
        detailsSubmitted: json["details_submitted"],
    );

    Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "email": email,
        "charges_enabled": chargesEnabled,
        "payouts_enabled": payoutsEnabled,
        "stripe_onboarded": stripeOnboarded,
        "details_submitted": detailsSubmitted,
    };
}
