// To parse this JSON data, do
//
//     final searchBusinessModel = searchBusinessModelFromJson(jsonString);

import 'dart:convert';

SearchBusinessModel searchBusinessModelFromJson(String str) => SearchBusinessModel.fromJson(json.decode(str));

String searchBusinessModelToJson(SearchBusinessModel data) => json.encode(data.toJson());

class SearchBusinessModel {
  SearchBusinessModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<SearchBusiness> data;

  factory SearchBusinessModel.fromJson(Map<String, dynamic> json) => SearchBusinessModel(
    status: json["status"],
    message: json["message"],
    data: List<SearchBusiness>.from(json["data"].map((x) => SearchBusiness.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SearchBusiness {
  SearchBusiness({
    this.businessId,
    this.businessName,
    this.email,
    this.ownerName,
    this.vatNumber,
    this.address,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.businessContact,
    this.isAlwaysOpen,
    this.categoryId,
    this.businessType,
    this.logoImageUrl,
    this.featureImageUrl,
    this.totalPosts,
    this.totalFollowers,
    this.totalFollowing,
    this.isActive,
    this.addDate,
    this.editDate,
  });

  String? businessId;
  String? businessName;
  String? email;
  String? ownerName;
  String? vatNumber;
  String? address;
  String? city;
  String? country;
  String? latitude;
  String? longitude;
  String? businessContact;
  String? isAlwaysOpen;
  String? categoryId;
  String? businessType;
  String? logoImageUrl;
  String? featureImageUrl;
  String? totalPosts;
  String? totalFollowers;
  String? totalFollowing;
  String? isActive;
  DateTime? addDate;
  DateTime? editDate;

  factory SearchBusiness.fromJson(Map<String, dynamic> json) => SearchBusiness(
    businessId: json["businessId"],
    businessName: json["businessName"],
    email: json["email"],
    ownerName: json["ownerName"],
    vatNumber: json["vatNumber"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    businessContact: json["businessContact"],
    isAlwaysOpen: json["isAlwaysOpen"],
    categoryId: json["categoryId"],
    businessType: json["businessType"],
    logoImageUrl: json["logoImageUrl"],
    featureImageUrl: json["featureImageUrl"],
    totalPosts: json["totalPosts"],
    totalFollowers: json["totalFollowers"],
    totalFollowing: json["totalFollowing"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: DateTime.parse(json["editDate"]),
  );

  Map<String, dynamic> toJson() => {
    "businessId": businessId,
    "businessName": businessName,
    "email": email,
    "ownerName": ownerName,
    "vatNumber": vatNumber,
    "address": address,
    "city": city,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "businessContact": businessContact,
    "isAlwaysOpen": isAlwaysOpen,
    "categoryId": categoryId,
    "businessType": businessType,
    "logoImageUrl": logoImageUrl,
    "featureImageUrl": featureImageUrl,
    "totalPosts": totalPosts,
    "totalFollowers": totalFollowers,
    "totalFollowing": totalFollowing,
    "isActive": isActive,
    "addDate": addDate!.toIso8601String(),
    "editDate": editDate!.toIso8601String(),
  };
}
