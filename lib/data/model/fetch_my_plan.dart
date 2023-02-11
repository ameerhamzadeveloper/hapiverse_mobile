// To parse this JSON data, do
//
//     final fetchMyPlan = fetchMyPlanFromJson(jsonString);

import 'dart:convert';

FetchMyPlan fetchMyPlanFromJson(String str) => FetchMyPlan.fromJson(json.decode(str));

String fetchMyPlanToJson(FetchMyPlan data) => json.encode(data.toJson());

class FetchMyPlan {
  FetchMyPlan({
   required this.status,
    required this.message,
    required  this.data,
  });

  int status;
  String message;
  FetchPlan data;

  factory FetchMyPlan.fromJson(Map<String, dynamic> json) => FetchMyPlan(
    status: json["status"],
    message: json["message"],
    data: FetchPlan.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class FetchPlan {
  FetchPlan({
    required this.choosedPlanId,
    required this.planId,
    required this.email,
    required this.planStartDate,
    required this.planEndDate,
    required this.isActive,
    required this.addDate,
    required  this.planName,
    required  this.planType,
  });

  String choosedPlanId;
  String planId;
  String email;
  DateTime planStartDate;
  DateTime planEndDate;
  String isActive;
  DateTime addDate;
  String planName;
  String planType;

  factory FetchPlan.fromJson(Map<String, dynamic> json) => FetchPlan(
    choosedPlanId: json["choosedPlanId"],
    planId: json["planId"],
    email: json["email"],
    planStartDate: DateTime.parse(json["planStartDate"]),
    planEndDate: DateTime.parse(json["planEndDate"]),
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    planName: json["planName"],
    planType: json["planType"],
  );

  Map<String, dynamic> toJson() => {
    "choosedPlanId": choosedPlanId,
    "planId": planId,
    "email": email,
    "planStartDate": "${planStartDate.year.toString().padLeft(4, '0')}-${planStartDate.month.toString().padLeft(2, '0')}-${planStartDate.day.toString().padLeft(2, '0')}",
    "planEndDate": "${planEndDate.year.toString().padLeft(4, '0')}-${planEndDate.month.toString().padLeft(2, '0')}-${planEndDate.day.toString().padLeft(2, '0')}",
    "isActive": isActive,
    "addDate": addDate.toIso8601String(),
    "planName": planName,
    "planType": planType,
  };
}
