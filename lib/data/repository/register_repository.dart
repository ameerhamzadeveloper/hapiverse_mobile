
import 'dart:io';

import '../../data/provider/register_provider.dart';
import 'package:http/http.dart';

class RegisterRepository{
  final provider = RegisterProvider();


  Future<Response> loginUser(Map<String, Object> json)async{
    Future<Response> response = provider.loginUser(json);
    return response;
  }
  Future<Response> createProfile(Map<String, String> json,File iamge)async{
    Future<Response> response = provider.createProfile(json,iamge);
    return response;
  }
  Future<Response> createBusinessProfile(Map<String, String> json,File iamge,File cover)async{
    Future<Response> response = provider.createBusinessProfile(json,iamge,cover);
    return response;
  }

   Future<Response> getInterests()async{
     Future<Response> response = provider.getCategory();
     return response;
   }
  Future<Response> addSubInterestCat(Map<String,dynamic> map)async{
    Future<Response> response = provider.addSubCatInterest(map);
    return response;
  }

  Future<Response> pushNotification(String userID,Map<String,dynamic> map,String token){
    Future<Response> response = provider.pushNotification(userID,map,token);
    return response;
  }


  Future<Response> fetchNotification(String userID,Map<String,dynamic> map,String token){
    Future<Response> response = provider.fetchNotifications(userID,map,token);
    return response;
  }
  Future<Response> addViewNotification(String userID,String notificationId,String token){
    Future<Response> response = provider.addViewNotification(userID,notificationId,token);
    return response;
  }

  Future<Response> verifyEmail(String email){
    Future<Response> response = provider.verifyEmail(email);
    return response;
  }

  Future<Response> addUserPlan(Map<String,dynamic> map){
    Future<Response> response = provider.addUserPlans(map);
    return response;
  }

  Future<Response> checkRefferalCode(String code){
    Future<Response> response = provider.checkReferalCode(code);
    return response;
  }

  Future<Response> checkAccountStatus(String userId,String token){
    Future<Response> response = provider.checkAccountStatus(userId,token);
    return response;
  }

  Future<Response> addRemovePrivateAccount(String userId,String token,bool isPrivate){
    Future<Response> response = provider.addRemvoePrivateAccount(userId,token,isPrivate);
    return response;
  }

  Future<Response> fetchMyPlan(String email){
    Future<Response> response = provider.fetchMyPlan(email);
    return response;
  }

  Future<Response> stripePayment(Map<String,dynamic> map){
    Future<Response> response = provider.stripePayment(map);
    return response;
  }

  Future<Response> callGetApi(String url){
    Future<Response> response = provider.callGetApi(url);
    return response;
  }

}