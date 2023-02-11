import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:happiverse/views/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../data/model/caller_info.dart';
import '../data/model/notification_payload.dart';
import '../logic/register/register_cubit.dart';
import '../logic/video_audio_call/agora_video_call_cubit.dart';
import '../routes/routes_names.dart';
import '../services/navigation_services.dart';
import 'chat/audio_call_pickup_page.dart';
import 'chat/call_page.dart';

class SplashNormalPage extends StatefulWidget {
  const SplashNormalPage({Key? key}) : super(key: key);
  @override
  _SplashNormalPageState createState() => _SplashNormalPageState();
}

class _SplashNormalPageState extends State<SplashNormalPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late SharedPreferences pre;
  bool isCalled = false;
  var callId = '';
  getCurrentCall() async {

    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        callId = calls[0]['id'];
        return calls[0];
      } else {
        callId = "";
        return null;
      }
    }
  }

  checkAndNavigationCallingPage(BuildContext context)  {
    print("called this");
    final callCubit = AgoraVideoCallCubit();
    print("seconds${callCubit.secondss} ${callCubit.userName} name");

    print("seconds${callCubit.secondss} ${callCubit.userName} name");
  }
  initShared()async{
    pre = await SharedPreferences.getInstance();
  }

  handleCallNotification(Map<String,dynamic> data,BuildContext context)async{
    var params = <String, dynamic>{
      'id': data['channelId'],
      'nameCaller': data['userName'],
      'appName': 'Hapiverse',
      'avatar': data['avatar'],
      'handle': '0123456789',
      'type': data['callType'] == "AUDIO" ? 0 : 1,
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'duration': '',
      'extra': <String, dynamic>{'userId': '1a2b3c4d'},
      'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': false,
        'isShowMissedCallNotification': true,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'backgroundUrl': 'https://i.pravatar.cc/500',
        'actionColor': '#4CAF50'
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': 'generic',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
        'supportsDTMF': true,
        'supportsHolding': true,
        'supportsGrouping': false,
        'supportsUngrouping': false,
        'ringtonePath': 'system_ringtone_default'
      }
    };
    await FlutterCallkitIncoming.showCallkitIncoming(params);

    FlutterCallkitIncoming.onEvent.listen((event)async {
      final callCubit = AgoraVideoCallCubit();
      switch (event!.name) {
        case CallEvent.ACTION_CALL_INCOMING:
        // TODO: received an incoming call
          print("incomming call");
          break;
        case CallEvent.ACTION_CALL_START:
        // TODO: started an outgoing call
        // TODO: show screen calling in Flutter
          print("incomming call");
          navigatorKey.currentState?.pushNamed(callPage);
          break;
        case CallEvent.ACTION_CALL_ACCEPT:
          pre.setString('callerName', data['userName']);
          pre.setString('callerId', data['channelId']);
          pre.setString('callTime', DateTime.now().toString());
          pre.setString('channelId', data['channelId']);
          pre.setString('avatar', data['avatar']);
          pre.setString('isAudio', data['callType'] == "AUDIO" ? 'true':'false');
          print("name ${pre.getString('callerName')} id channel ${pre.getString('channelId')}");
          // navigatorKey.currentState!.push(route);
          callCubit.setCallValue({
            'userName':data['userName'],
            'avatar':data['avatar'],
            'seconds': 0,
            'callType':data['callType'],
            'channelId': data['channelId'],
            'time':''
          });
          print("seconds${callCubit.secondss} ${callCubit.userName} name");
          print("Call Accept Called");
          navigatorKey.currentState?.pushNamed(callPage);
          await FlutterCallkitIncoming.startCall(params);
          break;
        case CallEvent.ACTION_CALL_DECLINE:
        // TODO: declined an incoming call
          print("reject call call");
          break;
        case CallEvent.ACTION_CALL_ENDED:
          SharedPreferences pre = await SharedPreferences.getInstance();
          pre.setString('callerName' ,"");
          pre.setString('callerId','');
          pre.setString('channelId','');
          pre.setString('callTime','');
          pre.setString('avatar','');
          pre.setString('isAudio','false');
          // TODO: ended an incoming/outgoing call
          print("End call");
          break;
        case CallEvent.ACTION_CALL_TIMEOUT:
          break;
        case CallEvent.ACTION_CALL_CALLBACK:
        // TODO: only Android - click action `Call back` from missed call notification
          break;
        case CallEvent.ACTION_CALL_TOGGLE_HOLD:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_MUTE:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_DMTF:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_GROUP:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
        // TODO: only iOS
          break;
      }
    });
  }

  // if(pre.getString('callerName') != null && pre.getString('callerName') != '' && pre.getString('callerId') != null){
  // isCalled = true;
  // print("us clalled $isCalled ${pre.getString('callerName')}");
  // var name = pre.getString('callerName');
  // var callerId = pre.getString('callerId');
  // callId = callerId!;
  // var channelId = pre.getString('channelId');
  // var time = pre.getString('callTime');
  // var avatar = pre.getString('avatar');
  // var isAudio = pre.getString('isAudio') == "true" ? true : false;
  // print(name);
  // print(callerId);
  // print(channelId);
  // print(avatar);
  // print(isAudio);
  // var timeDiff = DateTime.now().difference(DateTime.parse(time!)).inSeconds;
  // String timee = '${(Duration(seconds: timeDiff))}'.split('.')[0].padLeft(8, '0');
  // callCubit.setCallValue({
  // 'userName':name,
  // 'avatar':avatar,
  // 'seconds':timeDiff,
  // 'callType':isAudio ? "AUDIO":"VIDEO",
  // 'channelId': channelId,
  // 'time':timee
  // });
  // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => CallPage(userName:name!,seconds:timeDiff,isAudio: isAudio ? true:false,channelId: channelId!,avatar: avatar!,)));
  // nextScreen(context, CallPage(userName:name!,seconds:timeDiff,isAudio: isAudio ? true:false,channelId: channelId!,avatar: avatar!,));
  // }

  @override
  void initState() {
    super.initState();
    // initShared();

    final bloc = context.read<RegisterCubit>();
    final callCubit = context.read<AgoraVideoCallCubit>();
    bloc.getLocation();
    bloc.intiShared();
    Future.delayed(const Duration(seconds: 2), () {
      bloc.getFromShared();
          if (bloc.userID != null) {
            if(bloc.isBusinessShared == null || bloc.isBusinessShared == false){
              Navigator.pushNamedAndRemoveUntil(context, nav, (route) => false);
            }else{
              Navigator.pushNamedAndRemoveUntil(context, businessBottom, (route) => false);
            }
          } else {
            Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false);
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUniversalColor,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                AssetConfig.kLogo,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width - 100,
              ),
            ),
          ),
         const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(50.0),
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 15,
                )),
          ),
        ],
      ),
    );
  }
}
