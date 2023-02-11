import 'dart:io';
import 'package:http/http.dart' as http;
import '../../data/provider/group_provider.dart';

class GroupRepository{
  final provider = GroupProvider();

  Future<http.Response> createGroup(Map<String, dynamic> map,String accesToken,String userID,File? groupCover){
    Future<http.Response> response = provider.createGroup(map,accesToken,userID,groupCover);
    return response;
  }

  Future<http.Response> getGroups(String accesToken,String userID){
    Future<http.Response> response = provider.getGroups(userID,accesToken,);
    return response;
  }

  addGropPost(Map<String,dynamic> map,String groupId){
    provider.addGropPost(map, groupId);
  }

  Future<http.Response> fetchGroupInvite(String accesToken,String userID){
    Future<http.Response> response = provider.fetchGroupInvite(userID,accesToken,);
    return response;
  }
  Future<http.Response> fetchFeedsPost(String userID,String token,String groupId)async{
    Future<http.Response> response = provider.fetchFeedsPosts(userID,token,groupId);
    return response;
  }

  Future<http.Response> addLikeDislike(String userID,String token,String postId,)async{
    Future<http.Response> response = provider.addLikeDislike(userID,token,postId);
    return response;
  }

  Future<http.Response> getFriendForGroupInvite(String userID,String token,String groupId)async{
    Future<http.Response> response = provider.getFriendForGroupInvite(userID,token,groupId);
    return response;
  }
  Future<http.Response> inviteToGroup(String userID,String token,String groupId,String targetId)async{
    Future<http.Response> response = provider.inviteToGroup(userID,targetId,token,groupId);
    return response;
  }

  Future<http.Response> removeUserFromGroup(String userID,String token,String groupId,String targetId)async{
    Future<http.Response> response = provider.removeUserFromGroup(userID,targetId,token,groupId);
    return response;
  }
  Future<http.Response> leaveGroup(String userID,String token,String groupId)async{
    Future<http.Response> response = provider.leaveGroup(userID,token,groupId);
    return response;
  }

  Future<http.Response> fetchAllGroupMembers(String userID,String token,String groupId)async{
    Future<http.Response> response = provider.fetchAllGroupMembers(userID,token,groupId);
    return response;
  }
  Future<http.Response> fetchSingleGroup(String userID,String token,String groupId)async{
    Future<http.Response> response = provider.fetchSingleGroup(userID,token,groupId);
    return response;
  }

  Future<http.Response> jonGroup(String userId,String token,String groupId,String inviterId)async{
    Future<http.Response> response = provider.joinGroup(userId,token,groupId,inviterId);
    return response;
  }

  Future<http.Response> searchGroups(String userId,String token,String query)async{
    Future<http.Response> response = provider.searchGroup(userId,token,query);
    return response;
  }
}