// To parse this JSON data, do
//
//     final userInterestModelProfile = userInterestModelProfileFromJson(jsonString);

import 'dart:convert';

UserInterestModelProfile userInterestModelProfileFromJson(String str) => UserInterestModelProfile.fromJson(json.decode(str));

String userInterestModelProfileToJson(UserInterestModelProfile data) => json.encode(data.toJson());

class UserInterestModelProfile {
  UserInterestModelProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<UserInterestProfile> data;

  factory UserInterestModelProfile.fromJson(Map<String, dynamic> json) => UserInterestModelProfile(
    status: json["status"],
    message: json["message"],
    data: List<UserInterestProfile>.from(json["data"].map((x) => UserInterestProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserInterestProfile {
  UserInterestProfile({
    required this.interestSubCategoryId,
    required this.interestCategoryId,
    required this.interestSubCategoryTitle,
    required this.isActive,
    required this.addDate,
    this.editDate,
    required this.isSelected
  });

  String interestSubCategoryId;
  String interestCategoryId;
  String interestSubCategoryTitle;
  String isActive;
  bool isSelected;
  DateTime addDate;
  dynamic editDate;

  factory UserInterestProfile.fromJson(Map<String, dynamic> json) => UserInterestProfile(
    interestSubCategoryId: json["interestSubCategoryId"],
    interestCategoryId: json["interestCategoryId"] ?? "",
    interestSubCategoryTitle: json["interestSubCategoryTitle"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    isSelected: true,
  );

  Map<String, dynamic> toJson() => {
    "interestSubCategoryId": interestSubCategoryId,
    "interestCategoryId": interestCategoryId,
    "interestSubCategoryTitle": interestSubCategoryTitle,
    "isActive": isActive,
    "addDate": addDate.toIso8601String(),
    "editDate": editDate,
  };
}
