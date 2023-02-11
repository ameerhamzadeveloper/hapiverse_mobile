// To parse this JSON data, do
//
//     final covidRecordModel = covidRecordModelFromJson(jsonString);

import 'dart:convert';

CovidRecordModel covidRecordModelFromJson(String str) => CovidRecordModel.fromJson(json.decode(str));

String covidRecordModelToJson(CovidRecordModel data) => json.encode(data.toJson());

class CovidRecordModel {
  CovidRecordModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<CovidRecord> data;

  factory CovidRecordModel.fromJson(Map<String, dynamic> json) => CovidRecordModel(
    status: json["status"],
    message: json["message"],
    data: List<CovidRecord>.from(json["data"].map((x) => CovidRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CovidRecord {
  CovidRecord({
    this.covidId,
    this.userId,
    this.hospitalName,
    this.covidStatus,
    this.date,
  });

  String? covidId;
  String? userId;
  String? hospitalName;
  String? covidStatus;
  DateTime? date;

  factory CovidRecord.fromJson(Map<String, dynamic> json) => CovidRecord(
    covidId: json["covidId"],
    userId: json["userId"],
    hospitalName: json["hospitalName"],
    covidStatus: json["covidStatus"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "covidId": covidId,
    "userId": userId,
    "hospitalName": hospitalName,
    "covidStatus": covidStatus,
    "date": date!.toIso8601String(),
  };
}
