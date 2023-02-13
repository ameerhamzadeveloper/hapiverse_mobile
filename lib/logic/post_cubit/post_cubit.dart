import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/model/post_content_model.dart';
import '../../data/repository/group_repository.dart';
import '../../data/repository/post_repository.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/feeds/post/video_edit_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../data/model/post_places_model.dart';
import '../../utils/config/assets_config.dart';
import '../feeds/feeds_cubit.dart';
import '../groups/groups_cubit.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit()
      : super(
          PostState(
              dropList: dropList,
              dropVal: value,
              bottomSheetWidgets: listView,
              initChildSize: initialChildSize,
              images: [],
              postBGImage: bgImage,
              postController: postEditingController,
              captionTextStyle: captionTextStyle,
              textController: textEditingController,
              fontColor: fontColor,
              isMyNewPostLiked: false,
              myTemperaryComments: [],
              basicPlanBottomSheetWidgets: basicpPlanBottomSheet
          ),
        );

  final repository = PostRepository();
  final groupRepository = GroupRepository();

  String postBg = '';

  static double initialChildSize = 0.5;
  static String bgImage = "";
  static TextStyle captionTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500);
  static TextEditingController postEditingController = TextEditingController();
  static TextEditingController textEditingController = TextEditingController();
  Uint8List? videoThumb;
  changeBottomSheetSize() {
    initialChildSize = 0.1;
    emit(state.copyWith(initChildSizee: initialChildSize));
  }

  setPostBg(String val) {
    postBg = val;
  }

  makeMyNePostLike() {
    emit(state.copyWith(
        isMyNewPostLikedd: state.isMyNewPostLiked = !state.isMyNewPostLiked));
  }

  List<String> myTemPComments = [];

  addMyPostTemperaryComments(String val) {
    myTemPComments.add(val);
    emit(state.copyWith(myTemperaryCommentss: myTemPComments));
  }

  deleteFromMyTempComments(int i) {
    myTemPComments.removeAt(i);
    emit(state.copyWith(myTemperaryCommentss: myTemPComments));
  }

  static String fontColor = 'black';

  changeBGImage(int ind) {
    bgImage = "${AssetConfig.postBgBase}bg$ind.png";
    images = [];
    baseImage = null;
    videoThumb = null;
    if (ind == 1 || ind == 2 || ind == 4 || ind == 5) {
      fontColor = "white";
      captionTextStyle = const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);
    } else {
      fontColor = "black";
      captionTextStyle = const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500);
    }
    emit(state.copyWith(
        postBGImagee: bgImage,
        captionTextStylee: captionTextStyle,
        fontColorrr: fontColor),
    );
  }

  static List<Widget> listView = [
    IconButton(
        onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_up_outlined)),
    const ListTile(
      leading: Icon(Icons.image),
      title: Text("Image"),
    ),
    const ListTile(
      leading: Icon(
        Icons.video_call_rounded,
        color: Colors.blue,
      ),
      title: Text("Video"),
    ),
    const ListTile(
      leading: Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      title: Text("Location"),
    ),
    const ListTile(
      leading: Icon(
        CupertinoIcons.videocam_circle_fill,
        color: Colors.red,
      ),
      title: Text("Record Video"),
    ),
    const ListTile(
      leading: Icon(
        CupertinoIcons.camera_fill,
        color: Colors.red,
      ),
      title: Text("Camera"),
    )
  ];

  static var basicpPlanBottomSheet = [
    IconButton(
        onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_up_outlined)),
    const ListTile(
      leading: Icon(Icons.image),
      title: Text("Image"),
    ),
    const ListTile(
      leading: Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      title: Text("Location"),
    ),
  ];

  static List<String> images = [];
  Uint8List? baseImage;

  Future<void> pickImages(int source) async {
    // List<String> images = [];
    var cameraPermission = await Permission.camera.status;
    if(source == 1){
      if(cameraPermission == PermissionStatus.denied){
        print(cameraPermission);
        openAppSettings();
      }else{
        XFile? result = await ImagePicker().pickImage(source: source == 1 ? ImageSource.camera :ImageSource.gallery);
        images.add(result!.path);
        baseImage = await result.readAsBytes();
        print(images[0]);
        emit(state.copyWith(
            imagese: images, textControllerr: TextEditingController()));
        emit(state.copyWith(showImagess: images, showTextt: "",showVideoo: false));
      }
    }else{
      XFile? result = await ImagePicker().pickImage(source: source == 1 ? ImageSource.camera :ImageSource.gallery);
      images.add(result!.path);
      baseImage = await result.readAsBytes();
      print(images[0]);
      emit(state.copyWith(
          imagese: images, textControllerr: TextEditingController()));
      emit(state.copyWith(showImagess: images, showTextt: "",showVideoo: false));
    }
  }

  static String value = '🌎 Public';
  static List<String> dropList = ["🌎 Public", "🔒 Private"];

  changeDropVal(String val) {
    emit(state.copyWith(dropVall: val));
  }

  XFile? baseVideo;

  pickVideo(BuildContext context) async {
    XFile? videoFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    emit(state.copyWith(
      // videoFil: videoThumb,
      // showVideoFilee: videoThumb,
      textControllerr: TextEditingController(),
      // videoFilePathh: baseVideo!.path,
      showVideoo: true,
      videoFilePathh: videoFile!.path,
      videoControllerr: FlickManager(videoPlayerController: VideoPlayerController.file(File(videoFile!.path)),autoPlay: false),
    ));
    // getVideoThumbnail(videoFile!.path);
  }

  addRecordedVideo(File vidoe) {
    baseVideo = XFile(vidoe.path);
    getVideoThumbnail(vidoe.path);
  }

  VideoPlayerController? controller;
  File? thumbnailFile;
  getVideoThumbnail(String path) async {
    emit(state.copyWith(
      // videoFil: videoThumb,
      // showVideoFilee: videoThumb,
      textControllerr: TextEditingController(),
      // videoFilePathh: baseVideo!.path,
      showVideoo: true,
      videoControllerr: FlickManager(videoPlayerController: VideoPlayerController.file(File(baseVideo!.path)),autoPlay: false),
    ),
    );
  }

  PlaceNearby? places;
  getNeabyLocations() async {
    Position pos = await Geolocator.getCurrentPosition();
    repository.getNearbyPlaces(pos.latitude, pos.longitude).then((response) {
      print(response.body);
      var data = placeNearbyFromJson(response.body);
      places = data;
      emit(state.copyWith(placess: places));
      print(data);
    });
  }

  initVideo() {
  }

  disposeVideoController() {
    // controller!.pause();
    // state.copyWith(videoControllerr: controller);
  }

  assignPlaces(val) {
    emit(state.copyWith(currentPlacee: val));
  }

  DateTime date = DateTime.now();
  final dF = DateFormat('dd MMM yyyy');
  final tF = DateFormat('hh:mm a');
  final authBloc = RegisterCubit();

  String getPostType() {
    print("Heee======");
    print("${images.isNotEmpty ? "true":"false"}");
    print("${ state.showVideo == null ? "true":"false"}");
    print("${state.showVideo == false  ? "true":"false"}");
    print("${images.isEmpty  ? "true":"false"}");
    print("${state.showVideo == true  ? "true":"false"}");
    print("Heee====== end");
    if (images.isNotEmpty  && state.showVideo == false) {
      return "image";
    } else if (images.isEmpty && state.showVideo == true) {
      return "video";
    } else {
      return "text";
    }
  }
  String postId = '';

  resetPost(){
    emit(state.copyWith(
        imagese: [],
        videoFil: null,
        videoControllerr: null,
        showVideoo: false,
        postBGImagee: "",
        isUplaodeed: 0,
        postControllerr: TextEditingController(),
        textControllerr: TextEditingController(),
      showTextt: ""
    ));
  }

  createPost(String userID, String token,bool isBusiness) {
    emit(state.copyWith(isUplaodeed: 1));
    Map<String, dynamic> map = {
      'userId': userID,
      "privacy": state.dropVal == "🌎 Public" ? "Public":"Private",
      "content_type": "feeds",
      "postType": getPostType(),
      "font_color": "",
      "text_back_ground": bgImage,
      "posted_date": "${dF.format(date)} at ${tF.format(date)}",
      "expire_at": "",
      "interest": "",
      "location": state.currentPlace ?? "",
      "active": '1',
      "isBusiness": isBusiness ? "1":"0",
      'postContentText': state.postController.text,
      "caption":
          state.postController.text.isEmpty ? " " : state.postController.text,
    };
    print("${dF.format(date)} at ${tF.format(date)}");
    print("Post Type ${getPostType()}");
    if (getPostType() == 'text') {
      repository.createPost(map, token, userID).then((response) {
        var dec = jsonDecode(response.body);
        print(response.body);
        postId = dec['postId'].toString();
        print(response.statusCode);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(
            imagese: [],
            videoFil: null,
            postBGImagee: bgImage,
            isUplaodeed: 2,
            videoControllerr: null,
            postIdd: dec['postId'].toString()
          ));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } else if (getPostType() == 'image') {
      print("Thsi called");
      repository
          .createPost(map, token, userID, image: state.images!)
          .then((response) {
        var dec = jsonDecode(response.body);
        print(response.body);
        postId = dec['postId'].toString();
        print(response.statusCode);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(
              imagese: [],
              videoFil: null,
              videoControllerr: null,
              postBGImagee: bgImage,
              isUplaodeed: 2,
              postIdd: dec['postId'].toString()
          ));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } else {
      // print("file type  ${baseVideo!.mimeType} ${baseVideo!.name}");
      repository
          .createPost(map, token, userID,
              videoFile: File(state.videoFilePath!), thumb: "")
          .then((response) {
        var dec = jsonDecode(response.body);
        postId = dec['postId'].toString();
        print(response.body);
        print(dec);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(
              imagese: [],
              videoFil: null,
              postBGImagee: bgImage,
              videoControllerr: null,
              videoFilePathh: null,
              isUplaodeed: 2,
              postIdd: dec['postId'].toString()
          ));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }
  }

  editPost(String userId,String token,String postid,String caption,String privacy,BuildContext context){
    showCupertinoDialog(context: context, builder: (context){
      return const CupertinoAlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    Map<String,dynamic> body = {
      'caption': caption,
      'privacy': privacy,
      'userId': userId,
      'token': token,
      'postId': postid,
    };
    repository.editPost(body).then((value){
      print("post repost edit ${value.body}");
      Navigator.pop(context);
    });
  }

  deleteVideo() {
    var nulValue = null;
    emit(state.copyWith(videoFilePathh: nulValue, showVideoFilee: nulValue,videoFil: nulValue,showVideoo: false));
    print("dlete callled");
    print(state.videoFile);
  }

  assingVideoPath(String path) {
    emit(state.copyWith(videoFilePathh: path));
  }

  createGroupPost(String userID, String token, String groupId,bool isBusiness,BuildContext context) {
    final groupCubit = context.read<GroupsCubit>();
    print("group id  ddd $groupId");
    emit(state.copyWith(isUplaodeed: 1));
    Map<String, dynamic> map = {
      'userId': userID,
      "privacy": state.dropVal,
      "content_type": "group",
      "postType": getPostType(),
      "font_color": "",
      "text_back_ground": bgImage,
      "posted_date": "${dF.format(date)} at ${tF.format(date)}",
      "expire_at": "",
      "interest": "",
      "location": state.currentPlace ?? "",
      "active": '1',
      'postContentText': state.postController.text,
      "caption": state.postController.text,
      'groupId': groupId,
      "isBusiness": isBusiness ? "1":"0",
    };
    print("${dF.format(date)} at ${tF.format(date)}");
    if (getPostType() == 'text') {
      repository.createGroupPost(map, token, userID).then((response) {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          groupCubit.fetchFeedsPosts(userID, token, groupId);
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(
            imagese: [],
            videoFil: null,
            postControllerr: TextEditingController(text: ""),
            postBGImagee: bgImage,
            isUplaodeed: 2,
          ));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } else if (getPostType() == 'image') {
      repository
          .createGroupPost(map, token, userID, image: state.images!)
          .then((response) {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          groupCubit.fetchFeedsPosts(userID, token, groupId);
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(
              imagese: [],
              videoFil: null,
              postControllerr: TextEditingController(text: ""),
              postBGImagee: bgImage,
              isUplaodeed: 2));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } else {
      repository
          .createGroupPost(map, token, userID, videoFile: File(baseVideo!.path))
          .then((response) {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          groupCubit.fetchFeedsPosts(userID, token, groupId);
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(
              imagese: [],
              videoFil: null,
              postControllerr: TextEditingController(text: ""),
              postBGImagee: bgImage,
              videoControllerr: null,
              videoFilePathh: null,
              isUplaodeed: 2));
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }
  }

  ontextControllerChange(String value) {
    emit(state.copyWith(showTextt: value));
  }

  String? groupId;

  assignGroupId(String val) {
    groupId = val;
  }

  clearImage(int index) {
    images.removeAt(index);
    emit(state.copyWith(imagese: images));
  }

  clearAllPostImage(){
    images.clear();
    emit(state.copyWith(imagese: images));
  }

  addGroupPost(bool isBusiness) {
    Map<String, Object> map = {
      // "userId": authBloc.userID!,
      "privacy": state.dropVal,
      "content_type": "feeds",
      "postType": getPostType(),
      "font_color": "",
      "text_back_ground": bgImage,
      "posted_date": "${dF.format(date)} at ${tF.format(date)}",
      "expire_at": "",
      "interest": "",
      "location": state.currentPlace ?? "",
      "active": true,
      "isBusiness": isBusiness ? "1":"0",
    };
    if (baseImage != null) {
      map['postContentDto'] = [
        {
          "file_content": baseImage!,
          "filename": "MYFILE",
          "id": 0,
        }
      ];
    } else if (videoThumb != null) {
      map['postContentDto'] = [
        {
          "file_content": baseVideo!,
          "filename": "MYFILE",
          "id": 0,
        }
      ];
    }
    // groupRepository.addGropPost(map, groupId!);
  }

  bool? isUplod;

  deletePostServer(String userId,String accessToken,BuildContext context){
    repository.deletePost(postId, accessToken, userId).then((response){
       print(response.body);
       var de = json.decode(response.body);
       Navigator.pop(context);
       Navigator.pop(context);
       if(de['message'] == 'successfuly deleted'){
         Fluttertoast.showToast(msg: "Post Deleted");
         emit(state.copyWith(isUplaodeed: 0));
         print(state.isUploaded);
       }else{
         Fluttertoast.showToast(msg: "Something went wrong try again");
       }
       // Navigator.pop(context);
    });
  }

  deleteStory(String userId,String accessToken,BuildContext context,String id){
    final feedBloc = context.read<FeedsCubit>();
    repository.deletePost(id, accessToken, userId).then((response){
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == 'successfuly deleted'){
        Fluttertoast.showToast(msg: "Post Deleted");
        emit(state.copyWith(isUplaodeed: 0));
        print(state.isUploaded);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
      feedBloc.fetchMyStory(userId, accessToken);
      // Navigator.pop(context);
    });

  }

  addStoryView(String userId,String accessToken,String postId){
    repository.addStoryView(postId, accessToken, userId).then((response){
      print(response.body);
    });
  }
}
