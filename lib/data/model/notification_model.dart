// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<NotificationList> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    message: json["message"],
    data: List<NotificationList>.from(json["data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationList {
  NotificationList({
    this.notificationId,
    this.senderId,
    this.receiverId,
    this.notificationTypeId,
    this.subject,
    this.body,
    this.haveSeen,
    this.addDate,
    this.userName,
    this.profileImageUrl,
  });

  String? notificationId;
  String? senderId;
  String? receiverId;
  String? notificationTypeId;
  String? subject;
  String? body;
  String? haveSeen;
  DateTime? addDate;
  String? userName;
  String? profileImageUrl;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    notificationId: json["notificationId"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    notificationTypeId: json["notificationTypeId"],
    subject: json["subject"],
    body: json["body"],
    haveSeen: json["haveSeen"],
    addDate: DateTime.parse(json["addDate"]),
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "senderId": senderId,
    "receiverId": receiverId,
    "notificationTypeId": notificationTypeId,
    "subject": subject,
    "body": body,
    "haveSeen": haveSeen,
    "addDate": addDate!.toIso8601String(),
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}
