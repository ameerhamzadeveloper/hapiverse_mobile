
import 'dart:io';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/post_cubit/post_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/utils.dart';
import '../../../views/feeds/comments_page.dart';
import '../../../views/feeds/other_profile/other_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../profile/see_profile_image.dart';
import '../post/edit_post.dart';
class MyPostImageWidget extends StatefulWidget {
  String name;
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

  MyPostImageWidget({required this.name,
    required this.date,required this.commentCount,
    required this.likeCount,required this.profileName,
    required this.profilePic,required this.postId,this.onLikeTap,this.commentOntap,
    required this.isLiked,required this.index,required this.userId});

  @override
  State<MyPostImageWidget> createState() => _MyPostImageWidgetState();
}

class _MyPostImageWidgetState extends State<MyPostImageWidget> {
  int currentIndex = 0;
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    var color = Colors.grey[300];
    final feedsBloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    final postBloc = context.read<PostCubit>();
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Container(
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
                          profileBloc.fetchOtherProfile(widget.userId, authBloc.accesToken!,authBloc.userID!);
                          profileBloc.fetchOtherAllPost(widget.userId, authBloc.accesToken!,authBloc.userID!);
                          nextScreen(context, OtherProfilePage(userId: widget.userId));
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
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${dF.format(widget.date)} at ${tF.format(widget.date)}",
                                  style: TextStyle(color: kSecendoryColor,fontSize: 12),
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
                                height: 300,
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
                                          Expanded(child: Container(
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
                                          SizedBox(width: 10,),
                                          // Expanded(child: Container(
                                          //   padding: EdgeInsets.all(10),
                                          //   decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(10),
                                          //       color: color
                                          //   ),
                                          //   child: Center(
                                          //     child: Column(
                                          //       children: [
                                          //         Icon(LineIcons.exclamationCircle,color: Colors.red,),
                                          //         Text("Report")
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          // ),
                                          SizedBox(width: 10,),
                                          Expanded(child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: color
                                            ),
                                            child: InkWell(
                                              onTap:(){
                                                // Share.share("$name \n\n$iamge \nhttps://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/");
                                              },
                                              child: Center(
                                                child: Column(
                                                  children: [
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
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    //   child: Container(
                                    //     width: double.infinity,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       color: color,
                                    //     ),
                                    //     padding: EdgeInsets.all(12),
                                    //     child: Center(child: Text("Why you're seeing this post")),
                                    //   ),
                                    // ),
                                    // SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: color,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: InkWell(
                                                onTap: (){
                                                  // feedsBloc.hidePost(widget.index);
                                                  // state.feedsPost!.removeAt(index);
                                                  nextScreen(context, EditLocalPost(postType: "image",isBusiness: authBloc.isBusinessShared! ? true: false,));
                                                  // Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: color,
                                                  ),
                                                  padding: EdgeInsets.all(12),
                                                  child: Center(child: Text("Edit")),
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                            InkWell(
                                              onTap: (){
                                                // Future.delayed(Duration(milliseconds: 100),(){
                                                // });
                                                showDialog(
                                                  // useSafeArea: true,
                                                    context: context, builder: (c){
                                                  return CupertinoAlertDialog(
                                                    title: Text("Delete your post"),
                                                    content: Text("Deleting your post will be remove from everywhere will not be visible to anyone or you"),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                          child: Text("Cancel"),
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          }
                                                      ),
                                                      CupertinoDialogAction(
                                                        child: Text("Delete",style: TextStyle(color: Colors.red),),
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                          // Navigator.pop(context);
                                                          showDialog(
                                                            // useSafeArea: true,
                                                              context: context, builder: (c){
                                                            return const CupertinoAlertDialog(
                                                              content: CupertinoActivityIndicator(),
                                                          );});
                                                          postBloc.deletePostServer(authBloc.userID!, authBloc.accesToken!,context);
                                                        }
                                                      )
                                                    ],
                                                  );
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: color,
                                                  ),
                                                  padding: EdgeInsets.all(12),
                                                  child: Center(child: Text("Delete")),
                                                ),
                                              ),
                                            ),
                                          ],
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
                state.showImages!.length > 4 ? Column(
                  children: [
                    CarouselSlider(
                      items: state.showImages!.map((e){
                        return InkWell(
                          onTap: (){
                            // nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${e.postFileUrl}",title: widget.profileName,));
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
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    child: Image.file(File(e),fit: BoxFit.fill,)
                                ),
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
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(state.showImages!.length, (index) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.circle,color: currentIndex == index ?Colors.black: Colors.grey,size: 10,),
                      )),
                    ),
                  ],
                ):StaggeredGrid.count(
                  crossAxisCount: state.showImages!.length == 1 ? 1 : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  children: state.showImages!.map((e){
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(15)),
                          child: Image.file(File(e),fit: BoxFit.fill,)
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isLike = !isLike;
                                  });
                                  feedsBloc.addMyLikePost(authBloc.userID!, authBloc.accesToken!, widget.postId,);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    LineIcons.thumbsUpAlt,
                                    color: isLike ? kUniversalColor : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(
                                isLike ? "1":"0",
                                style: TextStyle(color:isLike ? kUniversalColor : Colors.grey),
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
                                widget.commentCount,
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
