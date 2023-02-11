import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/components/universal_card.dart';

import '../see_profile_image.dart';
class ViewAllImagesPage extends StatefulWidget {
  final bool isMYPRofile;
  const ViewAllImagesPage({Key? key,required this.isMYPRofile}) : super(key: key);

  @override
  _ViewAllImagesPageState createState() => _ViewAllImagesPageState();
}

class _ViewAllImagesPageState extends State<ViewAllImagesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Photos",style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: UniversalCard(
        widget: widget.isMYPRofile ?
        SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            children: state.allMyPosts!.map((e){
              return InkWell(
                onTap: (){
                  nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}",title: e.profileName!,));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(15),
                    // ),
                  ),
                  child: ClipRRect(
                    // borderRadius: const BorderRadius.all(
                    //     Radius.circular(15)),
                      child: e.postType == 'image' ? e.postFiles == null || e.postFiles!.isEmpty? Container(): Image.network("${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}"): Container()
                  ),
                ),
              );
            }).toList(),
          ),
        ):StaggeredGrid.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          children: state.allOtherPhotos!.map((e){
            return InkWell(
              onTap: (){
                nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}",title: e.profileName!,));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(15),
                  // ),
                ),
                child: ClipRRect(
                  // borderRadius: const BorderRadius.all(
                  //     Radius.circular(15)),
                    child:e.postFiles == null || e.postFiles!.isEmpty ? Container(): Image.network("${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}")
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  },
);
  }
}
