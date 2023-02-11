// To parse this JSON data, do
//
//     final locationSharToOtherModel = locationSharToOtherModelFromJson(jsonString);

import 'dart:convert';

LocationSharToOtherModel locationSharToOtherModelFromJson(String str) => LocationSharToOtherModel.fromJson(json.decode(str));

String locationSharToOtherModelToJson(LocationSharToOtherModel data) => json.encode(data.toJson());

class LocationSharToOtherModel {
  LocationSharToOtherModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<LocationShareToOther> data;

  factory LocationSharToOtherModel.fromJson(Map<String, dynamic> json) => LocationSharToOtherModel(
    status: json["status"],
    message: json["message"],
    data: List<LocationShareToOther>.from(json["data"].map((x) => LocationShareToOther.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LocationShareToOther {
  LocationShareToOther({
    this.trackLocationId,
    this.receiverId,
    this.userId,
    this.lat,
    this.long,
    this.address,
    this.isActive,
    this.addDate,
    this.userName,
    this.profileImageUrl,
  });

  String? trackLocationId;
  String? receiverId;
  String? userId;
  String? lat;
  String? long;
  String? address;
  String? isActive;
  DateTime? addDate;
  dynamic userName;
  dynamic profileImageUrl;

  factory LocationShareToOther.fromJson(Map<String, dynamic> json) => LocationShareToOther(
    trackLocationId: json["trackLocationId"],
    receiverId: json["receiverId"],
    userId: json["userId"],
    lat: json["lat"],
    long: json["long"],
    address: json["address"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "trackLocationId": trackLocationId,
    "receiverId": receiverId,
    "userId": userId,
    "lat": lat,
    "long": long,
    "address": address,
    "isActive": isActive,
    "addDate": addDate!.toIso8601String(),
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}
