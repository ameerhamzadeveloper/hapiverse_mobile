// To parse this JSON data, do
//
//     final fetchFriendModel = fetchFriendModelFromJson(jsonString);

import 'dart:convert';

FetchFriendModel fetchFriendModelFromJson(String str) => FetchFriendModel.fromJson(json.decode(str));

String fetchFriendModelToJson(FetchFriendModel data) => json.encode(data.toJson());

class FetchFriendModel {
  FetchFriendModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<FetchFriend> data;

  factory FetchFriendModel.fromJson(Map<String, dynamic> json) => FetchFriendModel(
    status: json["status"],
    message: json["message"],
    data: List<FetchFriend>.from(json["data"].map((x) => FetchFriend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FetchFriend {
  FetchFriend({
    required this.userId,
    required this.profileImageUrl,
    required this.userName,
  });

  String userId;
  String profileImageUrl;
  String userName;

  factory FetchFriend.fromJson(Map<String, dynamic> json) => FetchFriend(
    userId: json["userId"],
    profileImageUrl: json["profileImageUrl"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "profileImageUrl": profileImageUrl,
    "userName": userName,
  };
}
