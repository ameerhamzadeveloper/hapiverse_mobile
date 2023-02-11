import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../logic/feeds/feeds_cubit.dart';
import '../../utils/utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';

import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import '../components/secondry_button.dart';

class PlayVideo extends StatefulWidget {
  final String url;
  final String profileName;
  final String profileImage;
  final String time;
  final String caption;
  final String ref;
  final int index;
  final String postId;
  final String userId;
  final VideoPlayerController;

  const PlayVideo(
      {Key? key,
      required this.url,
      required this.profileName,
      required this.profileImage,
      required this.time,
      required this.caption,
      required this.ref,
      required this.index,required this.postId,required this.userId,required this.VideoPlayerController})
      : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController controller;
  late Duration total = Duration();
  late Duration progress = Duration();
  bool isLoading = true;

  bool isProgressOpen = true;
  progressOpenClose(){
    if(isProgressOpen == true){
      Future.delayed(Duration(seconds: 3),(){
        setState(() {
          isProgressOpen = false;
        });
      });
    }else{
      setState(() {
        isProgressOpen = true;
      });
    }
  }

  showBottom(BuildContext context){
    showModalBottomSheet(context: context, builder: (ctx,){
      return Container(
        height: 300,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10,),
            Icon(LineIcons.checkCircle,size: 50,color: kUniversalColor,),
            SizedBox(height: 10,),
            Text("Thanks for letting us know",style: TextStyle(fontSize: 22),),
            SizedBox(height: 10,),
            Text("your feedback is important in helping us keep the hapiverse community safe",style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SecendoryButton(text: "Done", onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }),
            )
          ],
        ),
      );
    });
  }


  setValues() async {}
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(widget.url),
      // aspectRatio:5/8,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      allowFullScreen: false,
      allowMuting: true,
      aspectRatio: controller.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    print("Video Url ${widget.url}");
    final authB = context.read<RegisterCubit>();
    final feedsB = context.read<FeedsCubit>();
    feedsB.fetchFeedsComments(authB.userID!, authB.accesToken!, widget.postId);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    TextEditingController message = TextEditingController();
    final authB = context.read<RegisterCubit>();
    final feedsB = context.read<FeedsCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios)),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, otherProfile),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.profileImage),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.profileName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    widget.time,
                                    style: TextStyle(color: kSecendoryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_down_outlined))
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.caption),
              ),

              // old video player code
              // AspectRatio(
              //   aspectRatio: controller.value.aspectRatio,
              //   child: Stack(
              //     children: [
              //       InkWell(
              //           onTap: () {
              //             progressOpenClose();
              //             if(controller.value.isPlaying){
              //               controller.pause();
              //             }else{
              //               controller.play();
              //             }
              //           },
              //           child: VideoPlayer(controller)),
              //       Align(
              //         alignment: Alignment.bottomCenter,
              //         child: isProgressOpen ? Padding(
              //           padding: const EdgeInsets.all(12.0),
              //           child: ProgressBar(
              //             progress: progress,
              //             total: total,
              //             onSeek: (duration) {
              //               print('User selected a new time: $duration');
              //               controller.seekTo(duration);
              //             },
              //           ),
              //         ) :Container(),
              //       ),
              //       isLoading
              //           ? Align(
              //               alignment: Alignment.center,
              //               child: CircularProgressIndicator(),
              //             )
              //           : Align(
              //               alignment: Alignment.center,
              //               child: controller.value.isPlaying
              //                   ? Container()
              //                   : IconButton(
              //                       onPressed: () => controller.play(),
              //                       icon: const Icon(
              //                         Icons.play_arrow,
              //                         size: 40,
              //                         color: kUniversalColor,
              //                       ),
              //                     ),
              //             )
              //     ],
              //   ),
              // ),
              _chewieController == null ? Container():Chewie(
                controller: _chewieController,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            feedsB.addLikeDislike(authB.userID!, authB.accesToken!, state.feedsPost![widget.index].postId!, widget.index,state.feedsPost![widget.index].userId!);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              LineIcons.thumbsUpAlt,
                              color: state.feedsPost![widget.index].isLiked! ? kUniversalColor : Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          state.feedsPost![widget.index].totalLike!,
                          style: TextStyle(color:state.feedsPost![widget.index].isLiked! ? kUniversalColor : Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              LineIcons.facebookMessenger,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        LineIcons.share,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Comments"),
              ),
              Divider(),
              state.postCommentMap == null || state.postCommentMap!.isEmpty ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: getWidth(context) / 2,),
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                              image: NetworkImage(
                                  "https://freepikpsd.com/file/2019/10/comment-png-icon-8-1-Transparent-Images.png"
                              )
                          )
                      ),
                    ),
                    const Text("No Commnet Yet", style: TextStyle(
                        color: Colors.grey),),
                  ],
                ),
              ):
              ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx,i){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.postCommentMap![i].profileImageUrl!}"),
                    ),
                    title: Text(state.postCommentMap![i].userName!),
                    subtitle: Text(state.postCommentMap![i].comment!),
                    trailing: IconButton(
                      onPressed: (){
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            context: context,
                            builder: (ctx){
                              return Container(
                                height: authB.userID == state.postCommentMap![i].userId ? 250 : 200,
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Expanded(child: InkWell(
                                          onTap:(){
                                            Clipboard.setData(ClipboardData(text: state.postCommentMap![i].comment));
                                            Fluttertoast.showToast(msg: "Text Copied");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.grey[300]
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Icon(LineIcons.copy),
                                                  Text("Copy")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(child: InkWell(
                                          onTap: (){
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                ),
                                                context: context, builder: (ctx){
                                              return Container(
                                                // height: 200,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10,),
                                                      Container(
                                                        width: 40,
                                                        height: 5,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.grey[300],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Text("Report",style: TextStyle(fontSize: 18),),
                                                      SizedBox(height: 10,),
                                                      Divider(),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Why are you reporting this post?",style: TextStyle(fontSize: 18),),
                                                            SizedBox(height: 10,),
                                                            Text("Posts are shown in feeds based on many things include your interest your location based your activity based.",
                                                                style: TextStyle(color: Colors.grey)),
                                                            SizedBox(height: 10,)
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("It's spam"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                      ),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("Nudity or sexual activity"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                      ),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("I just don't like it"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                      ),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("Nudity or sexual activity"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                      ),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("Hate speech or symbols"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                      ),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("False information"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                      ),
                                                      Divider(),
                                                      ListTile(
                                                        onTap: (){
                                                          showBottom(context);
                                                        },
                                                        title: Text("Scam or fraud"),
                                                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
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
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.grey[300]
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Icon(LineIcons.exclamationCircle,color: Colors.red,),
                                                  Text("Report")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    authB.userID == state.postCommentMap![i].userId ? Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300],
                                      ),
                                      padding: EdgeInsets.all(12),
                                      child: Center(child: Text("Edit")),
                                    ):Container(),
                                    SizedBox(height: 10,),
                                    authB.userID == state.postCommentMap![i].userId ?Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300],
                                      ),
                                      padding: EdgeInsets.all(12),
                                      child: Center(child: Text("Delete",style: TextStyle(color: Colors.red),)),
                                    ):Container(),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                  );
                },
                itemCount: state.postCommentMap!.length,
              ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: AutoSizeTextField(
                          maxLines: null,
                          controller: message,
                          onChanged: (val) {
                            text = val;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write Something',
                            suffixIcon: IconButton(
                              onPressed: () {
                                feedsB.addPostComment(authB.userID!, authB.accesToken!, widget.postId, message.text,widget.userId);
                                message.clear();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: kUniversalColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
