// To parse this JSON data, do
//
//     final coinsModel = coinsModelFromJson(jsonString);

import 'dart:convert';

CoinsModel coinsModelFromJson(String str) => CoinsModel.fromJson(json.decode(str));

String coinsModelToJson(CoinsModel data) => json.encode(data.toJson());

class CoinsModel {
  CoinsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalCoin,
  });

  int status;
  String message;
  List<CoinsUser> data;
  TotalCoin totalCoin;

  factory CoinsModel.fromJson(Map<String, dynamic> json) => CoinsModel(
    status: json["status"],
    message: json["message"],
    data: List<CoinsUser>.from(json["data"].map((x) => CoinsUser.fromJson(x))),
    totalCoin: TotalCoin.fromJson(json["totalCoin"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "totalCoin": totalCoin.toJson(),
  };
}

class CoinsUser {
  CoinsUser({
    required this.coinId,
    required this.businessId,
    required this.userId,
    required this.coin,
    required this.addDate,
    required this.businessName,
    required this.logoImageUrl,
  });

  String coinId;
  String businessId;
  String userId;
  String coin;
  String addDate;
  String businessName;
  String logoImageUrl;

  factory CoinsUser.fromJson(Map<String, dynamic> json) => CoinsUser(
    coinId: json["coinId"],
    businessId: json["businessId"],
    userId: json["userId"],
    coin: json["coin"],
    addDate: json["addDate"],
    businessName: json["businessName"],
    logoImageUrl: json["logoImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "coinId": coinId,
    "businessId": businessId,
    "userId": userId,
    "coin": coin,
    "addDate": addDate,
    "businessName": businessName,
    "logoImageUrl": logoImageUrl,
  };
}

class TotalCoin {
  TotalCoin({
    required this.coin,
  });

  String coin;

  factory TotalCoin.fromJson(Map<String, dynamic> json) => TotalCoin(
    coin: json["coin"],
  );

  Map<String, dynamic> toJson() => {
    "coin": coin,
  };
}
