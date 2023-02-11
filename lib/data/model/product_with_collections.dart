// To parse this JSON data, do
//
//     final productsWithCollection = productsWithCollectionFromJson(jsonString);

import 'dart:convert';

ProductsWithCollectionModel productsWithCollectionFromJson(String str) => ProductsWithCollectionModel.fromJson(json.decode(str));

String productsWithCollectionToJson(ProductsWithCollectionModel data) => json.encode(data.toJson());

class ProductsWithCollectionModel {
  ProductsWithCollectionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<ProductWithCollection> data;

  factory ProductsWithCollectionModel.fromJson(Map<String, dynamic> json) => ProductsWithCollectionModel(
    status: json["status"],
    message: json["message"],
    data: List<ProductWithCollection>.from(json["data"].map((x) => ProductWithCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductWithCollection {
  ProductWithCollection({
    this.collectionId,
    this.businessId,
    this.collectionName,
    this.addDate,
    this.products,
  });

  String? collectionId;
  String? businessId;
  String? collectionName;
  DateTime? addDate;
  List<Product>? products;

  factory ProductWithCollection.fromJson(Map<String, dynamic> json) => ProductWithCollection(
    collectionId: json["collectionId"],
    businessId: json["businessId"],
    collectionName: json["collectionName"],
    addDate: DateTime.parse(json["addDate"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "collectionId": collectionId,
    "businessId": businessId,
    "collectionName": collectionName,
    "addDate": addDate!.toIso8601String(),
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.collectionId,
    this.businessId,
    this.productId,
    this.productName,
    this.productPrice,
    this.productdescription,
    this.addDate,
    this.images,
  });

  String? collectionId;
  String? businessId;
  String? productId;
  String? productName;
  String? productPrice;
  String? productdescription;
  DateTime? addDate;
  List<Image>? images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    collectionId: json["collectionId"],
    businessId: json["businessId"],
    productId: json["productId"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    productdescription: json["productdescription"],
    addDate: DateTime.parse(json["addDate"]),
    images: List<Image>.from(json["Images"].map((x) => Image.fromJson(x))),
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
