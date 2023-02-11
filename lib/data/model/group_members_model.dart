// To parse this JSON data, do
//
//     final groupMembersModel = groupMembersModelFromJson(jsonString);

import 'dart:convert';

GroupMembersModel groupMembersModelFromJson(String str) => GroupMembersModel.fromJson(json.decode(str));

String groupMembersModelToJson(GroupMembersModel data) => json.encode(data.toJson());

class GroupMembersModel {
  GroupMembersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<GroupMembers> data;

  factory GroupMembersModel.fromJson(Map<String, dynamic> json) => GroupMembersModel(
    status: json["status"],
    message: json["message"],
    data: List<GroupMembers>.from(json["data"].map((x) => GroupMembers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GroupMembers {
  GroupMembers({
    this.trngroupId,
    this.groupMemberId,
    this.groupId,
    this.addedById,
    this.memberRole,
    this.memberStatus,
    this.addDate,
    this.editDate,
    this.userName,
    this.profileImageUrl,
  });

  String? trngroupId;
  String? groupMemberId;
  String? groupId;
  dynamic addedById;
  String? memberRole;
  String? memberStatus;
  DateTime? addDate;
  dynamic editDate;
  String? userName;
  String? profileImageUrl;

  factory GroupMembers.fromJson(Map<String, dynamic> json) => GroupMembers(
    trngroupId: json["trngroupId"],
    groupMemberId: json["groupMemberId"],
    groupId: json["groupId"],
    addedById: json["addedById"],
    memberRole: json["memberRole"],
    memberStatus: json["memberStatus"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "trngroupId": trngroupId,
    "groupMemberId": groupMemberId,
    "groupId": groupId,
    "addedById": addedById,
    "memberRole": memberRole,
    "memberStatus": memberStatus,
    "addDate": addDate!.toIso8601String(),
    "editDate": editDate,
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}
