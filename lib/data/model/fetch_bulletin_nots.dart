// To parse this JSON data, do
//
//     final fetchBullitenNotesModel = fetchBullitenNotesModelFromJson(jsonString);

import 'dart:convert';

FetchBullitenNotesModel fetchBullitenNotesModelFromJson(String str) => FetchBullitenNotesModel.fromJson(json.decode(str));

String fetchBullitenNotesModelToJson(FetchBullitenNotesModel data) => json.encode(data.toJson());

class FetchBullitenNotesModel {
  FetchBullitenNotesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<BulletinNotes> data;

  factory FetchBullitenNotesModel.fromJson(Map<String, dynamic> json) => FetchBullitenNotesModel(
    status: json["status"],
    message: json["message"],
    data: List<BulletinNotes>.from(json["data"].map((x) => BulletinNotes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BulletinNotes {
  BulletinNotes({
    required this.bullitenNoteId,
    required this.bullitenId,
    required this.userId,
    required this.title,
    required this.body,
    required this.addDate,
    this.userName,
    this.profileImageUrl,
  });

  String bullitenNoteId;
  String bullitenId;
  String userId;
  String title;
  String body;
  DateTime addDate;
  dynamic userName;
  dynamic profileImageUrl;

  factory BulletinNotes.fromJson(Map<String, dynamic> json) => BulletinNotes(
    bullitenNoteId: json["bullitenNoteId"],
    bullitenId: json["bullitenId"],
    userId: json["userId"],
    title: json["title"],
    body: json["body"],
    addDate: DateTime.parse(json["addDate"]),
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "bullitenNoteId": bullitenNoteId,
    "bullitenId": bullitenId,
    "userId": userId,
    "title": title,
    "body": body,
    "addDate": addDate.toIso8601String(),
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}
