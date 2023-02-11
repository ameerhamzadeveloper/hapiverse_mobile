import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import '../../logic/video_audio_call/agora_video_call_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'package:line_icons/line_icons.dart';

class CallPage extends StatefulWidget {
  final String userName;
  final String avatar;
  final bool isAudio;
  final String channelId;
  final int seconds;

  const CallPage({Key? key,required this.userName,required this.avatar,required this.isAudio,required this.channelId,required this.seconds}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {

  int seconds = 0;
  late Timer timer;
  String time = '00:00';

  startTimer(){
    if(seconds == 0){
      timer = Timer.periodic(Duration(seconds: 1), (sed) {
        print(sed.tick);
        var timee = '${(Duration(seconds: sed.tick))}'.split('.')[0].padLeft(8, '0');
        timee = timee;
        setState(() {
          time = timee;
          seconds++;
        });
      });
    }else{
      seconds = seconds;
      timer = Timer.periodic(Duration(seconds: 1), (sed) {
        print(sed.tick);
        var timee = '${(Duration(seconds: seconds + 1))}'.split('.')[0].padLeft(8, '0');
        setState(() {
          time = timee;
          seconds++;
        });
      });
    }
  }



  late final bloc = BlocProvider.of<AgoraVideoCallCubit>(context,listen: false);
  late final authBloc = BlocProvider.of<RegisterCubit>(context, listen: false);
  @override
  void initState() {
    super.initState();
    // bloc = context.read<AgoraVideoCallCubit>();
    // initialize agora sdk
    initialize();
    seconds = widget.seconds;
    startTimer();

  }


  Future<void> initialize() async {
    if (Utils.appID.isEmpty) {
      setState(() {
        bloc.infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        bloc.infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // bloc.engine.leaveChannel();
    // await _engine.enableWebSdkInteroperability(true);
    try{
      print("Seconds $seconds");
      if(widget.seconds == 0){
        await bloc.engine.joinChannel(null, widget.channelId, null, 0,).then((value){
          if(bloc.isAudioCall){
            bloc.listenSensor();
          }
        });
      }
      // _addAgoraEventHandlers();
    }catch (e){
      print("Errorororororororr $e");
    }
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    bloc.engine = await RtcEngine.create(Utils.appID);
    print("audio ${widget.isAudio}");
    widget.isAudio ? await bloc.engine.disableVideo():await bloc.engine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    bloc.engine.setEventHandler(
        RtcEngineEventHandler(
      remoteAudioStats: (v){
        print(v);
        print("Aduio Cahnaed");
      },
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          bloc.infoStrings.add(info);
          print(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          bloc.infoStrings.add(info);
          bloc.user.add(uid);
          print(info);
        });
      },
      leaveChannel: (stats) {
        print("user leave");
        print("user cound leave chanel ${stats.userCount}");
        setState(() {
          bloc.infoStrings.add('onLeaveChannel');
          bloc.clearUser();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          bloc.infoStrings.add(info);
          bloc.addUsers(uid);
          print("--------------------------------------------$info");
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          final info = 'userOffline: $uid , reason: $reason';
          bloc.infoStrings.add(info);
          bloc.clearSpecificUser(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideoFrame: $uid';
          bloc.infoStrings.add(info);
        });
      },
    ));
  }

  /// Toolbar layout
  Widget _toolbar() {
    return BlocBuilder<AgoraVideoCallCubit, AgoraVideoCallState>(
        builder: (context, state) {
          return Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    state.muted ? Icons.mic_off : Icons.mic,
                    color: state.muted ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: state.muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () async {
                    _onCallEnd(context);
                    await FlutterCallkitIncoming.endAllCalls();
                    authBloc.clearCallInfo();
                    bloc.dispose();
                  bloc.removeSendor();
                  },
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
                widget.isAudio ? RawMaterialButton(
                  onPressed: (){
                    bloc.setSpeakerMode();
                  },
                  child: Icon(
                    LineIcons.volumeUp,
                    color: state.isSpeaker ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: state.isSpeaker ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ):RawMaterialButton(
                  onPressed: _onSwitchCamera,
                  child: const Icon(
                    Icons.switch_camera,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AgoraVideoCallCubit>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Agora Group Video Calling'),
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(context),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews(List<int> users) {
    final List<StatefulWidget> list = [];
    list.add(RtcLocalView.SurfaceView());
    users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid,channelId: bloc.channelName,)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return BlocBuilder<AgoraVideoCallCubit, AgoraVideoCallState>(
  builder: (context, state) {
    return Expanded(child: Stack(
      children: [
        Container(child: view),
        widget.isAudio == true ? Container(
          child: Image.network(state.avatar ?? "",width: getWidth(context),height: getHeight(context),fit: BoxFit.cover,),
        ):Container(),
        state.users.length == 0 ? Align(
          alignment: Alignment(0.0,-0.8),
          child: InkWell(
            onTap: (){
              print(state.users.length);
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(state.avatar!),
            ),
          ),
        ):Container(),
        state.users.length == 0 ? Align(
          alignment: Alignment(0.0,-0.6),
          child: Text(bloc.userName,style: TextStyle(color: Colors.white,fontSize: 20),),
        ):Container(),
        state.users.length == 0 ? Align(
          alignment: Alignment(0.0,-0.5),
          child: Text("calling...",style: TextStyle(color: Colors.white),),
        ):Container(),
      ],
    ));
  },
);
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows(BuildContext context) {
    return BlocBuilder<AgoraVideoCallCubit,AgoraVideoCallState>(
      builder: (context,state){
        // calling = ModalRoute.of(context)!.settings.arguments;
        final views = _getRenderViews(state.users);
        print("View os ${views.length}");
        print("State View os ${state.users.length}");
        switch (views.length) {
          case 1:
            return Container(
                child: Column(
                  children: <Widget>[_videoView(views[0])],
                ));
          case 2:
            return Container(
                child: widget.isAudio == false ? Column(
                  children: <Widget>[
                    _expandedVideoRow([views[0]]),
                    _expandedVideoRow([views[1]])
                  ],
                ):
                Container(
                  width: double.infinity,
                  height: getHeight(context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(state.avatar!)
                      )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: getHeight(context) / 6,),
                      Text(state.userName ?? "",style: TextStyle(fontSize: 20),),
                      Text(state.time ?? "",style: TextStyle(color: Colors.black),)
                    ],
                  ),
                )
            );
          case 3:
            return Container(
                child: Column(
                  children: <Widget>[
                    _expandedVideoRow(views.sublist(0, 2)),
                    _expandedVideoRow(views.sublist(2, 3))
                  ],
                ));
          case 4:
            return Container(
                child: Column(
                  children: <Widget>[
                    _expandedVideoRow(views.sublist(0, 2)),
                    _expandedVideoRow(views.sublist(2, 4))
                  ],
                ));
          default:
        }
        return Container();
      },
    );
  }

  void _onCallEnd(BuildContext context) {
    bloc.engine.leaveChannel();
    Navigator.pop(context);
  }

  void _onToggleMute() {

    final muted = !bloc.getIsMuted();

    bloc.setMute(mute: muted);
    bloc.engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    bloc.engine.switchCamera();
  }

  @override
  void dispose() {
    bloc.dispose();
    // clear users
    bloc.clearUser();
    // destroy sdk
    bloc.engine.leaveChannel();
    bloc.engine.destroy();
    timer.cancel();
    super.dispose();
  }

}
