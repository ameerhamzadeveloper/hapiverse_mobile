
// To parse this JSON data, do
//
//     final searchGroupModel = searchGroupModelFromJson(jsonString);

import 'dart:convert';

SearchGroupModel searchGroupModelFromJson(String str) => SearchGroupModel.fromJson(json.decode(str));

String searchGroupModelToJson(SearchGroupModel data) => json.encode(data.toJson());

class SearchGroupModel {
  SearchGroupModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<GroupSearch> data;

  factory SearchGroupModel.fromJson(Map<String, dynamic> json) => SearchGroupModel(
    status: json["status"],
    message: json["message"],
    data: List<GroupSearch>.from(json["data"].map((x) => GroupSearch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GroupSearch {
  GroupSearch({
    this.groupId,
    this.groupAdminId,
    this.groupName,
    this.groupImageUrl,
    this.groupDescription,
    this.groupPrivacy,
    this.addDate,
    this.alreadyMember,
  });

  String? groupId;
  String? groupAdminId;
  String? groupName;
  String? groupImageUrl;
  String? groupDescription;
  String? groupPrivacy;
  DateTime? addDate;
  bool? alreadyMember;

  factory GroupSearch.fromJson(Map<String, dynamic> json) => GroupSearch(
    groupId: json["groupId"],
    groupAdminId: json["groupAdminId"],
    groupName: json["groupName"],
    groupImageUrl: json["groupImageUrl"],
    groupDescription: json["groupDescription"] == null ? null : json["groupDescription"],
    groupPrivacy: json['groupPrivacy'],
    addDate: DateTime.parse(json["addDate"]),
    alreadyMember: json["alreadyMember"],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupAdminId": groupAdminId,
    "groupName": groupName,
    "groupImageUrl": groupImageUrl,
    "groupDescription": groupDescription == null ? null : groupDescription,
    "groupPrivacy": groupPrivacyValues.reverse[groupPrivacy],
    "addDate": addDate!.toIso8601String(),
    "alreadyMember": alreadyMember,
  };
}

enum GroupPrivacy { PUBLIC, PRIVATE, }

final groupPrivacyValues = EnumValues({
  "private": GroupPrivacy.PRIVATE,
  "Public": GroupPrivacy.PUBLIC
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
