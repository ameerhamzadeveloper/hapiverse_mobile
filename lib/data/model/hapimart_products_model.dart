// To parse this JSON data, do
//
//     final hapimartProductsModel = hapimartProductsModelFromJson(jsonString);

import 'dart:convert';

HapimartProductsModel hapimartProductsModelFromJson(String str) => HapimartProductsModel.fromJson(json.decode(str));

String hapimartProductsModelToJson(HapimartProductsModel data) => json.encode(data.toJson());

class HapimartProductsModel {
  HapimartProductsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<HapimartProduct> data;

  factory HapimartProductsModel.fromJson(Map<String, dynamic> json) => HapimartProductsModel(
    status: json["status"],
    message: json["message"],
    data: List<HapimartProduct>.from(json["data"].map((x) => HapimartProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class HapimartProduct {
  HapimartProduct({
    required this.productId,
    this.collectionId,
    required this.businessId,
    required this.productName,
    required this.productPrice,
    this.discouintedPrice,
    required this.isDiscountActive,
    required this.productdescription,
    required this.addDate,
    required this.images,
  });

  String productId;
  String? collectionId;
  String businessId;
  String productName;
  String productPrice;
  dynamic discouintedPrice;
  String isDiscountActive;
  String productdescription;
  DateTime addDate;
  List<Image> images;

  factory HapimartProduct.fromJson(Map<String, dynamic> json) => HapimartProduct(
    productId: json["productId"],
    collectionId: json["collectionId"],
    businessId: json["businessId"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    discouintedPrice: json["discouintedPrice"],
    isDiscountActive: json["isDiscountActive"],
    productdescription: json["productdescription"],
    addDate: DateTime.parse(json["addDate"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "collectionId": collectionId,
    "businessId": businessId,
    "productName": productName,
    "productPrice": productPrice,
    "discouintedPrice": discouintedPrice,
    "isDiscountActive": isDiscountActive,
    "productdescription": productdescription,
    "addDate": addDate.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.imageId,
    required this.productId,
    required this.imageUrl,
  });

  String imageId;
  String productId;
  String imageUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imageId: json["imageId"],
    productId: json["productId"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "productId": productId,
    "imageUrl": imageUrl,
  };
}
