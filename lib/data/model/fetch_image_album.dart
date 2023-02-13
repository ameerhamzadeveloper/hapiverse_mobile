// To parse this JSON data, do
//
//     final fetchAlbumImages = fetchAlbumImagesFromJson(jsonString);

import 'dart:convert';

FetchAlbumImages fetchAlbumImagesFromJson(String str) => FetchAlbumImages.fromJson(json.decode(str));

String fetchAlbumImagesToJson(FetchAlbumImages data) => json.encode(data.toJson());

class FetchAlbumImages {
  FetchAlbumImages({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<ImageAlbum> data;

  factory FetchAlbumImages.fromJson(Map<String, dynamic> json) => FetchAlbumImages(
    status: json["status"],
    message: json["message"],
    data: List<ImageAlbum>.from(json["data"].map((x) => ImageAlbum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ImageAlbum {
  ImageAlbum({
    required this.albumImageId,
    required this.albumId,
    required this.userId,
    required this.imageUrl,
    required this.addDate,
  });

  String albumImageId;
  String albumId;
  String userId;
  String imageUrl;
  String addDate;

  factory ImageAlbum.fromJson(Map<String, dynamic> json) => ImageAlbum(
    albumImageId: json["albumImageId"],
    albumId: json["albumId"],
    userId: json["userId"],
    imageUrl: json["imageUrl"],
    addDate: json["addDate"],
  );

  Map<String, dynamic> toJson() => {
    "albumImageId": albumImageId,
    "albumId": albumId,
    "userId": userId,
    "imageUrl": imageUrl,
    "addDate": addDate,
  };
}
