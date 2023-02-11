part of 'feeds_cubit.dart';


class FeedsState {

  String? translatedText;
  String? searchText;
  TextEditingController searchController;
  List<SearchedUsers>? searchedUsersList;
  bool isSearching = false;
  List<FeedsPosts>? feedsPost;
  List<StoryModel>? storyList;
  List<StoryAPI>? storyApiList;
  FetchMyStory? myStory;
  List<StoryModel>? myStoryShow;
  bool isStoryLoading = true;
  List<PostComments>? postCommentMap;
  List temperaryCommentList;
  List<SearchBusiness>? searchedBusiness;
  double? distance;
  List<VideoPlayModel>? videoList;
  List<SuggestedFriends>? sugeestedFriends;

  FeedsState({this.translatedText,this.searchText,
    required this.searchController,this.searchedUsersList,required this.isSearching,
  this.feedsPost,this.storyList,this.storyApiList,this.myStory,
    this.myStoryShow,required this.isStoryLoading,this.postCommentMap,required this.temperaryCommentList,
  this.searchedBusiness,this.distance,this.videoList,this.sugeestedFriends});

  FeedsState copyWith({
    String? translatedTextt,
    String? searchTextt,
    TextEditingController? searchControllerr,
    List<SearchedUsers>? searchedUsersListt,
    bool? isSearchingg,
    List<FeedsPosts>? feedsPostt,
    List<StoryModel>? storylistt,
    List<StoryAPI>? storyApiListt,
    FetchMyStory? myStoryy,
    List<StoryModel>? myStoryShoww,
    bool? isStoryLoadingg,
    List<PostComments>? postCommentMapp,
    List? temperaryCommentListt,
    List<SearchBusiness>? searchedBusinesss,
    double? distancee,
    List<VideoPlayModel>? videoListt,
    List<SuggestedFriends>? sugeestedFriendss,
  }){
    return FeedsState(
      translatedText: translatedTextt ?? translatedText,
      searchText: searchTextt ?? searchText,
      searchController: searchControllerr ?? searchController,
      searchedUsersList: searchedUsersListt ?? searchedUsersList,
      isSearching: isSearchingg ?? isSearching,
      feedsPost: feedsPostt ?? feedsPost,
      storyList: storylistt ?? storyList,
      storyApiList: storyApiListt ?? storyApiList,
      myStory: myStoryy ?? myStory,
      myStoryShow: myStoryShoww ?? myStoryShow,
      isStoryLoading: isStoryLoadingg ?? isSearching,
      postCommentMap: postCommentMapp ?? postCommentMap,
      temperaryCommentList: temperaryCommentListt ?? temperaryCommentList,
      searchedBusiness: searchedBusinesss ?? searchedBusiness,
      distance: distancee ?? distance,
      videoList: videoListt ?? videoList,
      sugeestedFriends: sugeestedFriendss ?? sugeestedFriends
    );
}

}
