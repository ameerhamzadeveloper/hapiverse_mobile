import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../views/components/profile_Images_widget.dart';
import '../../../views/components/profile_about_widget.dart';
import '../../../views/components/profile_data_Widget.dart';
import '../../../views/components/profile_friends_list.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../components/universal_card.dart';
import '../components/loading_post_widget.dart';
import '../components/post_widget.dart';
import '../components/text_feed_widget.dart';
import '../components/video_post_card.dart';

class OtherProfilePage extends StatefulWidget {
  final String userId;
  const OtherProfilePage({Key? key,required this.userId}) : super(key: key);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        if(state.otherProfileInfoResponse == null){
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Expanded(
                    child: UniversalCard(
                        widget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: getWidth(context),),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey[200],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 20,
                                width: 150,
                                color: Colors.grey[200],
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 10,
                                width: 100,
                                color: Colors.grey[200],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        }else{
          var json = jsonDecode(state.otherProfileInfoResponse!.body);
          var d = json['data'];
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: Colors.black,),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Expanded(
                    child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)
                            ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfileDataWidet(isMyProfile: false,data: {
                                'name':d['userName'] ?? "",
                                'hobbi':"football",
                                'profile_url':"${Utils.baseImageUrl}${d['profileImageUrl']}",
                                'follower': d['follower'],
                                'following':d['following'],
                                'post': d['totalPosts'],
                                'IsFriend': d['IsFriend'],
                                'avatarType':d['avatarType'],
                                'flatColor':d['flatColor'],
                                'profileImageText':d['profileImageText'],
                                'firstgredientcolor':d['firstgredientcolor'],
                                'secondgredientcolor':d['secondgredientcolor'],
                                'hasVerified':d['hasVerified'],
                              },userId: d['userId'],isBusiness: false,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileAboutInfo(isMyProfie: false,data:{
                                      'country':d['country'],
                                      'dobFormat': d['DOB'],
                                      'replationship':d['martialStatus'],
                                      'educationTitle':d['education'] == null ? "":d['education'][0]['title'],
                                      'educationLevel':d['education'] == null ? "":d['education'][0]['level'],
                                      'educationStartDate':d['education'] == null ? "":d['education'][0]['startDate'],
                                      'educationLocation':d['education'] == null ? "":d['education'][0]['location'],
                                      'educationEndDate':d['education'] == null ? "":d['education'][0]['endDate'],
                                      'currentlyReading':d['education'] == null ? "":d['education'][0]['currently_studying'],
                                      'workTitle':d['occupation'] == null ? "" : d['occupation'][0]['title'] ?? "",
                                      'workDescription':d['occupation'] == null ? "": d['occupation'][0]['description'],
                                      'workStartDate':d['occupation'] == null ? "": d['occupation'][0]['startDate'],
                                      'currentlyWorking':d['occupation'] == null ? "": d['occupation'][0]['current_working'],
                                      'workEndDate':d['occupation'] == null ? "": d['occupation'][0]['endDate'],
                                      'workLocation':d['occupation'] == null ? "": d['occupation'][0]['location'],
                                      'height':d['height'] ?? "",
                                      'religion':d['religion'] ?? "",
                                    },userId: d['userId'],),
                                    const ProfileFriendsList(isMYProfile: false,),
                                    const ProfileImagesWidget(isMyProfile: false,),
                                    const SizedBox(height: 10,),
                                    const Text("All Posts"),
                                    const Divider(),
                                    state.allOtherPosts == null ? LoadingPostWidget():state.allOtherPosts!.isEmpty ? const Center(child: Text("No Posts"),):
                                    Container(
                                      color: Colors.grey[200],
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (ctx,i){
                                          var data = state.allOtherPosts![i];
                                          // if(i == 1){
                                          //   return Card(
                                          //     child: Padding(
                                          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           const SizedBox(height: 10,),
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
                                            if(state.allOtherPosts![i].postType == 'image'){
                                              if(state.allOtherPosts![i].postFiles!.isNotEmpty){
                                                return PostWidget(
                                                  typeId: data.userTypeId,
                                                  hasVerified: data.hasVerified,
                                                  isFriend: 'Friend',
                                                  postId: data.postId,
                                                  name: data.caption,
                                                  iamge: data.postFiles!,
                                                  date: data.postedDate,
                                                  commentCount: data.totalComment.toString(),
                                                  likeCount: data.totalLike.toString(),
                                                  profileName: d['userName'],
                                                  profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                                                  isLiked: false,
                                                  index: i,
                                                  userId: data.userId,
                                                  privacy: data.privacy,
                                                  onLikeTap: (){
                                                    // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                                                  },
                                                );
                                              }else{
                                                return Container();
                                              }
                                            }else if(state.allOtherPosts![i].postType == 'text'){
                                              return TextFeedsWidget(
                                                userTypeId: data.userTypeId,
                                                hasVerified: data.hasVerified,
                                                index: i,
                                                userId: data.userId,
                                                commentOntap: (){},
                                                postId: data.postId,
                                                onTap: (){},
                                                name: data.postContentText!,
                                                bgImage: data.textBackGround ?? "0",
                                                commentCount: data.totalComment.toString(),
                                                date: data.postedDate,
                                                likeCount: data.totalLike.toString(),
                                                profileName: d['userName'],
                                                profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                                                fontColor: data.fontColor!,
                                                isFriend: 'Friend',
                                                onLikeTap: (){

                                                  // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                                                },
                                                isLiked: false,
                                              );
                                            }else if(state.allOtherPosts![i].postType == 'video'){
                                              if(state.allOtherPosts![i].postFiles!.isNotEmpty){
                                                return VideoPostCard(
                                                  userTypeid: data.userTypeId,
                                                  hasVerified: data.hasVerified,
                                                  isLiked: true,
                                                  postId: data.postId,
                                                  name: data.caption,
                                                  iamge: "${Utils.baseImageUrl}${data.postFiles![0].postFileUrl}",
                                                  date: data.postedDate,
                                                  commentCount: data.totalComment.toString(),
                                                  likeCount: data.totalLike.toString(),
                                                  profileName:d['userName'],
                                                  profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                                                  videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                                                  userId: data.userId,
                                                  index: i,
                                                  isFriend: 'Friend',
                                                  onLikeTap: (){
                                                    // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                                                  },
                                                );
                                              }else{
                                                return Container();
                                              }
                                            }else{
                                              return Container();
                                            }
                                          // }
                                        },
                                        itemCount: state.allOtherPosts!.length,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          );
        }

      }
    );
  }
}
