import 'dart:async';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/feeds/other_profile/other_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../comments_page.dart';

class VideoPostCard extends StatefulWidget {
  String name;
  String iamge;
  String likeCount;
  String commentCount;
  String profileName;
  DateTime date;
  String profilePic;
  String postId;
  String? videothumb;
  String userId;
  final VoidCallback? onLikeTap;
  final VoidCallback? commentOntap;
  final String isFriend;
  int index;
  final bool isLiked;
  String hasVerified;
  String userTypeid;
  VideoPostCard(
      {required this.name,
      required this.iamge,
      required this.date,
      required this.commentCount,
      required this.likeCount,
      required this.profileName,
      required this.profilePic,
      required this.postId,
      this.onLikeTap,
      this.commentOntap,
      this.videothumb,
      required this.userId,
      required this.index,
      required this.isLiked,
      required this.isFriend,
        required this.userTypeid,
        required this.hasVerified
      });

  @override
  State<VideoPostCard> createState() => _VideoPostCardState();
}

class _VideoPostCardState extends State<VideoPostCard> {
  late VideoPlayerController controller;
   FlickManager? flickManager;

  bool isObserved = false;

  final UniqueKey stickyKey = UniqueKey();

  bool isControllerReady = false;

  bool isPlaying = false;

  Completer videoPlayerInitializedCompleter = Completer();

  getViewAspectRatio(){
    // controller = VideoPlayerController.network(widget.iamge)..initialize();
    // print("Ratio--------- ${controller.value.aspectRatio}");
    // return controller.value.aspectRatio;
    isObserved = true;
    print("video ur; ${widget.iamge}");
    try{

      flickManager = FlickManager(
          videoPlayerController:
          VideoPlayerController.network(widget.iamge),
          autoPlay: true,
      );
    }catch(e){
      print("Video Error $e");
    }
  }

  showBottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (
          ctx,
        ) {
          return Container(
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  LineIcons.checkCircle,
                  size: 50,
                  color: kUniversalColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Thanks for letting us know",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "your feedback is important in helping us keep the hapiverse community safe",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SecendoryButton(
                      text: "Done",
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          );
        },
    );
  }

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // controller.play();
  //   flickManager!.flickControlManager!.play();
  //   print("Did Scroll CAlled");
  //   isObserved = true;
  // }

  @override
  void dispose() async{
    super.dispose();

    if (flickManager != null){
      await flickManager?.dispose()?.then((_) {
        isControllerReady = false;
        videoPlayerInitializedCompleter = Completer(); // resets the Completer
      });
    }
  }
  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  //   print("Diactivated Scroll CAlled");
  //   flickManager?.flickControlManager!.pause();
  //   isObserved = false;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getViewAspectRatio();
  }


  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    var color = Colors.grey[300];
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(builder: (context, state) {
      return VisibilityDetector(
        onVisibilityChanged: (VisibilityInfo info){
          print(info.visibleFraction);
          print(info.size);
          print(info.visibleBounds.size);
          if (info.visibleFraction > 0.70) {
            if (flickManager == null) {
              flickManager = FlickManager(
                videoPlayerController:
                VideoPlayerController.network(widget.iamge),
                autoPlay: true,
                autoInitialize: true
              );
              videoPlayerInitializedCompleter.complete(true);
              setState(() {
                isControllerReady = true;
              });
            }
          }else if(info.visibleFraction < 0.30){
            setState(() {
              isControllerReady = false;
            });
            flickManager?.flickControlManager?.pause();
            setState(() {
              isPlaying = false;
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              flickManager?.flickControlManager?.dispose();
              setState(() {
                flickManager = null;
                videoPlayerInitializedCompleter = Completer(); // resets the Completer
              });
            });
          }
        },
        key: stickyKey,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if(widget.userTypeid == "1"){
                              profileBloc.fetchOtherProfile(
                                  widget.userId, authBloc.accesToken!, authBloc.userID!);
                              profileBloc.fetchOtherAllPost(
                                  widget.userId, authBloc.accesToken!, authBloc.userID!);
                              profileBloc.getOtherFriends(
                                  authBloc.userID!, authBloc.accesToken!, widget.userId);
                              nextScreen(context, OtherProfilePage(userId: widget.userId));
                            }
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(widget.profilePic),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.profileName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 20),
                                      ),
                                      widget.hasVerified == '1'? Image.asset(AssetConfig.verified,height: 20,):Container()
                                    ],
                                  ),
                                  Text(
                                    "${dF.format(widget.date)} at ${tF.format(widget.date)}",
                                    style: TextStyle(color: kSecendoryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: widget.isFriend == 'default' || widget.isFriend == 'Follow'
                                          ? 200
                                          : 280,
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: color,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Clipboard.setData(ClipboardData(
                                                      text:
                                                          "https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts"));
                                                  Fluttertoast.showToast(
                                                      msg: "Link Coppied");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: color),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Icon(LineIcons.link),
                                                        Text("Copy Link")
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15.0),
                                                      ),
                                                      context: context,
                                                      builder: (ctx) {
                                                        return Container(
                                                          // height: 200,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  width: 40,
                                                                  height: 5,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10),
                                                                    color: color,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Report",
                                                                  style: TextStyle(
                                                                      fontSize: 18),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Divider(),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "Why are you reporting this post?",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      Text(
                                                                          "Posts are shown in feeds based on many things include your interest your location based your activity based.",
                                                                          style: TextStyle(
                                                                              color:
                                                                                  Colors.grey)),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "It's spam"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "Nudity or sexual activity"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "I just don't like it"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "Nudity or sexual activity"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "Hate speech or symbols"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "False information"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                ListTile(
                                                                  onTap: () {
                                                                    showBottom(
                                                                        context);
                                                                  },
                                                                  title: Text(
                                                                      "Scam or fraud"),
                                                                  trailing: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color:
                                                                        Colors.grey,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: color),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          LineIcons
                                                              .exclamationCircle,
                                                          color: Colors.red,
                                                        ),
                                                        Text("Report")
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Share.share(
                                                      "https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: color),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 40,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            color: color,
                                                          ),
                                                        ),
                                                        Icon(LineIcons.shareSquare),
                                                        Text("Share")
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15.0),
                                                ),
                                                context: context,
                                                builder: (ctx) {
                                                  return Container(
                                                    height: 200,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: 40,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            color: color,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Why you're seeing this post",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Divider(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                "Posts are shown in feeds based on many things include your interest your location based your activity based.",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                textAlign: TextAlign
                                                                    .center,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: color,
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Center(
                                                child: Text(
                                                    "Why you're seeing this post")),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      widget.isFriend == 'default' || widget.isFriend == 'Follow'
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  bloc.unfollow(widget.index, widget.profileName);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: color,
                                                  ),
                                                  padding: const EdgeInsets.all(12),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        color: color,
                                                      ),
                                                      padding: EdgeInsets.all(12),
                                                      child: Center(
                                                          child: Text("Unfollow")),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // nextScreen(
                      //     context,
                      //     PlayVideo(
                      //       url: widget.iamge,
                      //       profileName: widget.profileName,
                      //       profileImage: widget.profilePic,
                      //       time: "${dF.format(widget.date)} at ${tF.format(widget.date)}",
                      //       caption: widget.name,
                      //       ref: widget.postId,
                      //       index: widget.index,
                      //       postId: widget.postId,
                      //       userId: widget.userId,
                      //       VideoPlayerController: controller,
                      //     ));
                    },
                    child: FutureBuilder(
                      future: videoPlayerInitializedCompleter.future,
                      builder: (context,snapshot) {
                        if(snapshot.connectionState == ConnectionState.done && flickManager != null && isControllerReady){
                  return FlickVideoPlayer(
                  flickManager: flickManager!,
                  wakelockEnabled: true,
                  );
                  }else{
                          return Container(color:Colors.black,child: Center(child: CircularProgressIndicator()),height: getHeight(context) / 3 ,);
                        }
                      }
                    ),
                    // AspectRatio(
                    //   aspectRatio: controller.value.aspectRatio,
                    //   child: Chewie(
                    //     controller: ChewieController(
                    //       videoPlayerController: controller,
                    //       aspectRatio: controller.value.aspectRatio,
                    //       autoInitialize: true,
                    //       autoPlay: false,
                    //       looping: false,
                    //       allowFullScreen: false,
                    //       allowMuting: true,
                    //       // aspectRatio: controller.value.aspectRatio,
                    //       errorBuilder: (context, errorMessage) {
                    //         return Center(
                    //           child: Text(
                    //             errorMessage,
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // old post code
                    /*child: Container(
                      height: getHeight(context) / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(videothumb!))),
                      child: Center(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: kUniversalColor,
                            )),
                      ),
                    ),*/
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name),
                        state.translatedText == null
                            ? Container()
                            : Text(state.translatedText!),
                        widget.name == null || widget.name == ''
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  print(widget.name);
                                  bloc.translateText(widget.name);
                                },
                                child: Text(
                                  "See Translation",
                                  style: TextStyle(color: Colors.grey),
                                )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: widget.onLikeTap,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(
                                      LineIcons.thumbsUpAlt,
                                      color:
                                          widget.isLiked ? kUniversalColor : Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  NumberFormat.compact()
                                      .format(int.parse(widget.likeCount)),
                                  style: TextStyle(
                                      color:
                                          widget.isLiked ? kUniversalColor : Colors.grey),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CommentPage(
                                                  postId: widget.postId,
                                              userId: widget.userId,
                                                )));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(
                                      LineIcons.facebookMessenger,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  NumberFormat.compact()
                                      .format(int.parse(widget.commentCount)),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Share.share(
                                    "https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  LineIcons.share,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
