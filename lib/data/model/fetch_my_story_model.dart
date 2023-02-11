// To parse this JSON data, do
//
//     final fetchMyStoryModel = fetchMyStoryModelFromJson(jsonString);

import 'dart:convert';

FetchMyStoryModel fetchMyStoryModelFromJson(String str) => FetchMyStoryModel.fromJson(json.decode(str));

String fetchMyStoryModelToJson(FetchMyStoryModel data) => json.encode(data.toJson());

class FetchMyStoryModel {
  FetchMyStoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  FetchMyStory data;

  factory FetchMyStoryModel.fromJson(Map<String, dynamic> json) => FetchMyStoryModel(
    status: json["status"],
    message: json["message"],
    data: FetchMyStory.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class FetchMyStory {
  FetchMyStory({
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
    required this.storyItem,
  });

  String userId;
  String userName;
  String profileImageUrl;
  List<StoryItems> storyItem;

  factory FetchMyStory.fromJson(Map<String, dynamic> json) => FetchMyStory(
    userId: json["userId"] ?? "",
    userName: json["userName"] ?? "",
    profileImageUrl: json["profileImageUrl"] ?? "",
    storyItem: List<StoryItems>.from(json["storyItem"].map((x) => StoryItems.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "profileImageUrl": profileImageUrl,
    "storyItem": List<dynamic>.from(storyItem.map((x) => x.toJson())),
  };
}

class StoryItems {
  StoryItems({
    this.userId,
    this.caption,
    this.privacy,
    this.contentType,
    this.postType,
    this.fontColor,
    this.textBackGround,
    this.postedDate,
    this.expireAt,
    this.interest,
    this.active,
    this.profileName,
    this.profileImageUrl,
    this.location,
    this.postContentText,
    this.totalLike,
    this.totalComment,
    this.isLiked,
    this.postFiles,
    this.postId
  });

  String? userId;
  String? caption;
  String? privacy;
  String? contentType;
  String? postType;
  String? fontColor;
  String? textBackGround;
  DateTime? postedDate;
  String? expireAt;
  String? interest;
  String? active;
  String? profileName;
  String? profileImageUrl;
  String? location;
  String? postContentText;
  String? totalLike;
  String? totalComment;
  bool? isLiked;
  String? postId;
  List<PostFile>? postFiles;

  factory StoryItems.fromJson(Map<String, dynamic> json) => StoryItems(
    userId: json["userId"],
    caption: json["caption"],
    privacy: json["privacy"],
    contentType: json["content_type"],
    postType: json["postType"],
    fontColor: json["font_color"].toString(),
    textBackGround: json["text_back_ground"],
    postedDate: DateTime.parse(json["posted_date"]),
    expireAt: json["expire_at"],
    interest: json["interest"],
    active: json["active"],
    profileName: json["profileName"],
    profileImageUrl: json["profileImageUrl"],
    location: json["location"],
    postContentText: json["postContentText"],
    totalLike: json["totalLike"],
    totalComment: json["totalComment"],
    isLiked: json["isLiked"],
    postId: json["postId"],
    postFiles: List<PostFile>.from(json["postFiles"].map((x) => PostFile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
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
    "profileName": profileName,
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
