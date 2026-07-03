// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  WalletModel({this.status, this.message, this.code, this.data});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
  double? orderEarnings;
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
    walletBalance: (json["wallet_balance"] as num?)?.toDouble(),
    grossHeldAmount: (json["gross_held_amount"] as num?)?.toDouble(),
    onHoldAmount: (json["on_hold_amount"] as num?)?.toDouble(),
    readyAmount: (json["ready_amount"] as num?)?.toInt(),
    transferredAmount: (json["transferred_amount"] as num?)?.toInt(),
    totalEarnings: (json["total_earnings"] as num?)?.toDouble(),
    orderEarnings: (json["order_earnings"] as num?)?.toDouble(),
    subscriptionEarnings: (json["subscription_earnings"] as num?)?.toDouble(),
    platformCharge: json["platform_charge"] == null
        ? null
        : PlatformCharge.fromJson(json["platform_charge"]),
    totalTransactions: (json["total_transactions"] as num?)?.toInt(),
    pendingOrders: (json["pending_orders"] as num?)?.toInt(),
    completedOrders: (json["completed_orders"] as num?)?.toInt(),
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
        id: (json["id"] as num?)?.toInt(),
        trxId: json["trx_id"],
        amount: (json["amount"] as num?)?.toDouble(),
        celebrityPayout: (json["celebrity_payout"] as num?)?.toDouble(),
        platformFee: (json["platform_fee"] as num?)?.toDouble(),
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
