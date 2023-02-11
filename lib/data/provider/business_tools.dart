import 'dart:io';

import 'package:happiverse/utils/user_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/business_url.dart';

class BusinessToolsProvider{


  Future<http.Response> addProducts(Map<String,dynamic> body,String accesToken,String userId,List<File> images)async{
    var request =  http.MultipartRequest('POST',Uri.parse(addProductsUrl));
    request.fields['businessId'] = body['businessId'];
    request.fields['productName'] = body['productName'];
    request.fields['productPrice'] = body['productPrice'];
    request.fields['productdescription'] = body['productdescription'];
    request.fields['isDiscountActive'] = 0.toString();
    request.headers['userId'] = userId;
    request.headers['token'] = accesToken;
    for(var i = 0; i < images.length;i++){
      var imagee = await http.MultipartFile.fromPath('imageUrl[]', images[i].path);
      request.files.add(imagee);
    }
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> fetchProductsWithoutCollection(
      String userId, String accessToken,{String? otherId}) async {
    Uri url = Uri.parse(fetchAllProductsWithoutCollectionUrl);
    http.Response response = await http.post(url, body: {
      'businessId': otherId ?? userId,
    }, headers: {
      'userId': userId,
      'token': accessToken,
    });
    return response;
  }

  Future<http.Response> addCollection(
      String userId, String accessToken,Map<String,dynamic> body) async {
    Uri url = Uri.parse(addCollectionUrl);
    http.Response response = await http.post(url, body:
      body,
      headers: {
      'userId': userId,
      'token': accessToken,
    });
    return response;
  }

  Future<http.Response> fetchProductWithCollection(
      String userId, String accessToken,{String? otherId}) async {
    print(userId);
    print(accessToken);
    Map<String,dynamic> boddy = {
      'businessId':otherId == null ? userId:otherId,
    };
    Uri url = Uri.parse(fetchProductWithCollectionUrl);
    http.Response response = await http.post(url, body:boddy,
        headers: {
          'userId': userId,
          'token': accessToken,
        });
    print(boddy);
    return response;
  }

  Future<http.Response> addEvent(Map<String,dynamic> body,String accesToken,String userId,List<File> images)async{
    var request =  http.MultipartRequest('POST',Uri.parse(addEventURL));
    request.fields['businessId'] = body['businessId'];
    request.fields['eventName'] = body['eventName'];
    request.fields['eventTime'] = body['eventTime'];
    request.fields['eventDescription'] = body['eventDescription'];
    request.fields['eventDate'] = body['eventDate'];
    request.fields['latitude'] = body['latitude'];
    request.fields['longitude'] = body['longitude'];
    request.fields['address'] = body['address'];
    request.headers['userId'] = userId;
    request.headers['token'] = accesToken;
    for(var i = 0; i < images.length;i++){
      var imagee = await http.MultipartFile.fromPath('imageUrl[]', images[i].path);
      request.files.add(imagee);
    }
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> fetchEvent(
      String userId, String accessToken,{String? otherId}) async {
    Uri url = Uri.parse(fetchEventURL);
    http.Response response = await http.post(url, body:
    {
      'businessId': otherId ?? userId
    },
        headers: {
          'userId': userId,
          'token': accessToken,
        });
    return response;
  }

  Future<http.Response> deleteEvent(
      String userId, String accessToken,String eventId) async {
    Uri url = Uri.parse(deleteEventUrl);
    http.Response response = await http.post(url, body:
    {
      'businessId':userId,
      'eventId':eventId
    },
        headers: {
          'userId': userId,
          'token': accessToken,
        });
    return response;
  }

  Future<http.Response> fetchDiscountedProducts(
      String userId, String accessToken) async {
    Uri url = Uri.parse(fetchDiscountedProductUrl);
    http.Response response = await http.post(url, body:
    {
      'businessId':userId,
    },
        headers: {
          'userId': userId,
          'token': accessToken,
        });
    return response;
  }

  Future<http.Response> addProductDiscount(
      String userId, String accessToken,String productId,String discountedPrice,String discountActive) async {
    Uri url = Uri.parse(editProductUrl);
    print("sfds $discountActive");
    http.Response response = await http.post(url, body:
    {
      'businessId':userId,
      'productId':productId,
      'discouintedPrice': discountedPrice,
      'isDiscountActive': discountActive,
    },
        headers: {
          'userId': userId,
          'token': accessToken,
        });
    return response;
  }

  Future<http.Response> addBusinessRating(
      String userId, String accessToken,String rating,String comment,String raterId) async {
    Uri url = Uri.parse(addBusinessRatingUrl);
    http.Response response = await http.post(url, body:
    {
      'businessId':raterId,
      'rating':rating,
      'comment': comment,
      'userId': userId,
    },
        headers: {
          'userId': userId,
          'token': accessToken,
        });
    return response;
  }

  Future<http.Response> generateRefferalCode(
     Map<String,dynamic> map) async {
    Uri url = Uri.parse(generateReffCodeUrl);
    http.Response response = await http.post(url, body:
    {
      'businessId':map['userId'],
      'planId': map['planId'],
      'accountType': map['accountType'],
      'refferalCode': map['refferalCode'],
    },
        headers: {
          'userId': map['userId'],
          'token': map['token'],
        });
    return response;
  }

  Future<http.Response> addOrder(
      Map<String,dynamic> map) async {
    Uri url = Uri.parse(addOrderUrl);
    http.Response response = await http.post(url, body:
    map,
        headers: {
          'userId': map['userId'],
          'token': map['token'],
        });
    return response;
  }

  Future<http.Response> fetchMyOrderBusiness(String userID,String token)async{
    String uri = fetchMyOrderBusinessUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'businessId': userID,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> shipOrder(String userID,String token,String shipBy,String shipFee,String orderID)async{
    String uri = shipOrderUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'orderId': orderID,
          'orderStatus': '1',
          'shippingBy': shipBy,
          'shippingCost': shipFee,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> createAds(Map<String,dynamic> map,String token)async{
    String uri = createAdsUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: map,
        headers: {
          'token': token,
          'userId': map['businessId'],
        }
    );
    return res;
  }

  Future<http.Response> callPostApi(Map<String,dynamic> map,String url)async{
    http.Response res = await http.post(
        Uri.parse(url),
        body: map,
        headers: {
          'Authorization': "Bearer ${map['token']}",
        }
    );
    return res;
  }

  Future<http.Response> callGetApi(Map<String,dynamic> map,String url)async{
    http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': "Bearer ${map['token']}",
        }
    );
    return res;
  }


  Future<http.Response> callDeleteApi(Map<String,dynamic> map,String url)async{
    http.Response res = await http.delete(
        Uri.parse(url),
        body: map,
        headers: {
          'Authorization': "Bearer ${map['token']}",
        }
    );
    return res;
  }

  Future<http.Response> callPostApiCI(Map<String,dynamic> map,String url)async{
    http.Response res = await http.post(
        Uri.parse(url),
        body: map,
        headers: {
          'userId': map['userId'],
          'token': map['token'],
        }
    );
    return res;
  }

}