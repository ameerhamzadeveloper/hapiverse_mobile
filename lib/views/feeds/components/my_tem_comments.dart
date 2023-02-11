import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/post_cubit/post_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/profile/my_profile.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

import '../../components/secondry_button.dart';

class MyTempCommentsPage extends StatefulWidget {


  const MyTempCommentsPage({Key? key,}) : super(key: key);

  @override
  State<MyTempCommentsPage> createState() => _MyTempCommentsPageState();
}

class _MyTempCommentsPageState extends State<MyTempCommentsPage> {

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
  void initState() {
    super.initState();
    // final authB = context.read<RegisterCubit>();
    // final feedsB = context.read<FeedsCubit>();
    // feedsB.fetchFeedsComments(authB.userID!, authB.accesToken!, widget.postId);
  }
  @override
  Widget build(BuildContext context) {
    String text = '';
    TextEditingController message = TextEditingController();
    final authB = context.read<RegisterCubit>();
    final feedsB = context.read<FeedsCubit>();
    final postB = context.read<PostCubit>();
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, feedsSate) {
            return Scaffold(
              // resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("Add Comment"),
              ),
              body: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: state.myTemperaryComments.isEmpty ? Center(
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
                            leading: InkWell(
                              onTap: ()async{
                                // if(authB.userID == state.postCommentMap![i].userId){
                                //   nextScreen(context, const MyProfile());
                                // }else{
                                //   profileBloc.fetchOtherProfile(state.postCommentMap![i].userId!, authB.accesToken!,authB.userID!);
                                //   profileBloc.fetchOtherAllPost(state.postCommentMap![i].userId!, authB.accesToken!,authB.userID!);
                                //   nextScreen(context, OtherProfilePage(userId: state.postCommentMap![i].userId!));
                                // }

                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage("${Utils.baseImageUrl}${feedsSate.profileImage}"),
                              ),
                            ),
                            title: Text(feedsSate.profileName== null ? "":feedsSate.profileName!),
                            subtitle: Text(state.myTemperaryComments[i]),
                            trailing: IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    context: context,
                                    builder: (ctx){
                                      return Container(
                                        height: 200,
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
                                            const SizedBox(height: 10,),
                                             InkWell(
                                               onTap: (){
                                                 Clipboard.setData(ClipboardData(text: state.myTemperaryComments[i]));
                                                 Fluttertoast.showToast(msg: "Text Copied");
                                               },
                                               child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey[300],
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: Center(child: Text("Copy")),
                                            ),
                                             ),
                                            SizedBox(height: 10,),
                                            InkWell(
                                              onTap: (){
                                                postB.deleteFromMyTempComments(i);
                                                // feedsB.deleteComment(authB.userID!, authB.accesToken!, state.postCommentMap![i].postCommentId!, widget.postId);
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey[300],
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: Center(child: Text("Delete",style: TextStyle(color: Colors.red),)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(Icons.more_vert),
                            ),
                          );
                        },
                        itemCount: state.myTemperaryComments.length,
                      ),),
                      Wrap(
                        children: [
                          Card(
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
                                      // feedsB.addPostComment(authB.userID!, authB.accesToken!, widget.postId, message.text,widget.userId == authB.userID! ? "":widget.userId);
                                      postB.addMyPostTemperaryComments(text);
                                      // feedsB.addPostComment(authB.userID!, authB.accesToken!, widget.postId, message.text);
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
                        ],
                      )
                    ]
                ),
              ),
            );
          },
        );
      },
    );
  }
}
