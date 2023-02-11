import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import '../../data/model/get_all_my_post_model.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../profile/see_profile_image.dart';
class SeeSingleImagePost extends StatefulWidget {

  final String profileName;
  final String profileImage;
  final String caption;
  final String postId;
  final List<PostFile> images;
  final String totalLike;
  final String totalComments;
  final DateTime time;
  const SeeSingleImagePost({Key? key,required this.postId,required this.profileImage,
  required this.profileName,required this.caption,required this.totalLike,required this.images,
  required this.totalComments,required this.time}) : super(key: key);

  @override
  _SeeSingleImagePostState createState() => _SeeSingleImagePostState();
}

class _SeeSingleImagePostState extends State<SeeSingleImagePost> {
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "${dF.format(widget.time)} at ${tF.format(widget.time)}",
                                    style: const TextStyle(color: kSecendoryColor),
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
                        icon: const Icon(Icons.keyboard_arrow_down_outlined))
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(widget.caption),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              StaggeredGrid.count(
                crossAxisCount: widget.images.length == 1 ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                children: widget.images.map((e){
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
                          child: Image.network("${Utils.baseImageUrl}${e.postFileUrl}")
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
