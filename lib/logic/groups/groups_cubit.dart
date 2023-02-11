import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/model/fetch_group_invite_model.dart';
import '../../data/model/fetch_group_post_model.dart';
import '../../data/model/get_friend_for_group_invite_model.dart';
import '../../data/model/group_members_model.dart';
import '../../data/model/group_post_model.dart';
import '../../data/model/groups_model.dart';
import '../../data/model/search_group_model.dart';
import '../../data/repository/group_repository.dart';
import '../../logic/public_logics.dart';
import '../../utils/constants.dart';
import '../../views/feeds/story/design_story.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../data/model/chat_group_add_member_model.dart';
import '../../data/model/feeds_post_model.dart';
import '../../views/groups/view_searched_group.dart';
import '../../views/groups/view_single_group.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit()
      : super(GroupsState(
            privacyDownValue: privacyDownList,
            privacyValue: privacyValue,
            error: "",
            isSub: false,
            isGroupLoading: true,
            searchGroups: [],
            isJoined: false));

  final publicLogics = PublicLogics();
  final repository = GroupRepository();

  static List<String> privacyDownList = ["Private", "Public"];
  static String privacyValue = "Private";

  changePrivacyValue(String val) {
    emit(state.copyWith(privacyValuee: val));
  }

  assignName(String name) {
    emit(state.copyWith(groupNamee: name));
  }

  XFile? cover;

  getImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(state.copyWith(groupCoverr: File(image!.path)));
    cover = image;
    cropImage();
  }

  assignErro(String erro) {
    emit(state.copyWith(errorr: erro));
  }

  assignisSub() {
    emit(state.copyWith(isSubb: true));
  }

  Future<Null> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: cover!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9,
        ],
    );
    emit(state.copyWith(groupCoverr: File(croppedFile!.path)));
  }

  createGroup(String userID, BuildContext context, String accessToken) async {
    Map<String, dynamic> map = {
      'groupName': state.groupName,
      'groupPrivacy': state.privacyValue,
      'userId': userID,
    };
    repository
        .createGroup(map, accessToken, userID, File(state.groupCover!.path))
        .then((response) {
      print(response.body);
      var de = json.decode(response.body);
      if (de['message'] == "Data successfuly save") {
        emit(state.copyWith(groupCoverr: null, isSubb: false, groupNamee: ""));
        Fluttertoast.showToast(msg: "Group created successfully");
        getGroups(userID, accessToken);
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
    });
  }

  List<Groups> groups = [];
  getGroups(String userId, String accessToken) {
    emit(state.copyWith(isGroupLoadingg: true));
    repository.getGroups(accessToken, userId).then((response) {
      print(response.body);
      final result = groupsModelFromJson(response.body);
      groups = result.data;
      emit(state.copyWith(groupss: result.data, isGroupLoadingg: false));
    });
  }

  List<Groups> searchGroupList = [];

  searchGroup(String value) {
    groups.forEach((g) {
      if (g.groupName.toLowerCase().contains(value.toLowerCase())) {
        print("Searched");
        searchGroupList.add(g);
        emit(state.copyWith(searchGroupss: searchGroupList));
        print(searchGroupList.length);
        print(state.searchGroups!.length);
      } else {
        searchGroupList.clear();
        emit(state.copyWith(searchGroupss: searchGroupList));
        print(state.searchGroups!.length);
      }
    });
  }

  assignCaption(String cap) {
    emit(state.copyWith(captionn: cap));
  }

  String? groupId;
  assignGroupId(String val) {
    groupId = val;
  }

  addGroupPosts(String userID, BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      var data = value.data();
      var map = {
        'title': state.caption,
        'image': cover,
        'email': data?['email'],
        'profileImage': data?['profile_url'],
        'profileName': data?['name'],
      };
      repository.addGropPost(map, groupId!);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    });
    emit(state.copyWith(
        captionn: '', groupCoverr: null, groupNamee: '', isSubb: false));
  }

  List<FetchGroupInvite> groupInvites = [];

  fetchGroupInvites(String userID, String accesToken) {
    repository.fetchGroupInvite(accesToken, userID).then((response) {
      print(response.body);
      var data = fetchGroupInviteModelFromJson(response.body);
      print("group invite ${response.body}");
      if (data.data == []) {
        groupInvites = [];
        emit(state.copyWith(groupInvitess: []));
      }
      groupInvites = data.data;
      emit(state.copyWith(groupInvitess: groupInvites));
    });
  }

  List<FetchGroupPost>? feedsPosttt = [];
  Future<void> fetchFeedsPosts(
      String userId, String token, String groupId) async {
    print("group Id $groupId");
    repository.fetchFeedsPost(userId, token, groupId).then((response) {
      print(response.body);
      var data = fetchGroupPostModelFromJson(response.body);
      feedsPosttt = data.data;
      var de = json.decode(response.body);
      if (de['message'] == "Data not availabe") {
        emit(state.copyWith(groupPostss: []));
      } else {
        emit(state.copyWith(groupPostss: data.data));
      }
    });
  }

  addLikeDislike(String userId, String token, String postId, int index) {
    if (feedsPosttt![index].isLiked == true) {
      feedsPosttt![index].isLiked = false;
      feedsPosttt![index].totalLike =
          (int.parse(feedsPosttt![index].totalLike!) - 1).toString();
    } else {
      feedsPosttt![index].isLiked = true;
      feedsPosttt![index].totalLike =
          (int.parse(feedsPosttt![index].totalLike!) + 1).toString();
    }
    emit(state.copyWith(groupPostss: feedsPosttt));
    repository.addLikeDislike(userId, token, postId).then((response) {
      print(response.body);
    });
  }

  List<GetFriendForGroupInvite> getFriendForGroupInviteList = [];
  getFriendForGroupInvite(String userId, String token, String groupId) {
    repository.getFriendForGroupInvite(userId, token, groupId).then((reponse) {
      print(reponse.body);
      var d = json.decode(reponse.body);
      if(d['message'] != 'Data not availabe'){
        var data = getFriendForGroupInviteModelFromJson(reponse.body);
        getFriendForGroupInviteList = data.data;
        emit(state.copyWith(getFriendForGroupInviteListt: data.data));
      }
    });
  }
  List<ChatGroupAddMember> addMemberChatGroup = [];
  List<ChatGroupAddMember> addedMemberChatGroupList = [];
  getFriendForChatGroupInvite(String userId, String token, String groupId) {
    addMemberChatGroup.clear();
    addedMemberChatGroupList.clear();
    repository.getFriendForGroupInvite(userId, token, groupId).then((reponse) {
      var d = json.decode(reponse.body);
      if(d['message'] != 'Data not availabe'){
        var data = getFriendForGroupInviteModelFromJson(reponse.body);
        getFriendForGroupInviteList = data.data;
        for(var i in data.data){
          addMemberChatGroup.add(
              ChatGroupAddMember(userName: i.userName!, isSelect: false, userImage: i.profileImageUrl!,userId: i.userId!),
          );
        }

        emit(state.copyWith(addMemberChatGroupp: addMemberChatGroup));
      }
    });
  }

  addMemberChatGroupList(int i){
    print("Loop Called func");
    if(addedMemberChatGroupList.isEmpty){
      addedMemberChatGroupList.add(
          ChatGroupAddMember(userName: addMemberChatGroup[i].userName, isSelect: true, userImage: addMemberChatGroup[i].userImage,userId: addMemberChatGroup[i].userId));
    }else{
      if(addMemberChatGroup[i].isSelect){
        addedMemberChatGroupList.removeLast();
      }else{
        addedMemberChatGroupList.add(
            ChatGroupAddMember(userName: addMemberChatGroup[i].userName, isSelect: true, userImage: addMemberChatGroup[i].userImage,userId: addMemberChatGroup[i].userId));

      }
    }


    addMemberChatGroup[i].isSelect = !addMemberChatGroup[i].isSelect;
    print(addMemberChatGroup[i].isSelect);
    emit(state.copyWith(addMemberChatGroupp: addMemberChatGroup,addedMemberChatGroupp: addedMemberChatGroupList));
  }

  removeMembersChatGroupAdded(int i){
    addedMemberChatGroupList.removeAt(i);
    emit(state.copyWith(addedMemberChatGroupp: addedMemberChatGroupList));
  }

  inviteToGroup(int i, String userid, String targetId, String token,
      String groupId, String name) {
    getFriendForGroupInviteList[i].alreadyInvited = true;
    emit(state.copyWith(
        getFriendForGroupInviteListt: getFriendForGroupInviteList));
    repository.inviteToGroup(userid, token, groupId, targetId).then((response) {
      print(response.body);
      Fluttertoast.showToast(msg: "$name Invited SuccessFully");
    });
  }

  leaveGroup(
      String userid, String token, String groupId, BuildContext context) {
    repository.leaveGroup(userid, token, groupId).then((response) {
      print(response.body);
      getGroups(userid, token);
    });
  }

  removeUserFromGroup(String userid, String targetId, String token,
      String groupId, String name) {
    repository
        .removeUserFromGroup(userid, token, groupId, targetId)
        .then((response) {
      Fluttertoast.showToast(msg: "$name Removed SuccessFully");
    });
  }

  fetchAllGroupMembers(String userId, String token, String groupId) {
    repository.fetchAllGroupMembers(userId, token, groupId).then((response) {
      print(response.body);
      var data = groupMembersModelFromJson(response.body);
      emit(state.copyWith(groupMemberss: data.data));
    });
  }

  fetchSingleGroupFromInvite(
      String userId,
      String token,
      String groupId,
      BuildContext context,
      String inviterName,
      String inviterPhoto,
      String inviterId,
      int index
      ) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    repository.fetchSingleGroup(userId, token, groupId).then((value) {
      print(value.body);
      var dec = json.decode(value.body);
      var d = dec['data'];
      Map<String, dynamic> map = {
        'groupId': d['groupId'],
        'groupAdminId': d['groupAdminId'],
        'groupName': d['groupName'],
        'groupImageUrl': d['groupImageUrl'],
        'groupPrivacy': d['groupPrivacy'],
      };
      print(dec);
      emit(state.copyWith(singleGroupMapp: map));
      Navigator.pop(context);
      nextScreen(
          context,
          ViewSingleGroup(
            index: index,
            groupId: groupId,
            inviterID: inviterId,
            inviterName: inviterName,
            inviterPhoto: inviterPhoto,
          ));
    });
  }

  fetchSingleGroup(
      String userId,
      String token,
      String groupId,
      BuildContext context,
      ) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    repository.fetchSingleGroup(userId, token, groupId).then((value) {
      print(value.body);
      var dec = json.decode(value.body);
      var d = dec['data'];
      print(d);
      Map<String, dynamic> map = {
        'groupId': d['groupId'],
        'groupAdminId': d['groupAdminId'],
        'groupName': d['groupName'],
        'groupImageUrl': d['groupImageUrl'],
        'groupPrivacy': d['groupPrivacy'],
      };
      print(dec);
      emit(state.copyWith(singleGroupMapp: map));
      Navigator.pop(context);
      nextScreen(
          context,
          ViewSearchGroup(
            groupId: groupId,
          ));
    });
  }

  makeGroupUnjoined() {
    emit(state.copyWith(isJoinedd: false));
  }

  declinedGroup(int index){
    groupInvites.removeAt(index);
    emit(state.copyWith(groupInvitess: groupInvites));
  }

  bool joinGroup(String userId, String token, String groupId, String inviterId,
      BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    var value = false;
    repository.jonGroup(userId, token, groupId, inviterId).then((response) {
      // Navigator.pop(context);
      print(response.body);
      var dec = json.decode(response.body);
      if (dec['message'] == 'Data successfuly save') {
        Fluttertoast.showToast(msg: "Joined Successfully");
        emit(state.copyWith(isJoinedd: true));
        fetchGroupInvites(userId, token);
        getGroups(userId, token);
        Navigator.pop(context);
      } else {
        emit(state.copyWith(isJoinedd: false));
      }
    });
    return value;
  }

  takeChatGroupImageGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(state.copyWith(chatGroupImagee: File(image!.path)));
    cropImage();
  }

  takeChatGroupImageCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(state.copyWith(chatGroupImagee: File(image!.path)));
    cropImage();
  }

  assignChatGroupName(String name){
    emit(state.copyWith(chatGroupNamee: name));
  }

  DateTime date = DateTime.now();
  Future<String> uploadImage(Uint8List? imageBytes, String cid, String filename,String userid) async {
    try{
      var snapshot = await FirebaseStorage.instance.ref().child('chats/${userid}$cid$filename${DateTime.now()}').putData(imageBytes!);
      var url = (await snapshot.ref.getDownloadURL()).toString();
      return url;
    }catch(e){
      print("$e error");
      return "";
    }
  }
  String docId = 'dsfdsf34324234';
  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'BCDEFGxcbHIJKLsdfdMNOPhfQRSTUdfdfcvVWXYZ';
    docId = List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  createChatGroup(String userId,String myName,String myImage,BuildContext context)async{
    showDialog(context: context, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    generateRandomString(15);
    var bytes = await state.chatGroupImage!.readAsBytes();
      String filename = state.chatGroupImage!.path.split("/").last;
      String imageUrl = await uploadImage(bytes, state.chatGroupName!, filename,state.chatGroupName!);
      print(imageUrl);
    firestore.collection('recentChats').doc(userId).collection('myChats').doc(state.chatGroupName!).set({
      'lastMessage': "",
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':docId,
      'senderID': userId,
      'recieverName':state.chatGroupName!,
      'profileImage':imageUrl,
      'count':0,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token': widget.fcmToken,
    });
    firestore.collection('groupMembers').doc(docId).set({
      'userName': myName,
      'userImage':myImage,
      'userId': userId,
      'role':'Admin'
    });

    for(var i = 0; i < state.addedMemberChatGroup!.length; i++){
      firestore.collection('recentChats').doc(addedMemberChatGroupList[i].userId).collection('myChats').doc(state.chatGroupName!).set({
        'lastMessage': "",
        'date': "${date.year}/${date.month}/${date.day}",
        'timestamp':DateTime.now(),
        'recieverID':docId,
        'senderID': userId,
        'recieverName':state.chatGroupName!,
        'profileImage':imageUrl,
        'count':0,
        'isSendMe':false,
        'isSeen':false,
        'isOnline':false,
        'messageType': 'text',
        'isBlocked':false,
        'isBlockedMe':false,
        'deleted':false,
        'deleteEveryOne':false,
        'isGroup':true,
        // 'token': widget.fcmToken,
      });

      firestore.collection('groupMembers').doc(docId).set({
        'userName':state.addedMemberChatGroup![i].userName,
        'userImage':state.addedMemberChatGroup![i].userImage,
        'userId':state.addedMemberChatGroup![i].userId,
        'role':'Member'
      });
    }
    Navigator.pop(context);

  }


  searchGroups(String userID,String token,String query){
    repository.searchGroups(userID, token, query).then((response) {
      print(response.body);
      var data = searchGroupModelFromJson(response.body);
      emit(state.copyWith(searchedGroupss: data.data));
    });
  }


}
