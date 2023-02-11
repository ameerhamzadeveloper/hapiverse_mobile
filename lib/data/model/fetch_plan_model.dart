// To parse this JSON data, do
//
//     final fetchPlanModel = fetchPlanModelFromJson(jsonString);

import 'dart:convert';

FetchPlanModel fetchPlanModelFromJson(String str) => FetchPlanModel.fromJson(json.decode(str));

String fetchPlanModelToJson(FetchPlanModel data) => json.encode(data.toJson());

class FetchPlanModel {
  FetchPlanModel({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  String statusCode;
  String status;
  String message;
  List<Plan> data;

  factory FetchPlanModel.fromJson(Map<String, dynamic> json) => FetchPlanModel(
    statusCode: json["status_code"],
    status: json["status"],
    message: json["message"],
    data: List<Plan>.from(json["data"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Plan {
  Plan({
    required this.choosedPlanId,
    required this.planId,
    required this.email,
    required this.planStartDate,
    required this.planEndDate,
    required this.isActive,
    required this.addDate,
  });

  int choosedPlanId;
  int planId;
  String email;
  DateTime planStartDate;
  DateTime planEndDate;
  int isActive;
  DateTime addDate;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    choosedPlanId: json["choosedPlanId"],
    planId: json["planId"],
    email: json["email"],
    planStartDate: DateTime.parse(json["planStartDate"]),
    planEndDate: DateTime.parse(json["planEndDate"]),
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
  );

  Map<String, dynamic> toJson() => {
    "choosedPlanId": choosedPlanId,
    "planId": planId,
    "email": email,
    "planStartDate": "${planStartDate.year.toString().padLeft(4, '0')}-${planStartDate.month.toString().padLeft(2, '0')}-${planStartDate.day.toString().padLeft(2, '0')}",
    "planEndDate": "${planEndDate.year.toString().padLeft(4, '0')}-${planEndDate.month.toString().padLeft(2, '0')}-${planEndDate.day.toString().padLeft(2, '0')}",
    "isActive": isActive,
    "addDate": addDate.toIso8601String(),
  };
}
