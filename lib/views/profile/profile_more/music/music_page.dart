import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import '../../../../logic/profile/profile_cubit.dart';
import '../../../../views/components/universal_card.dart';
import '../../../../views/profile/profile_more/music/play_music.dart';
import 'package:line_icons/line_icons.dart';

import '../../../authentication/scale_navigation.dart';
import '../../../components/bottom_to_top_transaction.dart';
class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  String title = '';
   String image = '';
   String url = '';
   Duration length = Duration();
   int index = 0;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.forward();
    super.initState();
    final bloc = context.read<ProfileCubit>();
    bloc.fetchMusic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final auth = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Music"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body:Stack(
        children: [
          state.musicTrack == null ? CupertinoActivityIndicator():Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("All Musics",style: TextStyle(fontSize: 22),),
                  ),
                  const Divider(),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.musicTrack!.length,
                    itemBuilder: (ctx,i){
                      var m = state.musicTrack![i];
                      return ListTile(
                        onTap: (){
                          title = m.album!.name!;
                          url = m.previewUrl!;
                          image = m.album!.images![0].url!;
                          length = Duration(milliseconds:m.durationMs!);
                          index = i;
                          bloc.setCurrentMusicVal(m.album!.name!, m.album!.artists![0].name!, m.album!.images![0].url!, m.previewUrl!);
                          Navigator.push(context,
                              EnterExitRoute(exitPage: MusicListPage(), enterPage: PlayMusic(length: m.durationMs!,url: url,index: index,)));
                        },
                        title: Text(m.album!.name!),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(m.album!.images![0].url!),
                        ),
                        subtitle: Text(m.artists![0].name!),
                        trailing: IconButton(
                          onPressed: (){
                            bloc.addFavMusic(auth.userID!, auth.accesToken!, m.id ?? "");
                          },
                          icon: Icon(LineIcons.heart),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: ()=>Navigator.push(context,
                  EnterExitRoute(exitPage: MusicListPage(), enterPage: PlayMusic(length: length.inMilliseconds,url: url,index: index,))),
              child: Container(
                height: 60,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(state.musicImage),
                          )
                        ],
                      ),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.musicTitle.length > 25 ? state.musicTitle.substring(0,25) : state.musicTitle}"),
                          Text(state.musicArtist,style: TextStyle(fontSize: 11),),
                        ],
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){
                            if(state.isPlaying){
                             bloc.pauseMusic();
                            }else{
                              bloc.resumeMusic();
                            }
                            Navigator.push(context,
                                EnterExitRoute(exitPage: MusicListPage(), enterPage: PlayMusic(length: length.inMilliseconds,url: url,index: index,)));
                          }, icon: Icon(state.isPlaying ? LineIcons.pauseCircle:LineIcons.playCircle,size: 35,)),
                          IconButton(onPressed: (){}, icon: Icon(LineIcons.stepForward,size: 25,)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
