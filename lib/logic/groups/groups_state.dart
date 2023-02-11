part of 'groups_cubit.dart';

class GroupsState {
  List<String> privacyDownValue;
  String privacyValue;
  String? groupName;
  File? groupCover;
  String error;
  bool isSub;
  String? caption;
  List<Groups>? groups;
  bool isGroupLoading = true;
  List<Groups>? searchGroups = [];
  List<FetchGroupInvite>? groupInvites;
  List<FetchGroupPost>? groupPosts;
  List<GetFriendForGroupInvite>? getFriendForGroupInviteList;
  List<GroupMembers>? groupMembers;
  Map<String, dynamic>? singleGroupMap;
  bool isJoined = false;
  List<ChatGroupAddMember>? addMemberChatGroup;
  List<ChatGroupAddMember>? addedMemberChatGroup;
  String? chatGroupName;
  File? chatGroupImage;
  List<GroupSearch>? searchedGroups;

  GroupsState(
      {required this.privacyDownValue,
      required this.privacyValue,
      this.groupName,
      this.groupCover,
      required this.error,
      required this.isSub,
      this.caption,
      this.groups,
      required this.isGroupLoading,
      this.searchGroups,
      this.groupInvites,
      this.groupPosts,
      this.getFriendForGroupInviteList,
      this.groupMembers,
      this.singleGroupMap,
      required this.isJoined,
        this.addMemberChatGroup,
        this.addedMemberChatGroup,
        this.chatGroupImage,
        this.chatGroupName,
        this.searchedGroups
      });

  GroupsState copyWith({
    List<String>? privacyDownValuee,
    String? privacyValuee,
    String? groupNamee,
    File? groupCoverr,
    String? errorr,
    bool? isSubb,
    String? captionn,
    List<Groups>? groupss,
    bool? isGroupLoadingg,
    List<Groups>? searchGroupss,
    List<FetchGroupInvite>? groupInvitess,
    List<FetchGroupPost>? groupPostss,
    List<GetFriendForGroupInvite>? getFriendForGroupInviteListt,
    List<GroupMembers>? groupMemberss,
    Map<String, dynamic>? singleGroupMapp,
    bool? isJoinedd,
    List<ChatGroupAddMember>? addMemberChatGroupp,
    List<ChatGroupAddMember>? addedMemberChatGroupp,
    String? chatGroupNamee,
    File? chatGroupImagee,
    List<GroupSearch>? searchedGroupss
  }) {
    return GroupsState(
        privacyDownValue: privacyDownValuee ?? privacyDownValue,
        privacyValue: privacyValuee ?? privacyValue,
        groupName: groupNamee ?? groupName,
        groupCover: groupCoverr ?? groupCover,
        error: errorr ?? error,
        isSub: isSubb ?? isSub,
        caption: captionn ?? caption,
        groups: groupss ?? groups,
        isGroupLoading: isGroupLoadingg ?? isGroupLoading,
        searchGroups: searchGroupss ?? searchGroups,
        groupInvites: groupInvitess ?? groupInvites,
        groupPosts: groupPostss ?? groupPosts,
        getFriendForGroupInviteList:
            getFriendForGroupInviteListt ?? getFriendForGroupInviteList,
        groupMembers: groupMemberss ?? groupMembers,
        singleGroupMap: singleGroupMapp ?? singleGroupMap,
        isJoined: isJoinedd ?? isJoined,
      addMemberChatGroup: addMemberChatGroupp ?? addMemberChatGroup,
      addedMemberChatGroup: addedMemberChatGroupp ?? addedMemberChatGroup,
      chatGroupImage: chatGroupImagee ?? chatGroupImage,
      chatGroupName: chatGroupNamee ?? chatGroupName,
      searchedGroups: searchedGroupss ?? searchedGroups
    );
  }
}
