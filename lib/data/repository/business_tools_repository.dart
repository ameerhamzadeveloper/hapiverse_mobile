import 'dart:io';
import '../../data/provider/business_tools.dart';
import 'package:http/http.dart' as http;
class BusinessToolsRepository{

  final provider = BusinessToolsProvider();

  Future<http.Response> addProducts(Map<String,dynamic> body,String token,String id,List<File> images)async{
    Future<http.Response> response = provider.addProducts(body,token,id,images);
    return response;
  }

  Future<http.Response> fetchProductsWithoutCollections(String token,String id,{String? otherId})async{
    Future<http.Response> response = provider.fetchProductsWithoutCollection(id,token,otherId: otherId);
    return response;
  }

  Future<http.Response> addCollection(String token,String id,Map<String,dynamic> bdy)async{
    Future<http.Response> response = provider.addCollection(id,token,bdy);
    return response;
  }

  Future<http.Response> fetchProductWithCollection(String token,String id,{String? otherId})async{
    Future<http.Response> response = provider.fetchProductWithCollection(id,token,otherId: otherId);
    return response;
  }

  Future<http.Response> addEvent(Map<String,dynamic> body,String token,String id,List<File> images)async{
    Future<http.Response> response = provider.addEvent(body,token,id,images);
    return response;
  }

  Future<http.Response> fetchEvent(String token,String id,{String? otherID})async{
    Future<http.Response> response = provider.fetchEvent(id,token,otherId: otherID);
    return response;
  }
  Future<http.Response> deleteEvent(String token,String id,String eventId)async{
    Future<http.Response> response = provider.deleteEvent(id,token,eventId);
    return response;
  }

  Future<http.Response> fetchDiscountedProducts(String token,String id)async{
    Future<http.Response> response = provider.fetchDiscountedProducts(id,token);
    return response;
  }

  Future<http.Response> addProductDiscount(String token,String id,String productId,String discountPrice,String discountActive)async{
    Future<http.Response> response = provider.addProductDiscount(id,token,productId,discountPrice,discountActive);
    return response;
  }

  Future<http.Response> addBusinessRating(String token,String id,String rating,String comment,String raterId)async{
    Future<http.Response> response = provider.addBusinessRating(id,token,rating,comment,raterId);
    return response;
  }

  Future<http.Response> generateRefferalCode(Map<String,dynamic> map)async{
    Future<http.Response> response = provider.generateRefferalCode(map);
    return response;
  }

  Future<http.Response> addOrder(Map<String,dynamic> map)async{
    Future<http.Response> response = provider.addOrder(map);
    return response;
  }

  Future<http.Response> fetchMyOrdersBusiness(String userID,String token)async{
    Future<http.Response> response = provider.fetchMyOrderBusiness(userID,token);
    return response;
  }
  Future<http.Response> shipOrder(String userID,String token,String shipBy,String shipFee,String orderID)async{
    Future<http.Response> response = provider.shipOrder(userID,token,shipBy,shipFee,orderID);
    return response;
  }

  Future<http.Response> createAds(Map<String ,dynamic> map,String token)async{
    Future<http.Response> response = provider.createAds(map,token);
    return response;
  }

  Future<http.Response> callPostApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callPostApi(map,url);
    return response;
  }

  Future<http.Response> callGetApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callGetApi(map,url);
    return response;
  }

  Future<http.Response> callDeletApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callDeleteApi(map,url);
    return response;
  }

  Future<http.Response> callPostApiCI(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callPostApiCI(map,url);
    return response;
  }
}