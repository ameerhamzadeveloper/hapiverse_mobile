import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../logic/feeds/feeds_cubit.dart';
import '../../logic/groups/groups_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/business_tools/business_tools.dart';
import '../../views/chat/chat_page.dart';
import '../../views/feeds/feeds.dart';
import '../../views/groups/groups.dart';
import '../../views/places/places.dart';
import '../../views/profile/my_business_profile.dart';
import '../../views/profile/my_profile.dart';
import 'package:line_icons/line_icons.dart';

import '../logic/video_audio_call/agora_video_call_cubit.dart';
import 'chat/call_page.dart';

class BusinessBottomBar extends StatefulWidget {
  const BusinessBottomBar({Key? key}) : super(key: key);

  @override
  _BusinessBottomBarState createState() => _BusinessBottomBarState();
}

class _BusinessBottomBarState extends State<BusinessBottomBar> {
  int _currentIndex = 0;
  String messageCount = "";
  late SharedPreferences pre;
  bool isCalled = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  initShared()async{
    pre = await SharedPreferences.getInstance();
  }

  messageBadgeCount(){
    final authB = context.read<RegisterCubit>();
    firestore.collection('recentChats').doc(authB.userID).collection('myChats').where('isSeen',isEqualTo: false).get().then((value){
      int count = 0;
      for(var doc in value.docs){
        if(doc.data()['senderID'] != authB.userID! && doc.data()['isSeen'] == false){
          count++;
          setState(() {
            messageCount = count.toString();
          });
          print("messag count $messageCount");
        }
      }
    });
    firestore.collection('recentChats').doc(authB.userID).collection('myChats').where('isSeen',isEqualTo: false).snapshots().listen((value) {
      print("Event Called");
      int count = 0;
      for(var doc in value.docs){
        if(doc.data()['senderID'] != authB.userID! && doc.data()['isSeen'] == false){
          count++;
          setState(() {
            messageCount = count.toString();
          });
          print("messag count $messageCount");
        }
      }
    });

  }

  List<IconData> iconList = [
    LineIcons.home,
    LineIcons.users,
    LineIcons.tools,
    LineIcons.user,
    LineIcons.rocketChat,
  ];

  String callId = '';

  @override
  void initState() {
    super.initState();
    initShared();
    final bloc = context.read<RegisterCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final groupBloc = context.read<GroupsCubit>();
    final feedsBloc = context.read<FeedsCubit>();
    final productBloc = context.read<BusinessProductCubit>();
    final callCubit = context.read<AgoraVideoCallCubit>();
    FocusManager.instance.primaryFocus?.unfocus();

    Future.delayed(Duration(seconds: 2),(){
      if(pre.getString('callerName') != ''){
        isCalled = true;
        print("us clalled $isCalled");
        var name = pre.getString('callerName');
        var callerId = pre.getString('callerId');
        callId = callerId!;
        var channelId = pre.getString('channelId');
        var time = pre.getString('callTime');
        var avatar = pre.getString('avatar');
        var isAudio = pre.getString('isAudio') == "true" ? true : false;
        print(name);
        print(callerId);
        print(channelId);
        print(avatar);
        print(isAudio);
        var timeDiff = DateTime.now().difference(DateTime.parse(time!)).inSeconds;
        String timee = '${(Duration(seconds: timeDiff))}'.split('.')[0].padLeft(8, '0');
        callCubit.setCallValue({
          'userName':name,
          'avatar':avatar,
          'seconds':timeDiff,
          'callType':isAudio ? "AUDIO":"VIDEO",
          'channelId': channelId,
          'time':timee
        });
        // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => CallPage(userName:name!,seconds:timeDiff,isAudio: isAudio ? true:false,channelId: channelId!,avatar: avatar!,)));
        nextScreen(context, CallPage(userName:name!,seconds:timeDiff,isAudio: isAudio ? true:false,channelId: channelId!,avatar: avatar!,));
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("notif ${message.data}");
      var data = message.data;
      if(message.data['notificationType'] == "CALL"){
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

          switch (event!.name) {
            case CallEvent.ACTION_CALL_INCOMING:
            // TODO: received an incoming call
              print("incomming call");
              break;
            case CallEvent.ACTION_CALL_START:
            // TODO: started an outgoing call
            // TODO: show screen calling in Flutter
              print("incomming call");
              // navigatorKey.currentState?.pushNamed(callPage);
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
                'time': ''
              });
              print("seconds${callCubit.secondss} ${callCubit.userName} name");
              print("Call Accept Called");
              // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => CallPage(userName: data['userName'],seconds:0,isAudio: data['callType'] == "AUDIO" ? true:false,channelId: data['channelId'],avatar: data['avatar'])));
              nextScreen(context, CallPage(userName: data['userName'],seconds:0,isAudio: data['callType'] == "AUDIO" ? true:false,channelId: data['channelId'],avatar: data['avatar'],));
              await FlutterCallkitIncoming.startCall(params);
              break;
            case CallEvent.ACTION_CALL_DECLINE:
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
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("${notification.title}"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("${notification.body}")],
                ),
              ),
            );
          },
        );
      }
    });
    feedsBloc.getSharedLanguageCode();
    feedsBloc.fetchStory(bloc.userID!, bloc.accesToken!);
    feedsBloc.fetchMyStory(bloc.userID!, bloc.accesToken!);
    profileBloc.fetchMyPRofile(bloc.userID!, bloc.accesToken!);
    profileBloc.fetchAllMyPosts( bloc.accesToken!,bloc.userID!,);
    profileBloc.fetchBusinessRating(bloc.userID!, bloc.accesToken!,bloc.userID!);
    profileBloc.getMyFriendList( bloc.userID!,bloc.accesToken!,);
    groupBloc.getGroups(bloc.userID!, bloc.accesToken!);
    groupBloc.fetchGroupInvites(bloc.userID!, bloc.accesToken!);
    feedsBloc.fetchFeedsPosts(bloc.userID!, bloc.accesToken!,'20','0');
    bloc.fetchNotificationList(bloc.userID!, bloc.accesToken!);
    productBloc.fetchProductWithCollection(bloc.userID!, bloc.accesToken!);
    productBloc.fetchProductsWithoutCollections(bloc.userID!, bloc.accesToken!);
    productBloc.fetchBusinessEvent(bloc.userID!, bloc.accesToken!);
    print("Herer==================");
    // bloc.intiShared();
    // bloc.getFromShared();
    bloc.fetchPlan();
    messageBadgeCount();
  }

  List<Widget> items = const [
    FeedsPage(isBusiness: true,),
    GroupsPage(),
    BusinessTools(),
    MyBusinessProfile(),
    ChatPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraVideoCallCubit, AgoraVideoCallState>(
  builder: (context, state) {
    return Scaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        body: IndexedStack(
          index: _currentIndex,
          children: items,
        )
    );
  },
);
  }
  Widget _bottomNavigationBar() {

    ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(25), topLeft: Radius.circular(25)),
    );
    SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
    EdgeInsets padding = const EdgeInsets.all(0);

    SnakeShape snakeShape = SnakeShape.circle;

    bool showSelectedLabels = true;
    bool showUnselectedLabels = true;

    Color selectedColor = kUniversalColor.withOpacity(0.3);

    return SnakeNavigationBar.color(
      behaviour: snakeBarStyle,
      snakeShape: SnakeShape.circle,

      padding: padding,
      shape: bottomBarShape,

      ///configuration for SnakeNavigationBar.color
      snakeViewColor: selectedColor,
      selectedItemColor:
      snakeShape == SnakeShape.circle ? kUniversalColor : Colors.black,
      unselectedItemColor: Colors.blueGrey,
      selectedLabelStyle: const TextStyle(color: kUniversalColor),
      unselectedLabelStyle: TextStyle(fontSize: 10),

      ///configuration for SnakeNavigationBar.gradient
      //snakeViewGradient: selectedGradient,
      //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
      //unselectedItemGradient: unselectedGradient,

      showUnselectedLabels: showUnselectedLabels,
      showSelectedLabels: showSelectedLabels,

      currentIndex: _currentIndex,
      onTap: (index) => setState(() {
        _currentIndex = index;
        print(_currentIndex);
      }),
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              iconList[0],
              size: 25,
            ),
            label: getTranslated(context, 'FEEDS')!),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[1],
              size: 25,
            ),
            label: getTranslated(context, 'GROUPS')!),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[2],
              size: 25,
            ),
            label: "Business Tool"),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[3],
              size: 25,
            ),
            label: getTranslated(context, 'PROFILE')!),
        BottomNavigationBarItem(
            icon: Badge(
              animationType: BadgeAnimationType.fade,
              showBadge: messageCount == "" ? false:true,
              badgeContent: Text(messageCount,style: TextStyle(color: Colors.white,fontFamily: '',fontSize: 11),),
              child: Icon(
                iconList[4],
                size: 25,
              ),
            ),
            label: getTranslated(context, 'CHAT')!)
      ],
    );
  }
}
