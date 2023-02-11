import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import '../../utils/constants.dart';
import '../../views/chat/audio_ongoing.dart';
import '../../views/chat/call_page.dart';
import '../../views/components/secondry_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
class Placesss extends StatefulWidget {
  const Placesss({Key? key}) : super(key: key);

  @override
  _PlacesssState createState() => _PlacesssState();
}

class _PlacesssState extends State<Placesss> {
  String callId = '';
  bool callInProgress = false;
  getCurrentCall() async {
    //check current call from pushkit if possible
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

  checkAndNavigationCallingPage(BuildContext context) async {
    var currentCall = await getCurrentCall();
    if (currentCall != null) {
     setState(() {
       callInProgress = true;
     });
     SharedPreferences pre = await SharedPreferences.getInstance();
     var name = pre.getString('callerName');
     var callerId = pre.getString('callerId');
     callId = callerId!;
     var channelId = pre.getString('channelId');
     var time = pre.getString('callTime');
     var avatar = pre.getString('avatar');
     var isAudio = pre.getString('isAudio') == "true" ? true : false;
     var timeDiff = DateTime.now().difference(DateTime.parse(time!)).inSeconds;
     var timee = '${(Duration(seconds: timeDiff))}'.split('.')[0].padLeft(8, '0');
     print(timee);
     // nextScreen(context, CallPage(channelName: channelId!, userName: name!, avatar: avatar!, isAudioCall: isAudio,seconds: timeDiff,));

    }
  }
  @override
  void initState() {

    super.initState();
    checkAndNavigationCallingPage(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Test Page"),
      ),
      body: Column(
        children: [
          callInProgress ? InkWell(
            onTap: ()async{
              await FlutterCallkitIncoming.activeCalls();
              SharedPreferences pre = await SharedPreferences.getInstance();
              var name = pre.getString('callerName');
              var callerId = pre.getString('callerId');
              callId = callerId!;
              var channelId = pre.getString('channelId');
              var time = pre.getString('callTime');
              var avatar = pre.getString('avatar');
              var isAudio = pre.getString('isAudio') == "true" ? true : false;
              var timeDiff = DateTime.now().difference(DateTime.parse(time!)).inSeconds;
              var timee = '${(Duration(seconds: timeDiff))}'.split('.')[0].padLeft(8, '0');
              print(timee);
              // nextScreen(context, CallPage(channelName: channelId!, userName: name!, avatar: avatar!, isAudioCall: isAudio,seconds: timeDiff,));
            },
            child: Container(
              width: double.infinity,
              color: kUniversalColor,
              padding: const EdgeInsets.all(10),
              child: Center(child: Text("Call Ongoing Tap to View",style: TextStyle(color: Colors.white),)),
            ),
          ):Container(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SecendoryButton(text: "Incomming Call", onPressed: ()async{
                  print(Uuid().v4());
                  var id = const Uuid().v4();
                  var params = <String, dynamic>{
                    'id': id,
                    'nameCaller': 'Ameer Hamza',
                    'appName': 'Callkit',
                    'avatar': 'https://i.pravatar.cc/100',
                    'handle': '0123456789',
                    'type': 0,
                    'textAccept': 'Accept',
                    'textDecline': 'Decline',
                    'textMissedCall': 'Missed call',
                    'textCallback': 'Call back',
                    'duration': 30000,
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
                  Future.delayed(Duration(seconds: 4),()async{
                    await FlutterCallkitIncoming.showCallkitIncoming(params);
                  });

                  FlutterCallkitIncoming.onEvent.listen((event) async{
                    switch (event!.name) {
                      case CallEvent.ACTION_CALL_INCOMING:
                      // TODO: received an incoming call
                        print("incomming call");
                        break;
                      case CallEvent.ACTION_CALL_START:
                      // TODO: started an outgoing call
                      // TODO: show screen calling in Flutter
                        print("incomming call");
                        break;
                      case CallEvent.ACTION_CALL_ACCEPT:
                        print("accepted call");
                        await FlutterCallkitIncoming.startCall(params);
                        SharedPreferences pre = await SharedPreferences.getInstance();
                        pre.setString('callerName', 'Ameer Hamza');
                        pre.setString('callerId', Uuid().v4());
                        pre.setString('callTime', DateTime.now().toString());
                        pre.setString('channelId', '1234');
                        pre.setString('avatar', 'https://i.pravatar.cc/100');
                        pre.setString('isAudio', 'true');
                        // nextScreen(context, CallPage(channelName: '1234', userName: 'Ameer Hamza', avatar: 'https://i.pravatar.cc/100', isAudioCall: true,seconds: 0,));
                        // TODO: accepted an incoming call
                        // TODO: show screen calling in Flutter
                        break;
                      case CallEvent.ACTION_CALL_DECLINE:
                      // TODO: declined an incoming call
                        print("reject call call");
                        break;
                      case CallEvent.ACTION_CALL_ENDED:
                      // TODO: ended an incoming/outgoing call
                        print("End call");
                        break;
                      case CallEvent.ACTION_CALL_TIMEOUT:
                      // TODO: missed an incoming call
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
                }),
                SecendoryButton(text: "Outgoing Call", onPressed: ()async{
                  print(Uuid().v4());
                  var params = <String, dynamic>{
                    'id': Uuid().v4(),
                    'nameCaller': 'Hien Nguyen',
                    'handle': '0123456789',
                    'type': 1,
                    'extra': <String, dynamic>{'userId': '1a2b3c4d'},
                    'ios': <String, dynamic>{'handleType': 'generic'}
                  };
                  await FlutterCallkitIncoming.startCall(params);
                  SharedPreferences pre = await SharedPreferences.getInstance();
                  pre.setString('callerName', 'Ameer Hamza');
                  pre.setString('callerId', Uuid().v4());
                  pre.setString('callTime', DateTime.now().toString());
                  pre.setString('channelId', Uuid().v4());
                  pre.setString('avatar', 'https://i.pravatar.cc/100');
                  pre.setString('isAudio', 'false');
                  nextScreen(context, AudioOnGoing(channelId: '1234', userName: 'Ameer Hamza', avatar: 'https://i.pravatar.cc/100',));

                }),
                SecendoryButton(text: "Reject Call", onPressed: (){
                  var dif = DateTime.now().difference(DateTime.parse('2022-06-16 16:35:11.227151')).inSeconds;
                  var time = '${(Duration(seconds: dif))}'.split('.')[0].padLeft(8, '0');
                  print(time);
                  print(DateTime.now());
                }),
                SecendoryButton(text: "Accept Call", onPressed: (){}),
                SecendoryButton(text: "End Call", onPressed: ()async{
                  await FlutterCallkitIncoming.endAllCalls();
                }),
                SecendoryButton(text: "Show Picker Call", onPressed: ()async{
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
