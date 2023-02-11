// To parse this JSON data, do
//
//     final userOrdersModel = userOrdersModelFromJson(jsonString);

import 'dart:convert';

UserOrdersModel userOrdersModelFromJson(String str) => UserOrdersModel.fromJson(json.decode(str));

String userOrdersModelToJson(UserOrdersModel data) => json.encode(data.toJson());

class UserOrdersModel {
  UserOrdersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<UserOrder> data;

  factory UserOrdersModel.fromJson(Map<String, dynamic> json) => UserOrdersModel(
    status: json["status"],
    message: json["message"],
    data: List<UserOrder>.from(json["data"].map((x) => UserOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserOrder {
  UserOrder({
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
  dynamic activeDate;
  dynamic shippingDate;
  String? deleiveredDate;
  dynamic shippingBy;
  String? businessName;
  DateTime? addDate;
  String? productName;
  String? productPrice;
  String? productdescription;
  List<Image>? images;

  factory UserOrder.fromJson(Map<String, dynamic> json) => UserOrder(
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
