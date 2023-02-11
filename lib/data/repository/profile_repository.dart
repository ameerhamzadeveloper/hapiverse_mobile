import 'dart:io';

import '../../data/provider/profile_provider.dart';
import 'package:http/http.dart' as http;
class ProfileRepository{

  final provider = ProfileProvider();

  // <============= users side APIs ================>

  Future<http.Response> getProfile(String userID,String token)async{
    Future<http.Response> response = provider.getMyProfile(userID,token);
    return response;
  }

  Future<http.Response> getOtherProfile(String userID,String token,String myUserId)async{
    Future<http.Response> response = provider.getOtherProfile(myUserId,userID,token,);
    return response;
  }
  Future<http.Response> getOtherAllPorst(String userID,String token,String myUserId)async{
    Future<http.Response> response = provider.getOtherAllPosts(myUserId,userID,token,);
    return response;
  }

  Future<http.Response> addFollower(String followerId,String token,String myUserId)async{
    Future<http.Response> response = provider.addFollower(myUserId,followerId,token,);
    return response;
  }

  Future<http.Response> fetchMyPosts(String token,String myUserId)async{
    Future<http.Response> response = provider.fetchMyPosts(myUserId,token,);
    return response;
  }
  Future<http.Response> getFriendList(String userID,String token)async{
    Future<http.Response> response = provider.getFriendList(userID,token);
    return response;
  }

  Future<http.Response> editUserProfileImage(String userId,File image,String token,)async{
    Future<http.Response> response = provider.editProfileImage(userId,image,token);
    return response;
  }

  Future<http.Response> updateUserProfileInfo(Map<String,String> map,String userID,String token)async{
    Future<http.Response> response = provider.editProfileInfo(map,userID,token,);
    return response;
  }

  Future<http.Response> fetchMyFriend(String userID,String token)async{
    Future<http.Response> response = provider.getMyFriends(userID,token,);
    return response;
  }

  Future<http.Response> fetchOtherFriend(String userID,String token,String otherId)async{
    Future<http.Response> response = provider.fetchOtherFriend(userID,token,otherId);
    return response;
  }

  Future<http.Response> addCovidRecord(Map<String,dynamic>map,String userID,String token)async{
    Future<http.Response> response = provider.addCovidRecord(map,userID,token);
    return response;
  }

  Future<http.Response> fetchCovidRecord(String userID,String token)async{
    Future<http.Response> response = provider.fetchCovidRecord(userID,token);
    return response;
  }

  Future<http.Response> requestLocation(Map<String,dynamic>map)async{
    Future<http.Response> response = provider.requestLocation(map);
    return response;
  }

  Future<http.Response> getStealthStatus(String userID,String token,bool isBusiness)async{
    Future<http.Response> response = provider.getStealthStatus(userID,token,isBusiness);
    return response;
  }
  Future<http.Response> fetchLocationRequests(String userID,String token,String type)async{
    Future<http.Response> response = provider.fetchLocationRequests(userID,token, type);
    return response;
  }

  Future<http.Response> rejectLocationRequest(String userID,String token,String requestId)async{
    Future<http.Response> response = provider.rejectLocationRequest(userID,token, requestId);
    return response;
  }

  Future<http.Response> acceptLocationRequest(String userID,String token,Map<String,dynamic> map)async{
    Future<http.Response> response = provider.acceptLocationRequest(userID,token, map);
    return response;
  }
  Future<http.Response> deleteLocationRequest(String userID,String token,String requestId)async{
    Future<http.Response> response = provider.deleteLocationRequest(userID,token, requestId);
    return response;
  }
  Future<http.Response> addRemoveStealthStatus(String userID,String token,bool isRemove,bool isBusiness,String duration)async{
    Future<http.Response> response = provider.addRemoveStealthStatus(userID,token,isRemove,isBusiness,duration);
    return response;
  }

  Future<http.Response> addStealthMode(String userID,String token)async{
    Future<http.Response> response = provider.fetchCovidRecord(userID,token);
    return response;
  }

  Future<http.Response> fetchMyOrdersUser(String userID,String token)async{
    Future<http.Response> response = provider.fetchMyOrderUser(userID,token);
    return response;
  }


  Future<http.Response> fetchMusic()async{
    Future<http.Response> response = provider.fetchMusic();
    return response;
  }

  // <============== business APIs Start here ===============>


  Future<http.Response> fetchMyBusinessPRofile(String userID,String token)async{
    Future<http.Response> response = provider.fetchMyBusinessProfile(userID,token);
    return response;
  }

  Future<http.Response> fetchOtherBusinessProfile(String userID,String token,String otherId)async{
    Future<http.Response> response = provider.fetchOtherBusinessProfile(userID,token,otherId);
    return response;
  }

  Future<http.Response> fetchBusinessRating(String userID,String token,String bussID)async{
    Future<http.Response> response = provider.fetchBusinessRating(userID,token,bussID);
    return response;
  }

  Future<http.Response> callPostApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callPostApi(map,url);
    return response;
  }

  Future<http.Response> callPostApiCI(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callPostApiCI(map,url);
    return response;
  }

  Future<http.Response> callGetApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callGetApi(map,url);
    return response;
  }
  Future<http.Response> callGetApiCi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callGetApiCi(map,url);
    return response;
  }
  Future<http.Response> callDeletApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callDeleteApi(map,url);
    return response;
  }


}