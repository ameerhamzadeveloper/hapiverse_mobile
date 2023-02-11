// To parse this JSON data, do
//
//     final fetchCardModel = fetchCardModelFromJson(jsonString);

import 'dart:convert';

FetchCardModel fetchCardModelFromJson(String str) => FetchCardModel.fromJson(json.decode(str));

String fetchCardModelToJson(FetchCardModel data) => json.encode(data.toJson());

class FetchCardModel {
  FetchCardModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<PaymentCard> data;

  factory FetchCardModel.fromJson(Map<String, dynamic> json) => FetchCardModel(
    status: json["status"],
    message: json["message"],
    data: List<PaymentCard>.from(json["data"].map((x) => PaymentCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PaymentCard {
  PaymentCard({
    required this.paymentCardId,
    required this.userId,
    required this.userTypeId,
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvc,
    required this.expiryMonth,
    required  this.expiryYear,
    required this.isActive,
    required  this.addDate,
    required this.isSelected
  });

  int paymentCardId;
  String userId;
  dynamic userTypeId;
  String cardHolderName;
  String cardNumber;
  String cvc;
  String expiryMonth;
  String expiryYear;
  int isActive;
  DateTime addDate;
  bool isSelected;

  factory PaymentCard.fromJson(Map<String, dynamic> json) => PaymentCard(
    paymentCardId: json["paymentCardId"],
    userId: json["userId"],
    userTypeId: json["userTypeId"],
    cardHolderName: json["cardHolderName"],
    cardNumber: json["cardNumber"],
    cvc: json["cvc"],
    isSelected: false,
    expiryMonth: json["expiryMonth"],
    expiryYear: json["expiryYear"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentCardId": paymentCardId,
    "userId": userId,
    "userTypeId": userTypeId,
    "cardHolderName": cardHolderName,
    "cardNumber": cardNumber,
    "cvc": cvc,
    "expiryMonth": expiryMonth,
    "expiryYear": expiryYear,
    "isActive": isActive,
    "addDate": addDate.toIso8601String(),
  };
}
