// To parse this JSON data, do
//
//     final getFriendForGroupInviteModel = getFriendForGroupInviteModelFromJson(jsonString);

import 'dart:convert';

GetFriendForGroupInviteModel getFriendForGroupInviteModelFromJson(String str) => GetFriendForGroupInviteModel.fromJson(json.decode(str));

String getFriendForGroupInviteModelToJson(GetFriendForGroupInviteModel data) => json.encode(data.toJson());

class GetFriendForGroupInviteModel {
  GetFriendForGroupInviteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<GetFriendForGroupInvite> data;

  factory GetFriendForGroupInviteModel.fromJson(Map<String, dynamic> json) => GetFriendForGroupInviteModel(
    status: json["status"],
    message: json["message"],
    data: List<GetFriendForGroupInvite>.from(json["data"].map((x) => GetFriendForGroupInvite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetFriendForGroupInvite {
  GetFriendForGroupInvite({
    this.userId,
    this.profileImageUrl,
    this.userName,
    this.alreadyInvited,
  });

  String? userId;
  String? profileImageUrl;
  String? userName;
  bool? alreadyInvited;

  factory GetFriendForGroupInvite.fromJson(Map<String, dynamic> json) => GetFriendForGroupInvite(
    userId: json["userId"],
    profileImageUrl: json["profileImageUrl"],
    userName: json["userName"],
    alreadyInvited: json["alreadyInvited"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "profileImageUrl": profileImageUrl,
    "userName": userName,
    "alreadyInvited": alreadyInvited,
  };
}
