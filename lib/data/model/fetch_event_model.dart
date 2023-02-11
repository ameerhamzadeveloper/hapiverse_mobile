// To parse this JSON data, do
//
//     final fetchEventModel = fetchEventModelFromJson(jsonString);

import 'dart:convert';

FetchEventModel fetchEventModelFromJson(String str) => FetchEventModel.fromJson(json.decode(str));

String fetchEventModelToJson(FetchEventModel data) => json.encode(data.toJson());

class FetchEventModel {
  FetchEventModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Event> data;

  factory FetchEventModel.fromJson(Map<String, dynamic> json) => FetchEventModel(
    status: json["status"],
    message: json["message"],
    data: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    this.eventId,
    this.businessId,
    this.eventName,
    this.eventDescription,
    this.eventTime,
    this.eventDate,
    this.latitude,
    this.longitude,
    this.address,
    this.addDate,
    this.images,
  });

  String? eventId;
  String? businessId;
  String? eventName;
  String? eventDescription;
  String? eventTime;
  DateTime? eventDate;
  String? latitude;
  String? longitude;
  String? address;
  DateTime? addDate;
  List<Image>? images;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    eventId: json["eventId"],
    businessId: json["businessId"],
    eventName: json["eventName"],
    eventDescription: json["eventDescription"],
    eventTime: json["eventTime"],
    eventDate: DateTime.parse(json["eventDate"]),
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    addDate: DateTime.parse(json["addDate"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "businessId": businessId,
    "eventName": eventName,
    "eventDescription": eventDescription,
    "eventTime": eventTime,
    "eventDate": eventDate!.toIso8601String(),
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "addDate": addDate!.toIso8601String(),
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    this.eventImageId,
    this.eventId,
    this.imageUrl,
  });

  String? eventImageId;
  String? eventId;
  String? imageUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    eventImageId: json["eventImageId"],
    eventId: json["eventId"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "eventImageId": eventImageId,
    "eventId": eventId,
    "imageUrl": imageUrl,
  };
}
