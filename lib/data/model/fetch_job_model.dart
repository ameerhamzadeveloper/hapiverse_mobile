// To parse this JSON data, do
//
//     final fetchJobsModel = fetchJobsModelFromJson(jsonString);

import 'dart:convert';

FetchJobsModel fetchJobsModelFromJson(String str) => FetchJobsModel.fromJson(json.decode(str));

String fetchJobsModelToJson(FetchJobsModel data) => json.encode(data.toJson());

class FetchJobsModel {
  FetchJobsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Job> data;

  factory FetchJobsModel.fromJson(Map<String, dynamic> json) => FetchJobsModel(
    status: json["status"],
    message: json["message"],
    data: List<Job>.from(json["data"].map((x) => Job.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Job {
  Job({
    required this.jobId,
    required this.businessId,
    required this.jobTitle,
    required this.companyName,
    required this.workplaceType,
    required this.jobLocation,
    required this.jobType,
    required this.jobDescription,
    required this.addDate,
    required this.businessName,
    required this.email,
    required this.ownerName,
    required this.vatNumber,
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.businessContact,
    required this.isAlwaysOpen,
    required this.categoryId,
    required this.businessType,
    required this.logoImageUrl,
    required this.featureImageUrl,
    required this.totalPosts,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.isStealth,
    required this.stealthTime,
    this.stealthDuration,
    required this.isActive,
    required this.editDate,
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
  String businessName;
  String email;
  String ownerName;
  String vatNumber;
  String address;
  String city;
  String country;
  String latitude;
  String longitude;
  String businessContact;
  String isAlwaysOpen;
  String categoryId;
  String businessType;
  String logoImageUrl;
  String featureImageUrl;
  String totalPosts;
  String totalFollowers;
  String totalFollowing;
  String isStealth;
  DateTime stealthTime;
  dynamic stealthDuration;
  String isActive;
  String editDate;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    jobId: json["jobId"],
    businessId: json["businessId"],
    jobTitle: json["jobTitle"],
    companyName: json["companyName"],
    workplaceType: json["workplaceType"],
    jobLocation: json["jobLocation"] ?? "",
    jobType: json["jobType"],
    jobDescription: json["jobDescription"],
    addDate: DateTime.parse(json["addDate"]),
    businessName: json["businessName"] ?? "",
    email: json["email"] ?? "",
    ownerName: json["ownerName"] ?? "",
    vatNumber: json["vatNumber"] ?? "",
    address: json["address"] ?? "",
    city: json["city"] ?? "",
    country: json["country"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    businessContact: json["businessContact"] ?? "",
    isAlwaysOpen: json["isAlwaysOpen"] ?? "",
    categoryId: json["categoryId"] ?? "",
    businessType: json["businessType"] ?? "",
    logoImageUrl: json["logoImageUrl"],
    featureImageUrl: json["featureImageUrl"],
    totalPosts: json["totalPosts"],
    totalFollowers: json["totalFollowers"],
    totalFollowing: json["totalFollowing"],
    isStealth: json["isStealth"],
    stealthTime: DateTime.parse(json["stealthTime"]),
    stealthDuration: json["stealthDuration"],
    isActive: json["isActive"],
    editDate: json["editDate"],
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
    "businessName": businessName,
    "email": email,
    "ownerName": ownerName,
    "vatNumber": vatNumber,
    "address": address,
    "city": city,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "businessContact": businessContact,
    "isAlwaysOpen": isAlwaysOpen,
    "categoryId": categoryId,
    "businessType": businessType,
    "logoImageUrl": logoImageUrl,
    "featureImageUrl": featureImageUrl,
    "totalPosts": totalPosts,
    "totalFollowers": totalFollowers,
    "totalFollowing": totalFollowing,
    "isStealth": isStealth,
    "stealthTime": stealthTime.toIso8601String(),
    "stealthDuration": stealthDuration,
    "isActive": isActive,
    "editDate": editDate,
  };
}
