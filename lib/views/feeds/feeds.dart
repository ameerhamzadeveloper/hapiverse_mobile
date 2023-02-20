import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/views/test_image.dart';
import '../../logic/feeds/feeds_cubit.dart';
import '../../logic/post_cubit/post_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/feeds/components/book_now_ads_widget.dart';
import '../../views/feeds/components/friends_suggestion_widget.dart';
import '../../views/feeds/components/loading_story_widget.dart';
import '../../views/feeds/components/my_post_image_widget.dart';
import '../../views/feeds/components/post_widget.dart';
import '../../views/feeds/components/text_feed_widget.dart';
import '../../views/feeds/components/video_post_card.dart';
import '../../views/feeds/post/add_post.dart';
import '../../views/feeds/components/add_story_widget.dart';
import '../../views/feeds/components/story_widget.dart';
import 'package:line_icons/line_icons.dart';
import '../../logic/register/register_cubit.dart';
import 'components/loading_post_widget.dart';
import 'components/my_text_post_widget.dart';
import 'components/my_video_post_card.dart';
import 'components/product_ad_widget.dart';

class FeedsPage extends StatefulWidget {
  final bool isBusiness;
  const FeedsPage({Key? key,required this.isBusiness}) : super(key: key);
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {

  String text = "Good Morning";
  DateTime d = DateTime.now();

  late ScrollController scrollController;

  int limit = 20;
  int startFrom = 0;
  // if(d.hour);

  Future<void> refreseh()async{
    final bloc = context.read<FeedsCubit>();
    final authB = context.read<RegisterCubit>();
    print("start fro $startFrom");
    startFrom = startFrom + 20;
    bloc.fetchFeedsPosts(authB.userID!, authB.accesToken!,limit.toString(),startFrom.toString());
    bloc.fetchMyStory(authB.userID!, authB.accesToken!);
    bloc.fetchSuggestedFriends(authB.userID!, authB.accesToken!);
    print("API CALL DONE");
    // setState(() {});
  }

  fetchFeedPostOnly(){
    final bloc = context.read<FeedsCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchFeedsPosts(authB.userID!, authB.accesToken!,limit.toString(),startFrom.toString());
  }

 void _addListner(){
    print("Listeneer");
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent ){
      print(scrollController.position.maxScrollExtent);
      startFrom = startFrom + 20;
      print("start from $startFrom");
      fetchFeedPostOnly();
    }
  }

 @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_addListner);
  }
  @override
  Widget build(BuildContext context) {
   final bloc = context.read<FeedsCubit>();
   final authB = context.read<RegisterCubit>();
   final postBloc = context.read<PostCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profileState) {
    return BlocBuilder<PostCubit, PostState>(
  builder: (context, postState) {
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: (){
          return refreseh();
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: kScaffoldBgColor,
              leading: Container(),
              expandedHeight: 100.0,
              leadingWidth: 10,
              centerTitle: false,
              title:const Text(
                "Hapiverse",
                // state.profileName == null ? "...":state.profileName!.length > 10 ? "${state.profileName!.substring(0,10)}..":state.profileName!,
                style: TextStyle(
                    color: kUniversalColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                    getTranslated(context, 'EXPLORE_TODAY')!,
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, searchPage);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                BlocBuilder<RegisterCubit,RegisterState>(
  builder: (context, authState) {
    return IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, notifications);
                      var d = FirebaseMessaging.instance;
                      d.getToken().then((value){
                        print(value);
                      });
                    },
                    icon: Badge(
                      animationType: BadgeAnimationType.slide,
                      ignorePointer: true,
                      showBadge: authState.notificaitionCount == '0' ? false:true,
                      badgeContent: Text(authState.notificaitionCount,style: TextStyle(color: Colors.white,fontSize: 11,fontFamily: ''),),
                      child: const Icon(
                        LineIcons.bell,
                        color: Colors.black,
                      ),
                    ),
                );
  },
),
              ],
            ),
            SliverToBoxAdapter(
              child: _storyWidget(),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<PostCubit,PostState>(
                builder: (context,state) {
                  if(state.isUploaded == null || state.isUploaded! == 0){
                    return Container();
                  }else if(state.isUploaded == 1){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Post Uploading...."),
                          SizedBox(height: 5,),
                          LinearProgressIndicator()
                        ],
                      ),
                    );
                  }else{
                    return Container();
                  }
                }
              ),
            ),
            postState.isUploaded == 2 ?
            SliverAnimatedList(
              initialItemCount: 1,
              itemBuilder: (ctx,i,animation){
                  if(postBloc.getPostType() == 'text'){
                    return SizeTransition(
                        sizeFactor: animation,
                        child: MyTextPost(
                          index: 0,
                          isFriend: 'default',
                          userId: authB.userID!,
                          commentOntap: (){},
                          postId: postState.postId ?? "",
                          onTap: (){},
                          name: postState.showText!,
                          bgImage: postState.postBGImage!,
                          commentCount: '0',
                          date: DateTime.now(),
                          likeCount: '0',
                          profileName: profileState.profileName ?? profileState.businessProfile!.businessName!,
                          profilePic: "${Utils.baseImageUrl}${profileState.profileImage ?? profileState.businessProfile!.logoImageUrl}",
                          fontColor: postState.fontColor,
                        )
                    );
                  }else if(postBloc.getPostType() == 'video'){
                    return SizeTransition(
                      sizeFactor: animation,
                      child: MyVideoPostCard(
                        userTypeid: authB.isBusinessShared! ? "2":"1",
                        isLiked: false,
                        postId: postState.postId ?? "",
                        name: postState.postController.text,
                        iamge: postState.videoController!,
                        date: DateTime.now(),
                        commentCount: '0',
                        likeCount: '0',
                        profileName: authB.isBusinessShared! ? profileState.businessProfile!.businessName!:profileState.profileName ?? "",
                        profilePic: "${Utils.baseImageUrl}${authB.isBusinessShared! ? profileState.businessProfile!.logoImageUrl:profileState.profileImage}",
                        videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        userId: authB.userID!,
                        isFriend: "Follow",
                        index: i,
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, "d.postId!", i,'d');
                        },
                        hasVerified: "0",
                      ),
                    );
                  }else{
                    return SizeTransition(
                      sizeFactor: animation,
                      child: MyPostImageWidget(
                        postId: postState.postId ?? "",
                        name: postState.showText!,
                        date: DateTime.now(),
                        commentCount: '0',
                        likeCount: '0',
                        profileName: profileState.profileName ?? profileState.businessProfile!.businessName!,
                        profilePic: "${Utils.baseImageUrl}${profileState.profileImage ?? profileState.businessProfile!.logoImageUrl}",
                        isLiked: false,
                        index: i,
                        userId: authB.userID!,
                        onLikeTap: (){
                          // bloc.addLikeDislike(authB.userID!, authB.accesToken!, "d.postId!", i,'');
                        },
                      ),
                    );
                  }
              },
            ):SliverToBoxAdapter(),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: Container(
            //       height: 170,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white
            //       ),
            //       child: Column(
            //         children: [
            //           Container(
            //             height: 100,
            //             width: double.infinity,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //               image: DecorationImage(
            //                 fit: BoxFit.cover,
            //                 image: NetworkImage("https://i.insider.com/5150710969beddc11500000b?width=750&format=jpeg&auto=webp")
            //               )
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: [
            //                 Expanded(child: Text("Ads Title goes here",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
            //                 OutlinedButton(onPressed: (){
            //                   showDialog(context: context, builder: (context){
            //                     return AlertDialog(
            //                       content: Container(
            //                         height: 170,
            //                         width: double.infinity,
            //                         decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(10),
            //                             color: Colors.white
            //                         ),
            //                         child: Column(
            //                           children: [
            //                             Container(
            //                               height: 100,
            //                               width: double.infinity,
            //                               decoration: BoxDecoration(
            //                                   borderRadius: BorderRadius.circular(10),
            //                                   image: DecorationImage(
            //                                       fit: BoxFit.cover,
            //                                       image: NetworkImage("https://i.insider.com/5150710969beddc11500000b?width=750&format=jpeg&auto=webp")
            //                                   )
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: Row(
            //                                 children: [
            //                                   Expanded(child: Text("Ads Title goes here",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
            //                                   OutlinedButton(onPressed: (){
            //                                   }, child: Text("LEARN MORE"))
            //                                 ],
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   });
            //                 }, child: Text("LEARN MORE"))
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            state.feedsPost == null || state.feedsPost!.isEmpty ? SliverToBoxAdapter(child: LoadingPostWidget()):
            SliverToBoxAdapter(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // controller: scrollController,
                itemBuilder: (ctx,i){
                  var d = state.feedsPost![i];
                  print("post Length ${state.feedsPost!.length}");
                  if(i == 1){
                    if(state.sugeestedFriends == null || state.sugeestedFriends!.isEmpty){
                      return Container();
                    }
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            const Text("Peoples you may know"),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(state.sugeestedFriends!.length, (index){
                                  return state.sugeestedFriends![index].isDeleted ? Container():FriendSuggestionWidget(index:index);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }else{
                   if(state.feedsPost![i].postType == 'ad'){
                  print("addd Calllllllllllled");
                  if(state.feedsPost![i].contentType == 'website'){
                    return BookNowAdsWidget(
                      addId: d.postId!,
                        isBookNow: false,
                      title: d.postContentText ?? "",
                      userName: d.userName!,
                      image: "",
                      profileImage: d.profileImageUrl!,
                      date: d.postedDate.toString(),
                      description: d.caption!,
                      url: d.websiteUrl!,
                      comment: d.totalComment ?? "0",
                      like: d.totalLike ?? "0",
                      isLiked: d.isLiked!,
                      onLikeTap: (){
                        bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i,d.userId!);
                      },
                    );
                  }else{
                    return ProductAdWidget(
                      isBookNow: true,
                      title: d.postContentText ?? "",
                      userName: d.userName!,
                      image: d.postFiles![0].postFileUrl,
                      profileImage: d.profileImageUrl!,
                      date: d.postedDate.toString(),
                      description: d.caption!,
                      url: d.websiteUrl ?? "",
                      comment: d.totalComment ?? "0",
                      like: d.totalLike ?? "0",
                      isLiked: d.isLiked!,
                      onLikeTap: (){
                        bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i,d.userId!);
                      },
                    );
                  }
                  }
                    else if(state.feedsPost![i].postType == 'image'){
                      return PostWidget(
                        typeId: d.userTypeId ?? "2",
                        isFriend: d.isFriend!,
                        postId: d.postId!,
                        name: d.caption ?? "",
                        iamge: d.postFiles!,
                        date: d.postedDate!,
                        commentCount: d.totalComment.toString(),
                        likeCount: d.totalLike.toString(),
                        profileName: d.userName ?? "",
                        profilePic: "${Utils.baseImageUrl}${d.profileImageUrl}",
                        isLiked: d.isLiked!,
                        index: i,
                        userId: d.userId!,
                        privacy: d.privacy!,
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i,d.userId!);
                        },
                        hasVerified:d.hasVerified ?? "0",
                      );
                    }else if(state.feedsPost![i].postType == 'text'){
                      return TextFeedsWidget(
                        userTypeId: d.userTypeId!,
                        index: i,
                        userId: d.userId!,
                        commentOntap: (){},
                        postId: d.postId!,
                        onTap: (){},
                        name:  d.postContentText == "" ? d.caption ?? "" :d.postContentText!,
                        bgImage: d.textBackGround ?? "",
                        commentCount: d.totalComment.toString(),
                        date: d.postedDate!,
                        likeCount: d.totalLike.toString(),
                        profileName: d.userName ?? "",
                        profilePic: "${Utils.baseImageUrl}${d.profileImageUrl}",
                        fontColor: d.fontColor!,
                        isFriend: d.isFriend!,
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i,d.userId!);
                        },
                        isLiked: d.isLiked!,
                        hasVerified:d.hasVerified ?? "0",
                      );
                    }else if(state.feedsPost![i].postType == 'video'){
                      if(d.postFiles!.isNotEmpty){
                        return VideoPostCard(
                          userTypeid: d.userTypeId!,
                          isLiked: d.isLiked!,
                          postId: d.postId!,
                          name: d.caption ?? "",
                          iamge: "${Utils.baseImageUrl}${d.postFiles![0].postFileUrl}",
                          date: d.postedDate!,
                          commentCount: d.totalComment.toString(),
                          likeCount: d.totalLike.toString(),
                          profileName:d.userName!,
                          profilePic: "${Utils.baseImageUrl}${d.profileImageUrl}",
                          videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                          userId: d.userId!,
                          index: i,
                          isFriend: d.isFriend!,
                          onLikeTap: (){
                            bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i,d.userId!);
                          },
                          hasVerified:d.hasVerified ?? "0",
                        );
                      }
                      else{
                        return Container();
                      }
                    }
                    else{
                      return Container();
                    }
                   }
                  },
                itemCount: state.feedsPost!.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // nextScreen(context, TestFaceReco());
          if(profileState.profileName != null || profileState.businessProfile!.businessName != null){
            nextScreen(context, AddPostPage(isFromGroup: false,isBusiness: authB.isBusinessShared! ? true:false,));
          }else{
            Fluttertoast.showToast(msg: "Something went wrong try again");
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: kSecendoryColor,
      ),
    );
  },
);
  },
);
  },
);
  }

  Widget _storyWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<FeedsCubit,FeedsState>(
        builder: (context,state){
          return Row(
              children: [
                const AddStoryWidget(),
                state.myStoryShow == null ? Container():state.myStoryShow!.isEmpty ? Container():StoryWidget(
                  image: state.myStoryShow![0].profileImage,
                  title: "My Story",
                  index: 0,
                  isMyStory:true,
                ),
                state.isStoryLoading ? LoadingStoryWidget() : state.storyList == null || state.storyList!.isEmpty ? Container():SizedBox(
                  height: 95,
                  child: state.storyList == null ? Container():ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.storyList!.length,
                    itemBuilder: (ctx,i){
                      return StoryWidget(
                        isMyStory:false,
                        image: state.storyList![i].profileImage,
                        title: state.storyList![i].date,
                        index: i,
                      );
                    },
                  ),
                )
              ],
          );
        },
      )
    );
  }
}
