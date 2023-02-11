// To parse this JSON data, do
//
//     final fetchGroupInviteModel = fetchGroupInviteModelFromJson(jsonString);

import 'dart:convert';

FetchGroupInviteModel fetchGroupInviteModelFromJson(String str) => FetchGroupInviteModel.fromJson(json.decode(str));

String fetchGroupInviteModelToJson(FetchGroupInviteModel data) => json.encode(data.toJson());

class FetchGroupInviteModel {
  FetchGroupInviteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<FetchGroupInvite> data;

  factory FetchGroupInviteModel.fromJson(Map<String, dynamic> json) => FetchGroupInviteModel(
    status: json["status"],
    message: json["message"],
    data: List<FetchGroupInvite>.from(json["data"].map((x) => FetchGroupInvite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FetchGroupInvite {
  FetchGroupInvite({
    required this.invitationId,
    required this.userId,
    required this.inviterId,
    required this.groupId,
    required this.addDate,
    required this.invitationStatus,
    required this.username,
    required this.profileImageUrl,
  });

  String invitationId;
  String userId;
  String inviterId;
  String groupId;
  DateTime addDate;
  String invitationStatus;
  String username;
  String profileImageUrl;

  factory FetchGroupInvite.fromJson(Map<String, dynamic> json) => FetchGroupInvite(
    invitationId: json["invitationId"],
    userId: json["userId"],
    inviterId: json["inviterId"],
    groupId: json["groupId"],
    addDate: DateTime.parse(json["addDate"]),
    invitationStatus: json["invitationStatus"],
    username: json["username"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "invitationId": invitationId,
    "userId": userId,
    "inviterId": inviterId,
    "groupId": groupId,
    "addDate": addDate.toIso8601String(),
    "invitationStatus": invitationStatus,
    "username": username,
    "profileImageUrl": profileImageUrl,
  };
}
