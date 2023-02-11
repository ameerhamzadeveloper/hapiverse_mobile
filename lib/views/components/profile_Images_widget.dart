import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/utils.dart';
import '../../views/feeds/see_single_image_post.dart';
import '../../views/profile/components/view_all_images.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../utils/constants.dart';
import '../profile/see_profile_image.dart';

class ProfileImagesWidget extends StatelessWidget {
  final bool isMyProfile;
  const ProfileImagesWidget({Key? key,required this.isMyProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        if(isMyProfile){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'PHOTO')!,style: TextStyle(color: kUniversalColor),),
                  InkWell(
                    onTap: (){
                      nextScreen(context, ViewAllImagesPage(isMYPRofile: isMyProfile));
                    },
                    child: Text("View all",style: TextStyle(color: kUniversalColor),)),
                ],
              ),
              const SizedBox(height: 10,),
              state.allMyPhotos == null ? Center(
                child: const CupertinoActivityIndicator(),
              ):GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allMyPhotos!.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (ctx, i) {
                  if(state.allMyPhotos == null){
                    return InkWell(
                      // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                      child: Stack(
                        children: [
                          Card(
                            color: Colors.grey[400],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg")
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }else if(state.allMyPhotos!.isEmpty){
                    return Text("No Posts");
                  }else if(state.allMyPhotos![i].postFiles!.isEmpty){
                    return Image.network("https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                  }else{
                    if(state.allMyPhotos![i].postType == 'text'){
                      return Container();
                    }else if(state.allMyPhotos![i].postType == 'video'){
                      return Container();
                      // return Card(
                      //   color: Colors.white,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Container(
                      //     height: 80,
                      //     width: 80,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       // image: DecorationImage(
                      //       //     fit: BoxFit.cover,
                      //       //     image: FileImage(getVideoThumbnail("${Utils.baseImageUrl}${state.allMyPosts![i].postFiles![0].postFileUrl}"))
                      //       // ),
                      //     ),
                      //     child: Center(child: Text("video")),
                      //   ),
                      // );
                    }else{
                      if(state.allMyPhotos!.isEmpty){
                        return Column(
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Photos",style: TextStyle(color: kUniversalColor),),
                                InkWell(
                                    onTap: (){
                                      nextScreen(context, ViewAllImagesPage(isMYPRofile: isMyProfile));
                                    },
                                    child: Text("View all",style: TextStyle(color: kUniversalColor),)),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Center(child: Text("No Photos"),),
                          ],
                        );
                      }else{
                      return InkWell(
                        onTap: () {
                          nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${state.allMyPhotos![i].profileImageUrl!}",title: state.allMyPosts![i].profileName!,));
                          // nextScreen(context, SeeSingleImagePost(
                          //    postId: state.allMyPosts![i].postId,
                          //    profileImage: "${Utils.baseImageUrl}${state.allMyPosts![i].profileImageUrl!}",
                          //    profileName: state.allMyPosts![i].profileName!,
                          //    caption: state.allMyPosts![i].caption,
                          //    totalLike: state.allMyPosts![i].totalLike,
                          //     images: state.allMyPosts![i].postFiles!,
                          //     totalComments: state.allMyPosts![i].totalComment,
                          //     time: state.allMyPosts![i].postedDate,
                          // ));
                        },
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${Utils.baseImageUrl}${state.allMyPhotos![i].postFiles![0].postFileUrl}")
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    }
                  }
                },
              ),
            ],
          );
        }else{
          // others profile posts
          if(state.allOtherPhotos == null){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("Photos",style: TextStyle(color: kUniversalColor),),
                    InkWell(
                        onTap: (){
                          nextScreen(context, ViewAllImagesPage(isMYPRofile: isMyProfile));
                        },
                        child: Text("View all",style: TextStyle(color: kUniversalColor),)),
                  ],
                ),

                Center(child: CupertinoActivityIndicator(),),
              ],
            );
          }else{
            if(state.allOtherPhotos!.isEmpty){
              return Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Photos",style: TextStyle(color: kUniversalColor),),
                      InkWell(
                          onTap: (){
                            nextScreen(context, ViewAllImagesPage(isMYPRofile: isMyProfile));
                          },
                          child: Text("View all",style: TextStyle(color: kUniversalColor),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Center(child: Text("No Photos"),),
                ],
              );
        }else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Photos",style: TextStyle(color: kUniversalColor),),
                      InkWell(
                          onTap: (){
                            nextScreen(context, ViewAllImagesPage(isMYPRofile: isMyProfile));
                          },
                          child: Text("View all",style: TextStyle(color: kUniversalColor),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.allOtherPhotos!.length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (ctx, i) {
                      if(state.allOtherPhotos == null){
                        return InkWell(
                          // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                          child: Stack(
                            children: [
                              Card(
                                color: Colors.grey[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage("https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg")
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }else if(state.allOtherPhotos!.isEmpty){
                        return Text("No Posts");
                      }else if(state.allOtherPhotos![i].postFiles!.isEmpty){
                        return Image.network("https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                      }else{
                        if(state.allOtherPhotos![i].postType == 'text'){
                          return Container(child: Text("Text"),);
                        }else if(state.allOtherPhotos![i].postType == 'video'){
                          return const Card(
                            child: Center(
                              child: Text("Vidoe"),
                            ),
                          );
                          // return Card(
                          //   color: Colors.white,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(20)),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: FileImage(getVideoThumbnail("${Utils.baseImageUrl}${state.allOtherPosts![i].postFiles![0].postFileUrl}"))
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }else{
                          return InkWell(
                            onTap: (){
                              nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${state.allOtherPhotos![i].profileImageUrl!}",title: state.allOtherPosts![i].profileName!,));
                              // nextScreen(context, SeeSingleImagePost(
                              //   postId: state.allOtherPosts![i].postId,
                              //   profileImage: "${Utils.baseImageUrl}${state.allOtherPosts![i].profileImageUrl!}",
                              //   profileName: state.allOtherPosts![i].profileName!,
                              //   caption: state.allOtherPosts![i].caption,
                              //   totalLike: state.allOtherPosts![i].totalLike,
                              //   images: state.allOtherPosts![i].postFiles!,
                              //   totalComments: state.allOtherPosts![i].totalComment,
                              //   time: state.allOtherPosts![i].postedDate,
                              // ));
                            },
                            // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                            child: Stack(
                              children: [
                                Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage("${Utils.baseImageUrl}${state.allOtherPhotos![i].postFiles![0].postFileUrl}")
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              );
            }
          }
        }
      }
    );
  }
  getVideoThumbnail(String path)async{
    print("Function Called");
    String? videoThumb = await VideoThumbnail.thumbnailFile(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    print("video thumb $videoThumb");
    return videoThumb;
  }

}
