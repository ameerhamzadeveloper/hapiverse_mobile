// To parse this JSON data, do
//
//     final businessOrdersModel = businessOrdersModelFromJson(jsonString);

import 'dart:convert';

BusinessOrdersModel businessOrdersModelFromJson(String str) => BusinessOrdersModel.fromJson(json.decode(str));

String businessOrdersModelToJson(BusinessOrdersModel data) => json.encode(data.toJson());

class BusinessOrdersModel {
  BusinessOrdersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<BusinessOrder> data;

  factory BusinessOrdersModel.fromJson(Map<String, dynamic> json) => BusinessOrdersModel(
    status: json["status"],
    message: json["message"],
    data: List<BusinessOrder>.from(json["data"].map((x) => BusinessOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BusinessOrder {
  BusinessOrder({
    this.orderId,
    this.orderNo,
    this.productId,
    this.businessId,
    this.userId,
    this.orderCost,
    this.shippingCost,
    this.shippingAddress,
    this.totalAmount,
    this.orderStatus,
    this.activeDate,
    this.shippingDate,
    this.deleiveredDate,
    this.shippingBy,
    this.businessName,
    this.addDate,
    this.productName,
    this.productPrice,
    this.productdescription,
    this.images,
    this.customerName,
    this.customerProfileUrl
  });

  String? orderId;
  String? orderNo;
  String? productId;
  String? businessId;
  String? userId;
  String? orderCost;
  String? shippingCost;
  String? shippingAddress;
  String? totalAmount;
  String? orderStatus;
  dynamic? activeDate;
  dynamic? shippingDate;
  String? deleiveredDate;
  dynamic shippingBy;
  String? businessName;
  DateTime? addDate;
  String? productName;
  String? productPrice;
  String? productdescription;
  String? customerName;
  String? customerProfileUrl;
  List<Image>? images;

  factory BusinessOrder.fromJson(Map<String, dynamic> json) => BusinessOrder(
    orderId: json["orderId"],
    orderNo: json["orderNo"],
    productId: json["productId"],
    businessId: json["businessId"],
    userId: json["userId"],
    orderCost: json["orderCost"],
    shippingCost: json["shippingCost"],
    shippingAddress: json["shippingAddress"],
    totalAmount: json["totalAmount"],
    orderStatus: json["orderStatus"],
    activeDate: json["activeDate"],
    shippingDate: json["shippingDate"],
    deleiveredDate: json["deleiveredDate"],
    shippingBy: json["shippingBy"],
    businessName: json["businessName"],
    addDate: DateTime.parse(json["addDate"]),
    productName: json["productName"],
    productPrice: json["productPrice"],
    productdescription: json["productdescription"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    customerName: json["userName"],
    customerProfileUrl: json["userProfileUrl"]
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderNo": orderNo,
    "productId": productId,
    "businessId": businessId,
    "userId": userId,
    "orderCost": orderCost,
    "shippingCost": shippingCost,
    "shippingAddress": shippingAddress,
    "totalAmount": totalAmount,
    "orderStatus": orderStatus,
    "activeDate": activeDate,
    "shippingDate": shippingDate,
    "deleiveredDate": deleiveredDate,
    "shippingBy": shippingBy,
    "businessName": businessName,
    "addDate": addDate!.toIso8601String(),
    "productName": productName,
    "productPrice": productPrice,
    "productdescription": productdescription,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
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
