// To parse this JSON data, do
//
//     final businessProfileModel = businessProfileModelFromJson(jsonString);

import 'dart:convert';

BusinessProfileModel businessProfileModelFromJson(String str) => BusinessProfileModel.fromJson(json.decode(str));

String businessProfileModelToJson(BusinessProfileModel data) => json.encode(data.toJson());

class BusinessProfileModel {
  BusinessProfileModel({
    required this.status,
    required this.message,
    required  this.data,
  });

  int status;
  String message;
  BusinessProfile data;

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) => BusinessProfileModel(
    status: json["status"],
    message: json["message"],
    data: BusinessProfile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class BusinessProfile {
  BusinessProfile({
    this.businessId,
    this.businessName,
    this.email,
    this.ownerName,
    this.featureImageUrl,
    this.logoImageUrl,
    this.isAlwaysOpen,
    this.city,
    this.businessContact,
    this.country,
    this.latitude,
    this.longitude,
    this.address,
    this.totalFollowing,
    this.totalFollowers,
    this.totalPosts,
    this.categoryId,
    this.businessType,
    this.isActive,
    this.addDate,
    this.editDate,
    this.businessHours,
    this.isFriend,
  });

  String? businessId;
  String? businessName;
  String? email;
  String? ownerName;
  String? featureImageUrl;
  String? logoImageUrl;
  String? isAlwaysOpen;
  String? city;
  String? businessContact;
  String? country;
  String? latitude;
  String? longitude;
  String? address;
  String? totalFollowing;
  String? totalFollowers;
  String? totalPosts;
  String? categoryId;
  String? businessType;
  String? isActive;
  DateTime? addDate;
  String? editDate;
  List<BusinessHour>? businessHours;
  String? isFriend;

  factory BusinessProfile.fromJson(Map<String, dynamic> json) => BusinessProfile(
    businessId: json["businessId"],
    businessName: json["businessName"],
    email: json["email"],
    ownerName: json["ownerName"],
    featureImageUrl: json["featureImageUrl"],
    logoImageUrl: json["logoImageUrl"],
    isAlwaysOpen: json["isAlwaysOpen"],
    city: json["city"],
    businessContact: json["businessContact"],
    country: json["country"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    totalFollowing: json["totalFollowing"],
    totalFollowers: json["totalFollowers"],
    totalPosts: json["totalPosts"],
    categoryId: json["categoryId"],
    businessType: json["businessType"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    businessHours: List<BusinessHour>.from(json["businessHours"].map((x) => BusinessHour.fromJson(x))),
    isFriend: json["IsFriend"],
  );

  Map<String, dynamic> toJson() => {
    "businessId": businessId,
    "businessName": businessName,
    "email": email,
    "ownerName": ownerName,
    "featureImageUrl": featureImageUrl,
    "logoImageUrl": logoImageUrl,
    "isAlwaysOpen": isAlwaysOpen,
    "city": city,
    "businessContact": businessContact,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "totalFollowing": totalFollowing,
    "totalFollowers": totalFollowers,
    "totalPosts": totalPosts,
    "categoryId": categoryId,
    "businessType": businessType,
    "isActive": isActive,
    "addDate": addDate!.toIso8601String(),
    "editDate": editDate,
    "businessHours": List<dynamic>.from(businessHours!.map((x) => x.toJson())),
    "IsFriend": isFriend,
  };
}

class BusinessHour {
  BusinessHour({
    required this.hoursId,
    required this.businessId,
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  String hoursId;
  String businessId;
  String day;
  String openTime;
  String closeTime;

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    hoursId: json["hoursId"],
    businessId: json["businessId"],
    day: json["day"],
    openTime: json["openTime"],
    closeTime: json["closeTime"],
  );

  Map<String, dynamic> toJson() => {
    "hoursId": hoursId,
    "businessId": businessId,
    "day": day,
    "openTime": openTime,
    "closeTime": closeTime,
  };
}
