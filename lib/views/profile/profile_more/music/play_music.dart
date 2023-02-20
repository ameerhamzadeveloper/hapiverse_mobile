import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/profile/profile_cubit.dart';
import '../../../../utils/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayMusic extends StatefulWidget {
  final String url;
  final int length;
  final int index;
  const PlayMusic({Key? key,required this.url,required this.length,required this.index}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  void initState() {
    final bloc = context.read<ProfileCubit>();
    // print(bloc.musicIndex);
    print(widget.index);
    if(!bloc.isPlaying){
      bloc.playMusic(widget.url,widget.length,widget.index);
    }else if(bloc.musicIndex != widget.index){
      bloc.playMusic(widget.url,widget.length,widget.index);
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.forward();
    _controller.addListener(() {

      if(_controller.isCompleted){
        _controller.reset();
        _controller.forward();
        print("Compleeted");
      }
    });
    _controller.addStatusListener((status) {
      print(status);
      if(status == AnimationStatus.completed){
        _controller.forward();
      }
    });
    print("Called");
    super.initState();
    // final bloc = context.read<ProfileCubit>();
    // bloc.fetchMusic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: const Color(0xff2C2C2C).withOpacity(0.9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.keyboard_arrow_down,color:Colors.white,size: 30,)),
                    Expanded(child: Text(state.musicTitle,style: TextStyle(color: Colors.white),)),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Text("Artist ${state.musicArtist}",style: TextStyle(color: Colors.grey),),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 6,color: Colors.grey)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 30,color: Colors.black)
                    ),
                    child: Container(
                      height: getHeight(context) / 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            // fit: BoxFit.cover,
                              image: NetworkImage(
                                  state.musicImage
                              )
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(LineIcons.heart,color: Colors.white,),
                    ),
                    Text("Favorite",style: TextStyle(color: Colors.white),)
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    IconButton(
                      onPressed: ()=> Navigator.pop(context),
                      icon: Icon(LineIcons.list,color: Colors.white,),
                    ),
                    Text("List",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProgressBar(
                  progress: state.progress, total: state.musicLength,
                baseBarColor: Colors.white,
                thumbColor: Colors.white,
                progressBarColor: Colors.grey,
                timeLabelTextStyle: TextStyle(color: Colors.white),
                timeLabelLocation: TimeLabelLocation.sides,
                onSeek: (duration){
                    print("seek");
                    print(duration);
                    bloc.seekMusic(duration);
                },
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){
                  bloc.replayMusic();
                }, icon: Icon(LineIcons.syncIcon,color: Colors.white,)),
                IconButton(onPressed: (){
                  bloc.playPreviousMusic();
                }, icon: Icon(LineIcons.stepBackward,color: Colors.white,)),
                InkWell(
                  onTap: (){
                    if(state.isPlaying){
                      print("Called");
                      _controller.stop();
                      bloc.musicPlayingState(false);
                    }else{
                      print("else called");
                      _controller.forward();
                      bloc.musicPlayingState(true);
                    }
                  },
                  child: Icon(state.isPlaying ? LineIcons.pause:LineIcons.play,color: Colors.white,size: 50,),
                ),
                IconButton(onPressed: (){
                  bloc.playNextMusic();
                }, icon: Icon(LineIcons.stepForward,color: Colors.white,)),
                IconButton(onPressed: (){
                  Share.share(widget.url);
                }, icon: Icon(LineIcons.share,color: Colors.white,))
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  },
);
  }
}
