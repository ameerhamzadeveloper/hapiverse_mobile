import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_bubble/speech_bubble.dart';
import '../../../data/model/feeds_post_model.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/utils.dart';
import '../../../views/feeds/comments_page.dart';
import '../../../views/feeds/other_profile/other_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import 'package:flutter_share/flutter_share.dart';
import '../../components/secondry_button.dart';
import '../../profile/see_profile_image.dart';
class PostWidget extends StatefulWidget {
  String name;
  List iamge;
  String likeCount;
  String commentCount;
  String profileName;
  DateTime date;
  String profilePic;
  String postId;
  String userId;
  final VoidCallback? onLikeTap;
  final VoidCallback? commentOntap;
  final bool isLiked;
  int index;
  String isFriend;
  String privacy;
  String typeId;
  String hasVerified;

  PostWidget({required this.name,required this.iamge,
    required this.date,required this.commentCount,
    required this.likeCount,required this.profileName,
    required this.typeId,
    required this.profilePic,required this.postId,this.onLikeTap,this.commentOntap,
    required this.isLiked,required this.index,required this.userId,required this.isFriend,required this.privacy,required this.hasVerified});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int currentIndex = 0;

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
  bool isSeen = false;

  @override
  void initState() {
    super.initState();
    print(isSeen);
    if(isSeen){
      print("image post widget ${widget.index}");
    }
    isSeen = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    var color = Colors.grey[300];
    final feedsBloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Padding(
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
                      onTap:() {
                        print(widget.typeId);
                        if(widget.typeId == '1'){
                          profileBloc.fetchOtherProfile(widget.userId, authBloc.accesToken!,authBloc.userID!);
                          profileBloc.fetchOtherAllPost(widget.userId, authBloc.accesToken!,authBloc.userID!);
                          profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,widget.userId);
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  widget.hasVerified == '1' ? Image.asset(AssetConfig.verified,height: 20,):Container()
                                ],
                              ),
                              Row(
                                children: [
                                  Text(widget.privacy == "???? Public" ? "🌎" : "🔒"),
                                  SizedBox(width: 5,),
                                  Text(
                                    "${dF.format(widget.date)} at ${tF.format(widget.date)}",
                                    style: TextStyle(color: kSecendoryColor,fontSize: 12),
                                  ),
                                ],
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
                            context: context, builder: (context){
                            return Container(
                              height: widget.isFriend == 'default' || widget.isFriend == 'Follow' ? 200 : 280,
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
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: InkWell(
                                          onTap:(){
                                            Clipboard.setData(ClipboardData(text: "https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts"));
                                            Fluttertoast.showToast(msg: "Link Coppied");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: color
                                            ),
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
                                                          color: color,
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
                                                color: color
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
                                        SizedBox(width: 10,),
                                        Expanded(child: InkWell(
                                          onTap:(){
                                            Share.share("https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: color
                                            ),
                                            child: Center(
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
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: InkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            context: context, builder: (ctx){
                                          return Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Container(
                                                  width: 40,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: color,
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Text("Why you're seeing this post",style: TextStyle(fontSize: 18),),
                                                SizedBox(height: 10,),
                                                Divider(),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10,),
                                                      Text("Posts are shown in feeds based on many things include your interest your location based your activity based.",
                                                        style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                                                      SizedBox(height: 10,)
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: color,
                                        ),
                                        padding: EdgeInsets.all(12),
                                        child: Center(child: Text("Why you're seeing this post")),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  widget.isFriend == 'Follow' ? Container() : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: color,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: color,
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Center(child: Text("Unfollow")),
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
                        icon: Icon(Icons.keyboard_arrow_down_outlined))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              widget.iamge.length > 4 ? Column(
                children: [
                  CarouselSlider(
                    items: widget.iamge.map((e){
                      return InkWell(
                        onTap: (){
                          nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${e.postFileUrl}",title: widget.profileName,));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15)),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                // fadeInDuration: Duration(seconds: 1),
                                // placeholder: (s,sf)=>Container(color: Colors.grey,height: getHeight(context) / 4,width: double.infinity,),
                                // imageErrorBuilder: (context, error, stackTrace) => Container(color: Colors.grey,),
                                  imageUrl: "${Utils.baseImageUrl}${e.postFileUrl}")
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      reverse: false,
                      viewportFraction: 1.0,
                      aspectRatio: 1,
                      onPageChanged: (v,i){
                        setState(() {
                          currentIndex = v;
                        });
                      }
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.iamge.length, (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.circle,color: currentIndex == index ?Colors.black: Colors.grey,size: 10,),
                    )),
                  ),
                ],
              ):
              StaggeredGrid.count(
                crossAxisCount: widget.iamge.length == 1 ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                children: widget.iamge.map((e){
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){
                          nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${e.postFileUrl}",title: widget.profileName,));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15)),
                              child: CachedNetworkImage(
                                  // fadeInDuration: Duration(seconds: 1),
                                  // placeholder: (s,sf)=>Container(color: Colors.grey,height: getHeight(context) / 4,width: double.infinity,),
                                  // imageErrorBuilder: (context, error, stackTrace) => Container(color: Colors.grey,),
                                  imageUrl: "${Utils.baseImageUrl}${e.postFileUrl}")
                          ),
                        ),
                      ),
                       Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap:(){
                            print(widget.profilePic);
                            showModalBottomSheet(context: context, builder: (context){
                              return Container(
                                color: Colors.white,
                                height: getHeight(context) / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text("Face Detected Found"),
                                        ],
                                      ),
                                      Divider(),
                                      ListTile(
                                        title: Text(widget.profileName),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(widget.profilePic),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              );
                            });
                          },
                          child: SpeechBubble(
                            color: kUniversalColor,
                            nipLocation: NipLocation.LEFT,
                            child: Text(
                              "${widget.profileName}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name),
                    state.translatedText == null ? Container():
                    Text(state.translatedText!),
                    widget.name == null || widget.name == ''? Container():InkWell(
                        onTap: (){
                          feedsBloc.translateText(widget.name);
                        },
                        child: Text("See Translation",style: TextStyle(color: Colors.grey),)),
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
                                  widget.isLiked ? CupertinoIcons.hand_thumbsup_fill : CupertinoIcons.hand_thumbsup,
                                  color: widget.isLiked ? kUniversalColor : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              NumberFormat.compact().format(int.parse(widget.likeCount)),
                              style: TextStyle(color:widget.isLiked ? kUniversalColor : Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(postId: widget.postId,userId: widget.userId,)));
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  LineIcons.facebookMessenger,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              NumberFormat.compact().format(int.parse(widget.commentCount)),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Share.share("https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts");
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
    );
  },
);
  }
}
