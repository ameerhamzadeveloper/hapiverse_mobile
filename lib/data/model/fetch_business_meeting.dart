// To parse this JSON data, do
//
//     final fetchBusinesRatingModel = fetchBusinesRatingModelFromJson(jsonString);

import 'dart:convert';

FetchBusinesRatingModel fetchBusinesRatingModelFromJson(String str) => FetchBusinesRatingModel.fromJson(json.decode(str));

String fetchBusinesRatingModelToJson(FetchBusinesRatingModel data) => json.encode(data.toJson());

class FetchBusinesRatingModel {
  FetchBusinesRatingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  BusinessRating data;

  factory FetchBusinesRatingModel.fromJson(Map<String, dynamic> json) => FetchBusinesRatingModel(
    status: json["status"],
    message: json["message"],
    data: BusinessRating.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class BusinessRating {
  BusinessRating({
    this.avergeRating,
    this.totalRating,
    this.reviews,
  });

  double? avergeRating;
  int? totalRating;
  List<Review>? reviews;

  factory BusinessRating.fromJson(Map<String, dynamic> json) => BusinessRating(
    avergeRating: double.parse(json["avergeRating"].toString()),
    totalRating: json["totalRating"],
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "avergeRating": avergeRating,
    "totalRating": totalRating,
    "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
  };
}

class Review {
  Review({
    this.ratingId,
    this.userId,
    this.businessId,
    this.rating,
    this.comment,
    this.isActive,
    this.addDate,
    this.userName,
    this.profileImageUrl,
  });

  String? ratingId;
  String? userId;
  String? businessId;
  String? rating;
  String? comment;
  String? isActive;
  DateTime? addDate;
  String? userName;
  String? profileImageUrl;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    ratingId: json["ratingId"],
    userId: json["userId"],
    businessId: json["businessId"],
    rating: json["rating"],
    comment: json["comment"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "ratingId": ratingId,
    "userId": userId,
    "businessId": businessId,
    "rating": rating,
    "comment": comment,
    "isActive": isActive,
    "addDate": addDate!.toIso8601String(),
    "userName": userName,
    "profileImageUrl": profileImageUrl,
  };
}
