import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/video_audio_call/agora_video_call_cubit.dart';
import '../../utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'call_page.dart';

class PickupScreen extends StatelessWidget {
  final String channelID;
  final String callerName;
  final String profilePicUrl;
  final bool isAudioCall;
  final bool isCallResume;
  final int seconds;

  PickupScreen(
      {Key? key,
        required this.channelID,
        required this.callerName,
        required this.profilePicUrl,
        required this.isAudioCall,
        required this.isCallResume,
        required this.seconds
      })
      : super(key: key);

  static var iconMute = const Icon(Icons.mic, color: Colors.grey,);

  // Create RTC client instance
  final RtcEngineContext context = RtcEngineContext(Utils.appID);
  late final RtcEngine engine;

  // Init the app
  Future<void> initPlatformState() async {
    if(!isCallResume) {
      await [Permission.microphone].request();

      engine = await RtcEngine.createWithContext(context);
      // Define event handling logic
      engine.setEventHandler(RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            print('joinChannelSuccess ${channel} ${uid}');
            // setState(() {
            //   _joined = true;
            // });
          }, userJoined: (int uid, int elapsed) {
        print('userJoined ${uid}');
      }, userOffline: (int uid, UserOfflineReason reason) {
        print('userOffline ${uid}');
      }));
      // Enable video
      await engine.disableVideo();
      // Join channel with channel name as 123
      await engine.joinChannel(null, channelID, null, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AgoraVideoCallCubit>(context);

    void _onToggleMute() {

      final muted = !bloc.getIsMuted();

      if(!muted) {
        iconMute = const Icon(Icons.mic_off);
      } else {
        iconMute = const Icon(Icons.mic);
      }

      bloc.setMute(mute: muted);
      bloc.engine.muteLocalAudioStream(muted);
    }

    return BlocBuilder<AgoraVideoCallCubit, AgoraVideoCallState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: Colors.black,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Incoming...",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.currentCallTime,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      profilePicUrl,
                      height: 150.0,
                      width: 100.0,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    callerName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 75),
                  BlocBuilder<AgoraVideoCallCubit, AgoraVideoCallState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.call_end),
                              color: Colors.redAccent,
                              onPressed: () async {
                                // bloc.users.clear();
                                bloc.setIsCallAccepted(isCallAccepted: false);
                                bloc.setIsAudioCall(isAudioCall: false);
                                bloc.setMute(mute: false);
                                await bloc.deleteCallerInfo();
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 25),
                            state.isCallAccepted
                                ? IconButton(
                                icon: iconMute,
                                color: Colors.grey,
                                onPressed: () async {
                                  if (isAudioCall) {
                                    _onToggleMute();
                                  } else {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           CallPage(
                                    //               channelName: channelID,
                                    //             avatar: profilePicUrl,
                                    //             isAudioCall: false,
                                    //             userName: callerName,
                                    //               seconds: 0
                                    //           ),
                                    //     ));
                                  }
                                })
                                : Container(),
                            const SizedBox(width: 25),
                            !state.isCallAccepted
                                ? IconButton(
                                icon: Icon(Icons.call),
                                color: Colors.green,
                                onPressed: () async {
                                  if (isAudioCall) {
                                    String currentTime = DateTime.now().toString();
                                    await bloc.saveCallerInfo(callerName: callerName, callerAvatar: profilePicUrl, callTimer: currentTime);
                                    await bloc.startForegroundTask();
                                    bloc.setIsCallAccepted(isCallAccepted: true);
                                    bloc.callTimerStart(maxTime: 0);
                                  } else {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           CallPage(channelName: channelID,avatar: profilePicUrl,
                                    //             isAudioCall: false,
                                    //             userName: callerName,seconds: 0),
                                    //     ));
                                  }
                                })
                                : Container()
                          ],
                        );
                      }),
                ],
              ),
            ),
          );
        }
    );
  }

}
