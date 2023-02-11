import '../../data/provider/feeds_provider.dart';
import 'package:http/http.dart' as http;
class FeedsRepository{
  final provider = FeedsProvider();

  Future<http.Response> sendFriendRequest(Map<String, Object> json,String token)async{
    Future<http.Response> response = provider.sendFriendRequest(json,token);
    return response;
  }

  Future<http.Response> searchUser(String keyword,String userID,String token)async{
    Future<http.Response> response = provider.searchUser(keyword,userID,token,);
    return response;
  }

  Future<http.Response> searchBusiness(String keyWord,String distance, String lat,String long,String token,String userId,)async{
    Future<http.Response> response = provider.searchBusiness(keyWord,distance,lat,long,token,userId);
    return response;
  }
  Future<http.Response> fetchFeedsPost(String userID,String token,String limit,String startFrom,String lat,String long)async{
    Future<http.Response> response = provider.fetchFeedsPosts(userID,token,limit,startFrom,lat,long);
    return response;
  }

  Future<http.Response> addLikeDislike(String userID,String token,String postId,String likeType)async{
    Future<http.Response> response = provider.addLikeDislike(userID,token,postId,likeType);
    return response;
  }

  Future<http.Response> addStoryComment(String userID,String token,String storyId,String message)async{
    Future<http.Response> response = provider.addStoryComment(userID,token,storyId,message);
    return response;
  }

  Future<http.Response> addPostComment(String userID,String token,String postId,String message)async{
    Future<http.Response> response = provider.addPostComment(userID,token,postId,message);
    return response;
  }

  Future<http.Response> fetchStory(String userID,String token)async{
    Future<http.Response> response = provider.fetchStory(userID,token);
    return response;
  }

  Future<http.Response> fetchMyStory(String userID,String token)async{
    Future<http.Response> response = provider.fetchMyStory(userID,token);
    return response;
  }

  Future<http.Response> fetchFeedsComment(String userID,String token,String postId)async{
    Future<http.Response> response = provider.fetchFeedsComment(userID,token,postId);
    return response;
  }

  Future<http.Response> deleteComment(String userID,String token,String commentId)async{
    Future<http.Response> response = provider.deletePostComment(userID,token,commentId);
    return response;
  }

  Future<http.Response> fetchSuggestedFriends(String userID,String token,String lat,String lng)async{
    Future<http.Response> response = provider.fetchSuggestedFriends(userID,token,lat,lng);
    return response;
  }

  Future<http.Response> callPostApi(Map<String ,dynamic> map,String url)async{
    Future<http.Response> response = provider.callPostApi(map,url);
    return response;
  }
}