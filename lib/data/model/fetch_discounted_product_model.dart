// To parse this JSON data, do
//
//     final fetchDiscountedProductsModel = fetchDiscountedProductsModelFromJson(jsonString);

import 'dart:convert';

FetchDiscountedProductsModel fetchDiscountedProductsModelFromJson(String str) => FetchDiscountedProductsModel.fromJson(json.decode(str));

String fetchDiscountedProductsModelToJson(FetchDiscountedProductsModel data) => json.encode(data.toJson());

class FetchDiscountedProductsModel {
  FetchDiscountedProductsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<DiscountedProducts> data;

  factory FetchDiscountedProductsModel.fromJson(Map<String, dynamic> json) => FetchDiscountedProductsModel(
    status: json["status"],
    message: json["message"],
    data: List<DiscountedProducts>.from(json["data"].map((x) => DiscountedProducts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DiscountedProducts {
  DiscountedProducts({
    this.collectionId,
    this.businessId,
    this.productId,
    this.productName,
    this.productPrice,
    this.discouintedPrice,
    this.isDiscountActive,
    this.productdescription,
    this.addDate,
    this.images,
  });

  String? collectionId;
  String? businessId;
  String? productId;
  String? productName;
  String? productPrice;
  String? discouintedPrice;
  String? isDiscountActive;
  String? productdescription;
  DateTime? addDate;
  List<Image>? images;

  factory DiscountedProducts.fromJson(Map<String, dynamic> json) => DiscountedProducts(
    collectionId: json["collectionId"],
    businessId: json["businessId"],
    productId: json["productId"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    discouintedPrice: json["discouintedPrice"],
    isDiscountActive: json["isDiscountActive"],
    productdescription: json["productdescription"],
    addDate: DateTime.parse(json["addDate"]),
    images: List<Image>.from(json["Images"]!.map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "collectionId": collectionId,
    "businessId": businessId,
    "productId": productId,
    "productName": productName,
    "productPrice": productPrice,
    "discouintedPrice": discouintedPrice,
    "isDiscountActive": isDiscountActive,
    "productdescription": productdescription,
    "addDate": addDate!.toIso8601String(),
    "Images": List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    this.imageId,
    this.productId,
    this.imageUrl,
  });

  String? imageId;
  String? productId;
  String? imageUrl;

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
