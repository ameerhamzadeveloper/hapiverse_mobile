// To parse this JSON data, do
//
//     final suggestedFriendModel = suggestedFriendModelFromJson(jsonString);

import 'dart:convert';

SuggestedFriendModel suggestedFriendModelFromJson(String str) => SuggestedFriendModel.fromJson(json.decode(str));

String suggestedFriendModelToJson(SuggestedFriendModel data) => json.encode(data.toJson());

class SuggestedFriendModel {
  SuggestedFriendModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<SuggestedFriends> data;

  factory SuggestedFriendModel.fromJson(Map<String, dynamic> json) => SuggestedFriendModel(
    status: json["status"],
    message: json["message"],
    data: List<SuggestedFriends>.from(json["data"].map((x) => SuggestedFriends.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SuggestedFriends {
  SuggestedFriends({
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
    required this.distance,
    required this.isDeleted,
    required this.isFollowed
  });

  String userId;
  String userName;
  String profileImageUrl;
  String distance;
  bool isDeleted;
  bool isFollowed;

  factory SuggestedFriends.fromJson(Map<String, dynamic> json) => SuggestedFriends(
    userId: json["userId"],
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
    distance: json["distance"],
    isDeleted: false,
    isFollowed: false
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "profileImageUrl": profileImageUrl,
    "distance": distance,
  };
}
