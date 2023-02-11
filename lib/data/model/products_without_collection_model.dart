// To parse this JSON data, do
//
//     final productsWithoutCollectionModel = productsWithoutCollectionModelFromJson(jsonString);

import 'dart:convert';

ProductsWithoutCollectionModel productsWithoutCollectionModelFromJson(String str) => ProductsWithoutCollectionModel.fromJson(json.decode(str));

String productsWithoutCollectionModelToJson(ProductsWithoutCollectionModel data) => json.encode(data.toJson());

class ProductsWithoutCollectionModel {
  ProductsWithoutCollectionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<ProductWithoutCollection> data;

  factory ProductsWithoutCollectionModel.fromJson(Map<String, dynamic> json) => ProductsWithoutCollectionModel(
    status: json["status"],
    message: json["message"],
    data: List<ProductWithoutCollection>.from(json["data"].map((x) => ProductWithoutCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductWithoutCollection {
  ProductWithoutCollection({
    this.collectionId,
    this.businessId,
    this.productId,
    this.productName,
    this.productPrice,
    this.productdescription,
    this.addDate,
    this.images,
    required this.isSelected,
    this.isDiscountActive,
    this.discouintedPrice
  });

  dynamic collectionId;
  String? businessId;
  String? productId;
  String? productName;
  String? productPrice;
  String? productdescription;
  DateTime? addDate;
  List<Image>? images;
  bool isSelected;
  String? isDiscountActive;
  String? discouintedPrice;

  factory ProductWithoutCollection.fromJson(Map<String, dynamic> json) => ProductWithoutCollection(
    collectionId: json["collectionId"],
    businessId: json["businessId"],
    productId: json["productId"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    productdescription: json["productdescription"],
    addDate: DateTime.parse(json["addDate"]),
    images: List<Image>.from(json["Images"].map((x) => Image.fromJson(x))),
    isSelected: false,
    isDiscountActive: json["isDiscountActive"],
    discouintedPrice: json['discouintedPrice']
  );

  Map<String, dynamic> toJson() => {
    "collectionId": collectionId,
    "businessId": businessId,
    "productId": productId,
    "productName": productName,
    "productPrice": productPrice,
    "productdescription": productdescription,
    "addDate": addDate!.toIso8601String(),
    "Images": List<dynamic>.from(images!.map((x) => x.toJson())),
    'isDiscountActive': isDiscountActive,
    'discouintedPrice':discouintedPrice
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
