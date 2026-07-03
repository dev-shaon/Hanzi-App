// To parse this JSON data, do
//
//     final earningsModel = earningsModelFromJson(jsonString);

import 'dart:convert';

EarningsModel earningsModelFromJson(String str) =>
    EarningsModel.fromJson(json.decode(str));

String earningsModelToJson(EarningsModel data) => json.encode(data.toJson());

class EarningsModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  EarningsModel({this.status, this.message, this.code, this.data});

  factory EarningsModel.fromJson(Map<String, dynamic> json) => EarningsModel(
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
  double? walletBalance;
  double? grossHeldAmount;
  double? onHoldAmount;
  int? readyAmount;
  int? transferredAmount;
  double? totalEarnings;
  int? orderEarnings;
  double? subscriptionEarnings;
  PlatformCharge? platformCharge;
  int? totalTransactions;
  int? pendingOrders;
  int? completedOrders;
  List<RecentTransaction>? recentTransactions;

  Data({
    this.walletBalance,
    this.grossHeldAmount,
    this.onHoldAmount,
    this.readyAmount,
    this.transferredAmount,
    this.totalEarnings,
    this.orderEarnings,
    this.subscriptionEarnings,
    this.platformCharge,
    this.totalTransactions,
    this.pendingOrders,
    this.completedOrders,
    this.recentTransactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletBalance: json["wallet_balance"]?.toDouble(),
    grossHeldAmount: json["gross_held_amount"]?.toDouble(),
    onHoldAmount: json["on_hold_amount"]?.toDouble(),
    readyAmount: json["ready_amount"],
    transferredAmount: json["transferred_amount"],
    totalEarnings: json["total_earnings"]?.toDouble(),
    orderEarnings: json["order_earnings"],
    subscriptionEarnings: json["subscription_earnings"]?.toDouble(),
    platformCharge: json["platform_charge"] == null
        ? null
        : PlatformCharge.fromJson(json["platform_charge"]),
    totalTransactions: json["total_transactions"],
    pendingOrders: json["pending_orders"],
    completedOrders: json["completed_orders"],
    recentTransactions: json["recent_transactions"] == null
        ? []
        : List<RecentTransaction>.from(
            json["recent_transactions"]!.map(
              (x) => RecentTransaction.fromJson(x),
            ),
          ),
  );

  Map<String, dynamic> toJson() => {
    "wallet_balance": walletBalance,
    "gross_held_amount": grossHeldAmount,
    "on_hold_amount": onHoldAmount,
    "ready_amount": readyAmount,
    "transferred_amount": transferredAmount,
    "total_earnings": totalEarnings,
    "order_earnings": orderEarnings,
    "subscription_earnings": subscriptionEarnings,
    "platform_charge": platformCharge?.toJson(),
    "total_transactions": totalTransactions,
    "pending_orders": pendingOrders,
    "completed_orders": completedOrders,
    "recent_transactions": recentTransactions == null
        ? []
        : List<dynamic>.from(recentTransactions!.map((x) => x.toJson())),
  };
}

class PlatformCharge {
  int? percentage;
  double? totalDeducted;
  double? lifetimeDeducted;

  PlatformCharge({this.percentage, this.totalDeducted, this.lifetimeDeducted});

  factory PlatformCharge.fromJson(Map<String, dynamic> json) => PlatformCharge(
    percentage: json["percentage"],
    totalDeducted: json["total_deducted"]?.toDouble(),
    lifetimeDeducted: json["lifetime_deducted"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "percentage": percentage,
    "total_deducted": totalDeducted,
    "lifetime_deducted": lifetimeDeducted,
  };
}

class RecentTransaction {
  int? id;
  String? trxId;
  double? amount;
  double? celebrityPayout;
  double? platformFee;
  String? currency;
  String? type;
  String? gateway;
  String? status;
  String? payoutStatus;
  String? orderUid;
  String? fanName;
  String? fanAvatar;
  String? createdAt;

  RecentTransaction({
    this.id,
    this.trxId,
    this.amount,
    this.celebrityPayout,
    this.platformFee,
    this.currency,
    this.type,
    this.gateway,
    this.status,
    this.payoutStatus,
    this.orderUid,
    this.fanName,
    this.fanAvatar,
    this.createdAt,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) =>
      RecentTransaction(
        id: json["id"],
        trxId: json["trx_id"],
        amount: json["amount"]?.toDouble(),
        celebrityPayout: json["celebrity_payout"]?.toDouble(),
        platformFee: json["platform_fee"]?.toDouble(),
        currency: json["currency"],
        type: json["type"],
        gateway: json["gateway"],
        status: json["status"],
        payoutStatus: json["payout_status"],
        orderUid: json["order_uid"],
        fanName: json["fan_name"],
        fanAvatar: json["fan_avatar"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trx_id": trxId,
    "amount": amount,
    "celebrity_payout": celebrityPayout,
    "platform_fee": platformFee,
    "currency": currency,
    "type": type,
    "gateway": gateway,
    "status": status,
    "payout_status": payoutStatus,
    "order_uid": orderUid,
    "fan_name": fanName,
    "fan_avatar": fanAvatar,
    "created_at": createdAt,
  };
}
