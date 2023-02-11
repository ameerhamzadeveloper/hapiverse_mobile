// To parse this JSON data, do
//
//     final fetchMyJobs = fetchMyJobsFromJson(jsonString);

import 'dart:convert';

FetchMyJobs fetchMyJobsFromJson(String str) => FetchMyJobs.fromJson(json.decode(str));

String fetchMyJobsToJson(FetchMyJobs data) => json.encode(data.toJson());

class FetchMyJobs {
  FetchMyJobs({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<MyJob> data;

  factory FetchMyJobs.fromJson(Map<String, dynamic> json) => FetchMyJobs(
    status: json["status"],
    message: json["message"],
    data: List<MyJob>.from(json["data"].map((x) => MyJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MyJob {
  MyJob({
    required this.jobId,
    required this.businessId,
    required this.jobTitle,
    required this.companyName,
    required this.workplaceType,
    required this.jobLocation,
    required this.jobType,
    required this.jobDescription,
    required this.addDate,
  });

  String jobId;
  String businessId;
  String jobTitle;
  String companyName;
  String workplaceType;
  String jobLocation;
  String jobType;
  String jobDescription;
  DateTime addDate;

  factory MyJob.fromJson(Map<String, dynamic> json) => MyJob(
    jobId: json["jobId"],
    businessId: json["businessId"],
    jobTitle: json["jobTitle"],
    companyName: json["companyName"],
    workplaceType: json["workplaceType"],
    jobLocation: json["jobLocation"],
    jobType: json["jobType"],
    jobDescription: json["jobDescription"],
    addDate: DateTime.parse(json["addDate"]),
  );

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "businessId": businessId,
    "jobTitle": jobTitle,
    "companyName": companyName,
    "workplaceType": workplaceType,
    "jobLocation": jobLocation,
    "jobType": jobType,
    "jobDescription": jobDescription,
    "addDate": addDate.toIso8601String(),
  };
}
