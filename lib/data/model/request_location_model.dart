// To parse this JSON data, do
//
//     final requestLocationModel = requestLocationModelFromJson(jsonString);

import 'dart:convert';

RequestLocationModel requestLocationModelFromJson(String str) => RequestLocationModel.fromJson(json.decode(str));

String requestLocationModelToJson(RequestLocationModel data) => json.encode(data.toJson());

class RequestLocationModel {
  RequestLocationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<RequestLocation> data;

  factory RequestLocationModel.fromJson(Map<String, dynamic> json) => RequestLocationModel(
    status: json["status"],
    message: json["message"],
    data: List<RequestLocation>.from(json["data"].map((x) => RequestLocation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RequestLocation {
  RequestLocation({
    required this.requestId,
    required this.requesterId,
    required this.userId,
    required this.locationType,
    required this.status,
    required this.dateTime,
    required this.userName,
    required this.profileImageUrl,
  });

  String requestId;
  String requesterId;
  String userId;
  String locationType;
  String status;
  DateTime dateTime;
  String userName;
  String profileImageUrl;

  factory RequestLocation.fromJson(Map<String, dynamic> json) => RequestLocation(
    requestId: json["requestId"] ?? "",
    requesterId: json["requesterId"],
    userId: json["userId"],
    locationType: json["locationType"],
    status: json["status"],
    dateTime: DateTime.parse(json["dateTime"]),
    userName: json["userName"] ?? "",
    profileImageUrl: json["profileImageUrl"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requesterId": requesterId,
    "userId": userId,
    "locationType": locationType,
    "status": status,
    "dateTime": dateTime.toIso8601String(),
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}


