// To parse this JSON data, do
//
//     final fetchPlaces = fetchPlacesFromJson(jsonString);

import 'dart:convert';

FetchPlaces fetchPlacesFromJson(String str) => FetchPlaces.fromJson(json.decode(str));

String fetchPlacesToJson(FetchPlaces data) => json.encode(data.toJson());

class FetchPlaces {
  FetchPlaces({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<PlacesOur> data;

  factory FetchPlaces.fromJson(Map<String, dynamic> json) => FetchPlaces(
    status: json["status"],
    message: json["message"],
    data: List<PlacesOur>.from(json["data"].map((x) => PlacesOur.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PlacesOur {
  PlacesOur({
    required this.placeId,
    required this.userId,
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.addDate,
    required this.editDate,
    required this.images,
  });

  String placeId;
  String userId;
  String placeName;
  String latitude;
  String longitude;
  String address;
  DateTime addDate;
  String editDate;
  List<Image> images;

  factory PlacesOur.fromJson(Map<String, dynamic> json) => PlacesOur(
    placeId: json["placeId"],
    userId: json["userId"],
    placeName: json["placeName"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "placeId": placeId,
    "userId": userId,
    "placeName": placeName,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "addDate": addDate.toIso8601String(),
    "editDate": editDate,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.placeImageId,
    required this.placeId,
    required this.imageUrl,
  });

  String placeImageId;
  String placeId;
  String imageUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    placeImageId: json["placeImageId"],
    placeId: json["placeId"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "placeImageId": placeImageId,
    "placeId": placeId,
    "imageUrl": imageUrl,
  };
}
