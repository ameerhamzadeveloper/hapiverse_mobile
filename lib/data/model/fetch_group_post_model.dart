// To parse this JSON data, do
//
//     final fetchGroupPostModel = fetchGroupPostModelFromJson(jsonString);

import 'dart:convert';

FetchGroupPostModel fetchGroupPostModelFromJson(String str) => FetchGroupPostModel.fromJson(json.decode(str));

String fetchGroupPostModelToJson(FetchGroupPostModel data) => json.encode(data.toJson());

class FetchGroupPostModel {
  FetchGroupPostModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<FetchGroupPost> data;

  factory FetchGroupPostModel.fromJson(Map<String, dynamic> json) => FetchGroupPostModel(
    status: json["status"],
    message: json["message"],
    data: List<FetchGroupPost>.from(json["data"].map((x) => FetchGroupPost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FetchGroupPost {
  FetchGroupPost({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.caption,
    required this.privacy,
    required this.contentType,
    required this.postType,
    this.fontColor,
    this.textBackGround,
    this.postedDate,
    this.expireAt,
    this.interest,
    this.active,
    this.profileImageUrl,
    this.location,
    this.postContentText,
    this.totalLike,
    this.totalComment,
    this.isLiked,
    this.postFiles,
    required this.hasVerified,
    required this.userTypeId
  });

  String postId;
  String userId;
  String userTypeId;
  String hasVerified;
  String userName;
  String caption;
  String privacy;
  String contentType;
  String postType;
  String? fontColor;
  String? textBackGround;
  DateTime? postedDate;
  String? expireAt;
  String? interest;
  String? active;
  String? profileImageUrl;
  String? location;
  String? postContentText;
  String? totalLike;
  String? totalComment;
  bool? isLiked;
  List<PostFile>? postFiles;

  factory FetchGroupPost.fromJson(Map<String, dynamic> json) => FetchGroupPost(
    postId: json["postId"],
    userId: json["userId"],
    userTypeId: json["userTypeId"] ?? '0',
    hasVerified: json["hasVerified"] ?? "0",
    userName: json["userName"] ?? "Hapiverse User",
    caption: json["caption"],
    privacy: json["privacy"],
    contentType: json["content_type"],
    postType: json["postType"],
    fontColor: json["font_color"],
    textBackGround: json["text_back_ground"],
    postedDate: DateTime.parse(json["posted_date"]),
    expireAt: json["expire_at"],
    interest: json["interest"],
    active: json["active"],
    profileImageUrl: json["profileImageUrl"],
    location: json["location"],
    postContentText: json["postContentText"],
    totalLike: json["totalLike"],
    totalComment: json["totalComment"],
    isLiked: json["isLiked"],
    postFiles: List<PostFile>.from(json["postFiles"].map((x) => PostFile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "userId": userId,
    "userName": userName,
    "caption": caption,
    "privacy": privacy,
    "content_type": contentType,
    "postType": postType,
    "font_color": fontColor,
    "text_back_ground": textBackGround,
    "posted_date": postedDate!.toIso8601String(),
    "expire_at": expireAt,
    "interest": interest,
    "active": active,
    "profileImageUrl": profileImageUrl,
    "location": location,
    "postContentText": postContentText,
    "totalLike": totalLike,
    "totalComment": totalComment,
    "isLiked": isLiked,
    "postFiles": List<dynamic>.from(postFiles!.map((x) => x.toJson())),
  };
}

class PostFile {
  PostFile({
    this.postFileId,
    this.postId,
    this.userId,
    this.postFileUrl,
  });

  String? postFileId;
  String? postId;
  String? userId;
  String? postFileUrl;

  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
    postFileId: json["postFileId"],
    postId: json["postId"],
    userId: json["userId"],
    postFileUrl: json["postFileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "postFileId": postFileId,
    "postId": postId,
    "userId": userId,
    "postFileUrl": postFileUrl,
  };
}
