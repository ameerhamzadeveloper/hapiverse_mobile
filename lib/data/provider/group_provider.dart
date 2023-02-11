import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../utils/user_url.dart';
import 'package:http/http.dart' as http;

class GroupProvider {
  Future<http.Response> createGroup(Map<String, dynamic> body,
      String accesToken, String userID, File? groupCover) async {
    var request =
        await http.MultipartRequest('POST', Uri.parse(createGroupUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['groupName'] = body['groupName'] ?? "";
    request.fields['groupPrivacy'] = body['groupPrivacy']!;
    var multipartFile =
        await http.MultipartFile.fromPath("groupImageUrl", groupCover!.path);
    request.files.add(multipartFile);
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response =
        await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> getGroups(String userId, String accessToken) async {
    Uri url = Uri.parse(getGroupUrl);
    http.Response response = await http.post(url, body: {
      'userId': userId
    }, headers: {
      'userId': userId,
      'token': accessToken,
    });
    return response;
  }

  Future<bool> addGropPost(Map<String, dynamic> map, String groupId) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('groupPosts');
    // final CollectionReference comRef = FirebaseFirestore.instance.collection('userPosts').doc(map['phone']).collection('comments');
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('Posts Pictures')
        .child('/${DateTime.now().toString()}')
        .putData(map['image']);
    var url = (await snapshot.ref.getDownloadURL()).toString();
    var userData = {
      'title': map['title'],
      'image_url': url,
      'like': 0,
      'share': 0,
      'comments': 0,
      'timestamp': DateTime.now(),
      'email': map['email'],
      'profileImage': map['profileImage'],
      'profileName': map['profileName'],
      'PostId': groupId
    };
    await ref.add(userData).then((value) {
      print("Posted");
    });
    return true;
  }

  Future<http.Response> fetchGroupInvite(
      String userId, String accessToken) async {
    Uri url = Uri.parse(fetchGroupInviteUrl);
    http.Response response = await http.post(url, body: {
      'userId': userId
    }, headers: {
      'userId': userId,
      'token': accessToken,
    });
    return response;
  }

  Future<http.Response> fetchFeedsPosts(
      String userId, String token, String groupId) async {
    String uri = fetchGroupPostsUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      'userId': userId,
      'groupId': groupId
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> addLikeDislike(
      String userId, String token, String postId) async {
    String uri = addLikeDislikeUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      'userId': userId,
      'postId': postId,
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> getFriendForGroupInvite(
      String userId, String token, String groupId) async {
    String uri = getFriendForGroupInviteUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      'userId': userId,
      'groupId': groupId
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> inviteToGroup(
      String userId, String targetId, String token, String groupId) async {
    print(userId);
    print(targetId);
    String uri = inviteToGroupUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      'userId': userId,
      'groupId': groupId,
      'inviterId': targetId,
    }, headers: {
      'token': token,
      'userId': targetId,
    });
    print("bady  ${res.body}----");
    return res;
  }

  Future<http.Response> leaveGroup(
      String userId, String token, String groupId) async {
    String uri = leaveGroupUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      'userId': userId,
      'groupId': groupId,
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> removeUserFromGroup(
      String userId, String targetId, String token, String groupId) async {
    String uri = leaveGroupUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      'userId': targetId,
      'groupId': groupId,
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> fetchAllGroupMembers(
      String userId, String token, String groupId) async {
    String uri = fetchAllGroupMembersUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      // 'userId':userId,
      'groupId': groupId,
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> fetchSingleGroup(
      String userId, String token, String groupId) async {
    String uri = fetchSingleGroupUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      // 'userId':userId,
      'groupId': groupId,
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> joinGroup(
      String userId, String token, String groupId, String inviterId) async {
    String uri = joinGroupUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      // 'userId':userId,
      "groupMemberId": userId,
      "addedById": inviterId,
      "groupId": groupId,
      "memberRole": 'Member',
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }

  Future<http.Response> searchGroup(
      String userId, String token, String query) async {
    String uri = searchGroupUrl;
    http.Response res = await http.post(Uri.parse(uri), body: {
      // 'userId':userId,
      "userId": userId,
      "keyword": query,
    }, headers: {
      'token': token,
      'userId': userId,
    });
    return res;
  }
}
