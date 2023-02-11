// To parse this JSON data, do
//
//     final cardDataModel = cardDataModelFromJson(jsonString);

import 'dart:convert';

CardDataModel cardDataModelFromJson(String str) => CardDataModel.fromJson(json.decode(str));

String cardDataModelToJson(CardDataModel data) => json.encode(data.toJson());

class CardDataModel {
    CardDataModel({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    List<Map<String, String?>> data;

    factory CardDataModel.fromJson(Map<String, dynamic> json) => CardDataModel(
        status: json["status"],
        message: json["message"],
        data: List<Map<String, String?>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
}
