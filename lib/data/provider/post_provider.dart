import 'dart:io';
import '../../utils/user_url.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class PostProvider {
  Future<http.Response> getNearbyPlaces(double lat, double long) async {
    String uri =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=500&key=${Utils.placesAPIKey}";
    http.Response res = await http.get(Uri.parse(uri));
    return res;
  }

  Future<http.Response> getComments(String postId) async {
    String uri = "https://jsonplaceholder.typicode.com/posts/1/comments";
    http.Response res = await http.get(Uri.parse(uri));
    return res;
  }

  Future<http.Response> createPost(
      Map<String, dynamic> body,
      String accesToken,
      String userID,
      List<String>? files,
      File? videoFile,
      dynamic videoThumnb) async {
    var request = http.MultipartRequest('POST', Uri.parse(createPostUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['caption'] = body['caption'] ?? "";
    request.fields['privacy'] = body['privacy'];
    request.fields['content_type'] = body['content_type']!;
    request.fields['postType'] = body['postType']!;
    request.fields['font_color'] = body['font_color'];
    request.fields['text_back_ground'] = body['text_back_ground'];
    request.fields['posted_date'] = DateTime.now().toString();
    request.fields['expire_at'] = body['expire_at']!;
    request.fields['interest'] = '';
    request.fields['location'] = body['location'];
    request.fields['active'] = '1';
    request.fields['isBusiness'] = body['isBusiness'];
    request.fields['postContentText'] = body['postContentText'];
    print(body['postType']);
    print("Post API Calling");
    if (body['postType'] == 'video') {
      var multipartFile =
          await http.MultipartFile.fromPath("postFileUrl[]", videoFile!.path);
      // var thumbnail = await http.MultipartFile.fromPath("thumbnail",
      //     videoThumnb.path);
      request.files.add(multipartFile);
      // request.files.add(thumbnail);
    } else if (body['postType'] == 'image') {
      for (int i = 0; i < files!.length; i++) {
        var multipartFile =
            await http.MultipartFile.fromPath("postFileUrl[]", files[i]);
        request.files.add(multipartFile);
      }
    }
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response =
        await http.Response.fromStream(await request.send());
    print(response.body);
    return response;
  }

  Future<http.Response> createGroupPost(
      Map<String, dynamic> body,
      String accesToken,
      String userID,
      List<String>? files,
      File? videoFile) async {
    print("group id api ${body['groupId']}");
    print("group id cionnn ${body['postType']}");
    print("Group Post API CAlling");
    var request = http.MultipartRequest('POST', Uri.parse(createGroupPostUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['caption'] = body['caption'] ?? "";
    request.fields['privacy'] = body['privacy'];
    request.fields['content_type'] = body['content_type']!;
    request.fields['postType'] = body['postType']!;
    request.fields['font_color'] = body['font_color'];
    request.fields['text_back_ground'] = body['text_back_ground'];
    request.fields['posted_date'] = DateTime.now().toString();
    request.fields['expire_at'] = body['expire_at']!;
    request.fields['interest'] = '';
    request.fields['location'] = body['location'];
    request.fields['active'] = '1';
    request.fields['postContentText'] = body['postContentText'];
    request.fields['groupId'] = body['groupId'];

    if (body['postType'] == 'video') {
      var multipartFile =
          await http.MultipartFile.fromPath("postFileUrl[]", videoFile!.path);
      request.files.add(multipartFile);
    } else if (body['postType'] == 'image') {
      for (int i = 0; i < files!.length; i++) {
        var multipartFile =
            await http.MultipartFile.fromPath("postFileUrl[]", files[i]);
        request.files.add(multipartFile);
      }
    }
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response =
        await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> postStory(
      Map<String, dynamic> body, String accesToken, String userID,
      {File? content}) async {
    var request = http.MultipartRequest('POST', Uri.parse(createPostUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['caption'] = body['caption'] ?? "";
    request.fields['privacy'] = body['privacy'];
    request.fields['content_type'] = body['content_type']!;
    request.fields['postType'] = body['postType']!;
    request.fields['font_color'] = body['font_color'];
    request.fields['text_back_ground'] = body['text_back_ground'];
    request.fields['posted_date'] = DateTime.now().toString();
    request.fields['expire_at'] = body['expire_at']!;
    request.fields['interest'] = '';
    request.fields['location'] = body['location'];
    request.fields['active'] = '1';
    request.fields['postContentText'] = body['postContentText'];
    request.fields['isBusiness'] = body['isBusiness'];
    print(body['privacy']);
    if (body['postType'] == 'text') {
    } else {
      var multipartFile =
          await http.MultipartFile.fromPath("postFileUrl[]", content!.path);
      request.files.add(multipartFile);
    }
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response =
        await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> deletePost(String postId,String accesToken,
      String userID,) async {
    String uri = deletePostUrl;
    print(postId);
    http.Response res = await http.post(Uri.parse(uri),
        body: {
          'userId': userID,
          'postId': postId
        },
        headers: {
          'token': accesToken,
          'userId': userID,
        });

    return res;
  }
  Future<http.Response> addStoryView(String postId,String accesToken,
      String userID,) async {
    String uri = addStoryViewUrl;
    http.Response res = await http.post(Uri.parse(uri),
        body: {
          'userId': userID,
          'postId': postId
        },
        headers: {
          'token': accesToken,
          'userId': userID,
        });

    return res;
  }

  Future<http.Response> editPost(Map<String,dynamic> map) async {
    String uri = editPostUrl;
    http.Response res = await http.post(Uri.parse(uri),
        body: {
          'userId': map['userId'],
          'postId': map['postId'],
          'caption': map['caption'],
          'privacy': map['privacy'],
        },
        headers: {
          'token': map['token'],
          'userId': map['userId'],
        });

    return res;
  }
}
