import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../views/groups/settings.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/groups/groups_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../components/secondry_button.dart';
import '../feeds/components/friends_suggestion_widget.dart';
import '../feeds/components/loading_post_widget.dart';
import '../feeds/components/post_widget.dart';
import '../feeds/components/text_feed_widget.dart';
import '../feeds/components/video_post_card.dart';
import '../feeds/post/add_post.dart';
class ViewSearchGroup extends StatefulWidget {
  final String groupId;

  const ViewSearchGroup({Key? key,required this.groupId}) : super(key: key);
  @override
  _ViewSearchGroupState createState() => _ViewSearchGroupState();
}

class _ViewSearchGroupState extends State<ViewSearchGroup> {
  @override
  void initState() {
    super.initState();
    var b = context.read<RegisterCubit>();
    var gb = context.read<GroupsCubit>();
    gb.makeGroupUnjoined();
    context
        .read<GroupsCubit>()
        .fetchFeedsPosts(b.userID!, b.accesToken!, widget.groupId);
  }
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    final bloc = context.read<GroupsCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<GroupsCubit, GroupsState>(builder: (context, state) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            //2
            SliverAppBar(
              actions: [
                state.isJoined
                    ? IconButton(
                    onPressed: () {
                      // nextScreen(
                      //     context,
                      //     GroupSettings(
                      //       id: state.singleGroupMap!['groupId'],
                      //       groupName: state.singleGroupMap!['groupName'],
                      //       index: widget.index,
                      //     ));
                    },
                    icon: Icon(LineIcons.cog))
                    : Container()
              ],
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(state.singleGroupMap!['groupName']),
                background: Image.network(
                  "${Utils.baseImageUrl}${state.singleGroupMap!['groupImageUrl']}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Privacy Type : ${state.singleGroupMap!['groupPrivacy']}"),
              ),
            ),
            state.isJoined
                ? state.singleGroupMap!['groupPrivacy'] == "Public" ? SliverToBoxAdapter(child:   Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Joined ${state.singleGroupMap!['groupName']} Group"),
              ),
            )):SliverToBoxAdapter(
              child: Container(decoration: BoxDecoration(
      color: Colors.grey[300]
      ),child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Group join request sent to admin"),
      ),),
            ):SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
      ),
      minWidth: double.infinity,
      onPressed: (){bloc.joinGroup(authB.userID!, authB.accesToken!, widget.groupId, "s7Ox8LHm26", context);},
      color: kUniversalColor,
      child: Text("Join Group",style: TextStyle(color: Colors.white),),
      ),
              ),
            )
                , SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.grey[300],
                  // ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Divider(color: Colors.black,)
                    ],
                  ),
                ),
              ),
            ),
            state.singleGroupMap!['groupPrivacy'] == "Private" ? SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About",style: TextStyle(fontSize: 18),),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(state.singleGroupMap!['groupPrivacy']),
                      leading: CircleAvatar(
                        child: Icon(state.singleGroupMap!['groupPrivacy'] == "Private" ? LineIcons.lock:LineIcons.globe),
                      ),
                      subtitle: Text(state.singleGroupMap!['groupPrivacy'] == "Private" ?"This group is private you can request to join this":"This group is public you can join"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Visibility"),
                      leading: CircleAvatar(
                        child: Icon(LineIcons.eye),
                      ),
                      subtitle: Text(state.singleGroupMap!['groupPrivacy'] == "Private" ?"Anyone can find this group but can't see full informations":"Anyone can find and join this group"),
                    ),
                  ],
                ),
              ),
            ):state.groupPosts == null
                ? SliverToBoxAdapter(child: LoadingPostWidget())
                : state.groupPosts!.isEmpty
                ? state.isJoined
                ? SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text("No Group Post"),
                      SizedBox(
                          width: getWidth(context) / 2,
                          child: SecendoryButton(
                              text: "Create First Post",
                              onPressed: () {
                                // print(state
                                //     .groups![widget.index].groupId);
                                // nextScreen(
                                //     context,
                                //     AddPostPage(
                                //       isFromGroup: true,
                                //       groupId: state
                                //           .groups![widget.index]
                                //           .groupId
                                //       ,isBusiness: authB.isBusinessShared! ? true:false,
                                //     ));
                              }))
                    ],
                  ),
                ))
                : SliverToBoxAdapter(
              child: Container(),
            )
                : SliverAnimatedList(
              itemBuilder: (ctx, i, animation) {
                var d = state.groupPosts![i];
                // if(i == 1){
                //   return Card(
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text("Peoples you may know"),
                //           SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Row(
                //               children: List.generate(4, (index){
                //                 return const FriendSuggestionWidget();
                //               }),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
                // }else{
                if (state.groupPosts![i].postType == 'image') {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: PostWidget(
                      typeId: d.userTypeId,
                      hasVerified: d.hasVerified,
                      isFriend: 'default',
                      postId: d.postId,
                      name: d.caption,
                      iamge: d.postFiles!,
                      date: d.postedDate!,
                      commentCount: d.totalComment.toString(),
                      likeCount: d.totalLike.toString(),
                      profileName: d.userName,
                      profilePic:
                      "${Utils.baseImageUrl}${d.profileImageUrl}",
                      isLiked: d.isLiked!,
                      index: i,
                      userId: d.userId,
                      privacy: d.privacy,
                      onLikeTap: () {
                        bloc.addLikeDislike(authB.userID!,
                            authB.accesToken!, d.postId, i);
                      },
                    ),
                  );
                } else if (state.groupPosts![i].postType == 'text') {
                  return SizeTransition(
                      sizeFactor: animation,
                      child: TextFeedsWidget(
                        userTypeId: d.userTypeId,
                        hasVerified: d.hasVerified,
                        index: i,
                        fontColor: d.fontColor!,
                        userId: d.userId,
                        commentOntap: () {},
                        postId: d.postId,
                        onTap: () {},
                        name: d.postContentText!,
                        bgImage: d.textBackGround!,
                        commentCount: d.totalComment.toString(),
                        date: d.postedDate!,
                        likeCount: d.totalLike.toString(),
                        profileName: d.userName,
                        profilePic:
                        "${Utils.baseImageUrl}${d.profileImageUrl}",
                        isFriend: 'default',
                        onLikeTap: () {
                          bloc.addLikeDislike(authB.userID!,
                              authB.accesToken!, d.postId, i);
                        },
                        isLiked: d.isLiked!,
                      ));
                } else {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: VideoPostCard(
                      userTypeid: d.userTypeId,
                      hasVerified: d.hasVerified,
                      isLiked: d.isLiked!,
                      postId: d.postId,
                      name: d.caption,
                      iamge:
                      "${Utils.baseImageUrl}${d.postFiles![0].postFileUrl}",
                      date: d.postedDate!,
                      commentCount: d.totalComment.toString(),
                      likeCount: d.totalLike.toString(),
                      profileName: d.userName,
                      profilePic:
                      "${Utils.baseImageUrl}${d.profileImageUrl}",
                      videothumb:
                      "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                      userId: d.userId,
                      index: i,
                      isFriend: "default",
                      onLikeTap: () {
                        bloc.addLikeDislike(authB.userID!,
                            authB.accesToken!, d.postId, i);
                      },
                    ),
                  );
                }
              },
              initialItemCount: state.groupPosts!.length,
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     print(
        //       state.groups![widget.index].groupId,
        //     );
        //     // bloc.assignGroupId(widget.id);
        //     nextScreen(
        //         context,
        //         AddPostPage(
        //           isFromGroup: true,
        //           groupId: state.groups![widget.index].groupId
        //           ,isBusiness: authB.isBusinessShared! ? true:false,
        //         ));
        //   },
        // ),
      );
    });
  }
  // Widget postWidget() {
  //   return ListView.builder(
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: 5,
  //     itemBuilder: (ctx, i) {
  //       if (i == 1) {
  //         return Card(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text("Peoples you may know"),
  //                 SingleChildScrollView(
  //                   scrollDirection: Axis.horizontal,
  //                   child: Row(
  //                     children: List.generate(4, (index) {
  //                       return const FriendSuggestionWidget();
  //                     }),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return PostWidget(
  //           privacy: "d.privacy",
  //           isFriend: 'default',
  //           postId: 'd',
  //           userId: "2",
  //           name: "Ameer Hamza",
  //           iamge: [],
  //           date: DateTime.now(),
  //           commentCount: '18',
  //           likeCount: '12k',
  //           profileName: "John Doe",
  //           profilePic:
  //           "https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg",
  //           isLiked: false,
  //           index: 0,
  //         );
  //       }
  //     },
  //   );
  // }
}
