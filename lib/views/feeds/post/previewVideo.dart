import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/post_cubit/post_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/feeds/post/video_edit_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';
class PreviewRecordVideo extends StatefulWidget {
  final String path;

  const PreviewRecordVideo({Key? key,required this.path}) : super(key: key);
  @override
  _PreviewRecordVideoState createState() => _PreviewRecordVideoState();
}

class _PreviewRecordVideoState extends State<PreviewRecordVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(File(widget.path))..initialize().then((value){
      controller.play();
      setState(() {});
    });


  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PostCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: InkWell(
                  onTap: (){
                    if(controller.value.isPlaying){
                      controller.pause();
                    }else{
                      controller.play();
                    }
                  },
                  child: VideoPlayer(controller)),
              ),
            ),
             Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: (){
                    bloc.addRecordedVideo(File(widget.path));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // nextScreen(context, VideoEditPage(path: widget.path,));
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: kSecendoryColor,
                    child: Icon(Icons.check,color: Colors.white,),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: ()=>Navigator.pop(context),
                icon: const Icon(Icons.clear,size: 40,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
