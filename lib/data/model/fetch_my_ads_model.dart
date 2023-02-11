// To parse this JSON data, do
//
//     final fetchAdsModel = fetchAdsModelFromJson(jsonString);

import 'dart:convert';

FetchAdsModel fetchAdsModelFromJson(String str) => FetchAdsModel.fromJson(json.decode(str));

String fetchAdsModelToJson(FetchAdsModel data) => json.encode(data.toJson());

class FetchAdsModel {
  FetchAdsModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<BusinessAds>? data;

  factory FetchAdsModel.fromJson(Map<String, dynamic> json) => FetchAdsModel(
    status: json["status"],
    message: json["message"],
    data: List<BusinessAds>.from(json["data"].map((x) => BusinessAds.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BusinessAds {
  BusinessAds({
    this.adId,
    this.adType,
    this.adTitle,
    this.adDescription,
    this.businessId,
    this.adContent,
    this.audianceStartAge,
    this.audianceEndAge,
    this.startDate,
    this.endDate,
    this.totalimpressions,
    this.totalBudget,
    this.status,
    this.addDate,
    this.totalClicks,
    this.spent,
    this.image
  });

  int? adId;
  String? adType;
  String? adTitle;
  String? adDescription;
  String? businessId;
  String? adContent;
  int? audianceStartAge;
  int? audianceEndAge;
  DateTime? startDate;
  DateTime? endDate;
  String? totalimpressions;
  String? totalBudget;
  int? status;
  DateTime? addDate;
  String? totalClicks;
  String? spent;
  String? image;

  factory BusinessAds.fromJson(Map<String, dynamic> json) => BusinessAds(
    adId: json["adId"],
    adType: json["adType"],
    adTitle: json["adTitle"],
    adDescription: json["adDescription"],
    businessId: json["businessId"],
    adContent: json["adContent"],
    audianceStartAge: json["audianceStartAge"],
    audianceEndAge: json["audianceEndAge"],
    startDate: json["startDate"] == null ? null :DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null :DateTime.parse(json["endDate"]),
    totalimpressions: json["totalimpressions"].toString() == null ? "" : json["totalimpressions"].toString(),
    totalBudget: json["totalBudget"],
    status: json["status"],
    totalClicks: json["totalClicks"].toString(),
    spent: json["spent"].toString(),
    image: json["image"].toString(),
    addDate: DateTime.parse(json["addDate"]),
  );

  Map<String, dynamic> toJson() => {
    "adId": adId,
    "adType": adType,
    "adTitle": adTitle,
    "adDescription": adDescription,
    "businessId": businessId,
    "adContent": adContent,
    "audianceStartAge": audianceStartAge,
    "audianceEndAge": audianceEndAge,
    "startDate": startDate!.toIso8601String(),
    "endDate": endDate!.toIso8601String(),
    "totalimpressions": totalimpressions == null ? "" : totalimpressions,
    "totalBudget": totalBudget,
    "status": status,
    "addDate": addDate!.toIso8601String(),
  };
}
