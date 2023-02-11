// To parse this JSON data, do
//
//     final postCommentModel = postCommentModelFromJson(jsonString);

import 'dart:convert';

PostCommentModel postCommentModelFromJson(String str) => PostCommentModel.fromJson(json.decode(str));

String postCommentModelToJson(PostCommentModel data) => json.encode(data.toJson());

class PostCommentModel {
  PostCommentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<PostComments> data;

  factory PostCommentModel.fromJson(Map<String, dynamic> json) => PostCommentModel(
    status: json["status"],
    message: json["message"],
    data: List<PostComments>.from(json["data"].map((x) => PostComments.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PostComments {
  PostComments({
    this.postCommentId,
    this.userId,
    this.comment,
    this.postId,
    this.addDate,
    this.editDate,
    this.userName,
    this.profileImageUrl,
  });

  String? postCommentId;
  String? userId;
  String? comment;
  String? postId;
  DateTime? addDate;
  dynamic editDate;
  String? userName;
  String? profileImageUrl;

  factory PostComments.fromJson(Map<String, dynamic> json) => PostComments(
    postCommentId: json["postCommentId"],
    userId: json["userId"],
    comment: json["comment"],
    postId: json["postId"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "postCommentId": postCommentId,
    "userId": userId,
    "comment": comment,
    "postId": postId,
    "addDate": addDate!.toIso8601String(),
    "editDate": editDate,
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}
