// To parse this JSON data, do
//
//     final fetchBullitenModel = fetchBullitenModelFromJson(jsonString);

import 'dart:convert';

FetchBullitenModel fetchBullitenModelFromJson(String str) => FetchBullitenModel.fromJson(json.decode(str));

String fetchBullitenModelToJson(FetchBullitenModel data) => json.encode(data.toJson());

class FetchBullitenModel {
  FetchBullitenModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Bullitens> data;

  factory FetchBullitenModel.fromJson(Map<String, dynamic> json) => FetchBullitenModel(
    status: json["status"],
    message: json["message"],
    data: List<Bullitens>.from(json["data"].map((x) => Bullitens.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Bullitens {
  Bullitens({
    required this.bullitenId,
    required this.businessId,
    required this.title,
    required this.body,
    required this.addDate,
  });

  String bullitenId;
  String businessId;
  String title;
  String body;
  DateTime addDate;

  factory Bullitens.fromJson(Map<String, dynamic> json) => Bullitens(
    bullitenId: json["bullitenId"],
    businessId: json["businessId"],
    title: json["title"],
    body: json["body"],
    addDate: DateTime.parse(json["addDate"]),
  );

  Map<String, dynamic> toJson() => {
    "bullitenId": bullitenId,
    "businessId": businessId,
    "title": title,
    "body": body,
    "addDate": addDate.toIso8601String(),
  };
}
