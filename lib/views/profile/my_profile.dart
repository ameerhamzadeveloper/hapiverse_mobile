import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/components/profile_about_widget.dart';
import '../../views/components/universal_card.dart';
import '../../views/feeds/components/loading_post_widget.dart';
import '../../views/profile/settings/settings.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../routes/routes_names.dart';
import '../components/profile_Images_widget.dart';
import '../components/profile_data_Widget.dart';
import '../components/profile_friends_list.dart';
import '../feeds/components/post_widget.dart';
import '../feeds/components/text_feed_widget.dart';
import '../feeds/components/video_post_card.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool notNowClicked = false;
  var dateFormt = DateFormat('dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, 'PROFILE')!),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, health);
                  },
                  icon: const Icon(
                    LineIcons.heartbeat,
                    color: Colors.white,
                  )),
              IconButton(
                onPressed: () => nextScreen(context, ProfileSettings(isBusiness: false)),
                icon: const Icon(
                  LineIcons.cog,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: state.profileName == null ? UniversalCard(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: ()async{
                    return bloc.fetchMyPRofile(authBloc.userID!, authBloc.accesToken!);
                  },
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
                ),
              ))
              :RefreshIndicator(
            onRefresh: ()async{
              return bloc.fetchMyPRofile(authBloc.userID!, authBloc.accesToken!);
            },
                child: Column(
            children: [
                const SizedBox(height: 20,),
                Expanded(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )
                    ),
                    child: SingleChildScrollView(
                  child: Column(
                  children: [
                  ProfileDataWidet(isMyProfile: true,data: {
                    'name':state.profileName,
                    'hobbi':state.hobby,
                    'profile_url':"${Utils.baseImageUrl}${state.profileImage}",
                    'follower': state.followers,
                    'following':state.following,
                    'post':state.totalPost,
                    'IsFriend':'default',
                    'avatarType': state.avatarType,
                    'flatColor' : state.flatColor,
                    'profileImageText': state.profileImageText,
                    'secondgredientcolor': state.firstGredientColor,
                    'firstgredientcolor': state.secondGredientColor,
                    'hasVerified':state.hasVerified,
                    'badge' : state.badge,
                  },userId:authBloc.userID!,isBusiness: false,),
                    !state.notNowClieked ?  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Icon(LineIcons.edit),
                                // backgroundColor: Colors.grey[300],
                              ),
                              title: Text("Incomplete Profile"),
                              subtitle: Text("Let's Complete your profile info you didn't added yet"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      elevation: 0.0,
                                      color:Colors.grey[200],
                                      onPressed: (){
                                        bloc.setNotNowClicked();
                                      },
                                      child: Text("Not Now"),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: MaterialButton(
                                      elevation: 0.0,
                                      color: kSecendoryColor,
                                      onPressed: ()=> Navigator.pushNamed(context, editProfile),
                                      child: Text("Let’s complete your profile info",style: TextStyle(color: Colors.white),),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ):Container(),
                    state.covidRecordList == null || state.covidRecordList!.isEmpty ?Container(): Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            children: [
                              Text(getTranslated(context, 'COVID_19_STATUS')!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              state.covidRecordList!.last.covidStatus == 'Positive' ? Text( getTranslated(context, 'POSITIVE')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),):Text( getTranslated(context, 'NEGATIVE')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
                              IconButton(onPressed: (){
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )
                                  ),
                                    context: context,builder: (c){
                                  return Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          width: 30,
                                          height: 7,

                                        ),
                                        SizedBox(height: 20,),
                                        QrImage(
                                          data: 'https://qrco.de/bcr6ox',
                                          version: QrVersions.auto,
                                          gapless: true,
                                          // eyeStyle: QrEyeStyle(color: Colors.green,eyeShape: QrEyeShape.circle),
                                          // dataModuleStyle: QrDataModuleStyle(color: Colors.red,dataModuleShape: QrDataModuleShape.circle),
                                          size: 320,
                                          // embeddedImage: AssetImage(AssetConfig.kLogo),
                                          // gapless: false,
                                          // embeddedImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
                                          embeddedImageStyle: QrEmbeddedImageStyle(
                                            color: Colors.white,
                                            // size: Size(80, 80),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }, icon: Icon(LineIcons.qrcode))
                            ],
                          ),
                          Text("${getTranslated(context, 'EXPIRE_ON_19_MARCH')!} ${dateFormt.format(state.covidRecordList!.last.date!)}"),
                          Divider(),
                        ],
                      ),
                    ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileAboutInfo(isMyProfie: true,data: {
                          'country':"${state.city} ${state.country}",
                          'dobFormat': state.dateOfBirth,
                          'replationship':state.relationShip,
                          'religion': state.religion,
                          'height': state.height,
                          'workName': state.workName,
                          'workTitle': state.workTitle,
                          'workStartDate': state.workStartDate,
                          'workEndDate': state.workEndDate,
                          'currentlyWorking': state.currentlyWorking,
                          'workLocation': state.workLocation,
                          'workDescription': state.workDescription,
                          'educationTitle': state.educationName,
                          'educationStartDate': state.educationStartYear,
                          'educationEndDate': state.educationEndYaer,
                          'educationLevel': state.educationLevel,
                          'educationLocation': state.educationLocation,
                          'currentlyReading': state.currentlyReading,
                        },userId:authBloc.userID!),
                        Divider(),
                        SizedBox(height: 10,),
                        ProfileFriendsList(isMYProfile: true,),
                        ProfileImagesWidget(isMyProfile: true,),
                        SizedBox(height: 10,),
                        Text("All Posts"),
                        Divider(),
                        state.allMyPosts == null ? LoadingPostWidget():state.allMyPosts!.isEmpty ? Center(child: Text("No Posts"),):
                        Container(
                          color: Colors.grey[200],
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx,i){
                              var data = state.allMyPosts![i];
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
                              if(state.allMyPosts![i].postType == 'image'){
                                return PostWidget(
                                  typeId: data.userTypeId,
                                  isFriend: 'Friend',
                                  postId: data.postId,
                                  name: data.caption,
                                  iamge: data.postFiles!,
                                  date: data.postedDate,
                                  commentCount: data.totalComment.toString(),
                                  likeCount: data.totalLike.toString(),
                                  profileName: state.profileName!,
                                  profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                                  isLiked: false,
                                  index: i,
                                  userId: data.userId,
                                  privacy: data.privacy,
                                  onLikeTap: (){
                                    // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                                  },
                                  hasVerified: data.hasVerified,
                                );
                              }else if(state.allMyPosts![i].postType == 'text'){
                                return TextFeedsWidget(
                                  userTypeId: data.userTypeId,
                                  index: i,
                                  userId: data.userId,
                                  commentOntap: (){},
                                  postId: data.postId,
                                  onTap: (){},
                                  name: data.postContentText!,
                                  bgImage: data.textBackGround ?? "",
                                  commentCount: data.totalComment.toString(),
                                  date: data.postedDate,
                                  likeCount: data.totalLike.toString(),
                                  profileName: state.profileName!,
                                  profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                                  fontColor: data.fontColor!,
                                  isFriend: 'Friend',
                                  onLikeTap: (){

                                    // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                                  },
                                  hasVerified: data.hasVerified,
                                  isLiked: false,
                                );
                              }else if(state.allMyPosts![i].postType == 'video'){
                                if(data.postFiles!.isNotEmpty){
                                  return VideoPostCard(
                                    userTypeid: data.userTypeId,
                                    isLiked: true,
                                    postId: data.postId,
                                    name: data.caption,
                                    iamge: "${Utils.baseImageUrl}${data.postFiles![0].postFileUrl}",
                                    date: data.postedDate,
                                    commentCount: data.totalComment.toString(),
                                    likeCount: data.totalLike.toString(),
                                    profileName:state.profileName!,
                                    profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                                    videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                                    userId: data.userId,
                                    index: i,
                                    isFriend: 'Friend',
                                    onLikeTap: (){
                                      // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                                    },
                                    hasVerified: data.hasVerified,
                                  );
                                }else{
                                  return Container();
                                }

                              }else{
                                return Container();
                              }
                              // }
                            },
                            itemCount: state.allMyPosts!.length,
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
    );
  }
}
