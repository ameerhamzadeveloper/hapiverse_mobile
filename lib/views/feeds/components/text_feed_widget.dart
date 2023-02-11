import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../views/feeds/other_profile/other_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../components/secondry_button.dart';
import '../comments_page.dart';
class TextFeedsWidget extends StatelessWidget {
  String name;
  String likeCount;
  String commentCount;
  String profileName;
  DateTime date;
  String profilePic;
  String postId;
  final VoidCallback? onTap;
  final VoidCallback? commentOntap;
  String bgImage;
  String userId;
  String userTypeId;
  String fontColor;
  String isFriend;
  int index;
  bool isLiked;
  final VoidCallback onLikeTap;
  String hasVerified;

  TextFeedsWidget({Key? key,required this.date,required this.commentOntap,
  required this.onTap,required this.likeCount,required this.postId,required this.name,
  required this.profileName,required this.commentCount,required this.profilePic,
required this.bgImage,required this.userId,
    required this.fontColor,required this.isFriend,required this.index,
    required this.userTypeId,
    required this.isLiked,required this.onLikeTap,required this.hasVerified}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    Color? color = Colors.grey[300];
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    final feedBloc = context.read<FeedsCubit>();
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
                      onTap:(){
                        if(userTypeId == '1'){
                          profileBloc.fetchOtherProfile(userId, authBloc.accesToken!,authBloc.userID!);
                          profileBloc.fetchOtherAllPost(userId, authBloc.accesToken!,authBloc.userID!);
                          profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,userId);
                          nextScreen(context, OtherProfilePage(userId: userId));
                        }
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(profilePic),
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
                                    profileName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  hasVerified == '1'? Image.asset(AssetConfig.verified,height: 20,):Container()
                                ],
                              ),
                              Text(
                                  "${dF.format(date)} at ${tF.format(date)}",
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
                            context: context, builder: (context){
                            return Container(
                              height: isFriend == 'default' || isFriend == 'Follow' ? 200 : 280,
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
                                  // Text(isFriend),
                                   isFriend == 'default' || isFriend == 'Follow' ? Container() : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: InkWell(
                                      onTap: (){
                                        feedBloc.unfollow(index,profileName);
                                        Navigator.pop(context);
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
              bgImage == null || bgImage == "" ? Padding(
                padding: const EdgeInsets.only(left:12.0),
                child: Row(
                  children: [
                    Text(name,style: TextStyle(color: fontColor == "1" ? Colors.white:Colors.black,fontSize: 19),),
                  ],
                ),
              ):Container(
                height: getHeight(context) / 4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit:BoxFit.fill,
                        image: AssetImage(
                          bgImage
                        )
                    )
                ),
                child: Center(child: Text(name,style: TextStyle(color: fontColor == "1" ? Colors.white:Colors.black),)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: onLikeTap,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  LineIcons.thumbsUpAlt,
                                  color: isLiked ? kUniversalColor : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              NumberFormat.compact().format(int.parse(likeCount)),
                              style: TextStyle(color:isLiked ? kUniversalColor : Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(postId: postId,userId: userId,)));
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
                              NumberFormat.compact().format(int.parse(commentCount)),
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
  }
}
