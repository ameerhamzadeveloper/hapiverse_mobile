// To parse this JSON data, do
//
//     final fetchPhotoAlbum = fetchPhotoAlbumFromJson(jsonString);

import 'dart:convert';

FetchPhotoAlbum fetchPhotoAlbumFromJson(String str) => FetchPhotoAlbum.fromJson(json.decode(str));

String fetchPhotoAlbumToJson(FetchPhotoAlbum data) => json.encode(data.toJson());

class FetchPhotoAlbum {
  FetchPhotoAlbum({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<PhotoAlbum> data;

  factory FetchPhotoAlbum.fromJson(Map<String, dynamic> json) => FetchPhotoAlbum(
    status: json["status"],
    message: json["message"],
    data: List<PhotoAlbum>.from(json["data"].map((x) => PhotoAlbum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PhotoAlbum {
  PhotoAlbum({
    required this.albumId,
    required this.userId,
    required this.albumName,
    required this.addDate,
  });

  String albumId;
  String userId;
  String albumName;
  DateTime addDate;

  factory PhotoAlbum.fromJson(Map<String, dynamic> json) => PhotoAlbum(
    albumId: json["albumId"],
    userId: json["userId"],
    albumName: json["albumName"],
    addDate: DateTime.parse(json["addDate"]),
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "userId": userId,
    "albumName": albumName,
    "addDate": addDate.toIso8601String(),
  };
}
