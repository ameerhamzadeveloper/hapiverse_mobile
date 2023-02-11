import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happiverse/services/navigation_services.dart';
import 'logic/business_product/business_product_cubit.dart';
import 'logic/chat/chat_cubit.dart';
import 'logic/feeds/feeds_cubit.dart';
import 'logic/groups/groups_cubit.dart';
import 'logic/places/places_cubit.dart';
import 'logic/post_cubit/post_cubit.dart';
import 'logic/profile/profile_cubit.dart';
import 'logic/register/register_cubit.dart';
import 'logic/story/story_cubit.dart';
import 'logic/video_audio_call/agora_video_call_cubit.dart';
import 'routes/custom_routes.dart';
import 'routes/routes_names.dart';
import 'utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/language_localization.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up :  ${message.messageId}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
FirebaseMessaging messaging = FirebaseMessaging.instance;

setupFireBase() async {
  FirebaseMessaging.instance.requestPermission(
      sound: true, badge: true, alert: true, provisional: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupFireBase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findRootAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale? _locale;
  getSharedLanguages() async {
    const loc = Locale('en', 'US');
    SharedPreferences pre = await SharedPreferences.getInstance();
    var cLan = pre.getInt('language');
    if(cLan == null){
      setLocale(loc);
    }else{
      if (cLan == 0) {
        const local = Locale('en', 'US');
        setLocale(local);
      } else if (cLan == 1) {
        const local = Locale('zh', 'CN');
        MyApp.setLocale(context, local);
      } else if (cLan == 2) {
        const local = Locale('ar', 'SA');
        setLocale(local);
      } else if (cLan == 3) {
        const local = Locale('ur', 'PK');
        setLocale(local);
      } else if (cLan == 4) {
        const local = Locale('hi', 'IN');
        setLocale(local);
      } else if (cLan == 5) {
        const local = Locale('es', 'ES');
        setLocale(local);
      } else {
        setLocale(loc);
      }
    }
  }

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
    if(pre.getString('callerName') != null && pre.getString('callerName') != '' && pre.getString('channelId') != null) {
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
        'seconds':0,
        'callType':isAudio ? "AUDIO":"VIDEO",
        'channelId': channelId,
        'time':timee
      });
      navigatorKey.currentState?.pushNamed(callPage);
    }
    print("seconds${callCubit.secondss} ${callCubit.userName} name");
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

  handleNotifications(BuildContext context){
    print("NotificationCalled");
    // checkAndNavigationCallingPage(context);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("notif ${message.data}");
      if(message.data['notificationType'] == "CALL"){
        handleCallNotification(message.data,context);
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
  }

  initShared()async{
    pre = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getSharedLanguages();
    // initShared();
    // Future.delayed(Duration(milliseconds: 200),(){
    //   // handleNotifications(context);
    //   print("Called");
    //   // handleNotifications(context);
    //   print("Called eee");
    //   // checkAndNavigationCallingPage(context);
    //   print("Called3333");
    // });
    // FlutterCallkitIncoming.endAllCalls();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider<StoryCubit>(create: (context) => StoryCubit()),
        BlocProvider<PostCubit>(create: (context) => PostCubit()),
        BlocProvider<GroupsCubit>(create: (context) => GroupsCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<FeedsCubit>(create: (context) => FeedsCubit()),
        BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
        BlocProvider<PlacesCubit>(create: (context) => PlacesCubit()),
        BlocProvider<BusinessProductCubit>(create: (context) => BusinessProductCubit()),
        BlocProvider<AgoraVideoCallCubit>(
            create: (context) => AgoraVideoCallCubit()),
      ],
      child: MaterialApp(
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
          Locale("zh", "CN"),
          Locale("hi", "IN"),
          Locale("ur", "PK"),
          Locale("es", "ES"),
        ],
        locale: _locale,
        // navigatorKey: navigatorKey,
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        title: 'Hapiverse',
        theme: ThemeData(
          scaffoldBackgroundColor: kScaffoldBgColor,
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            backgroundColor: kUniversalColor,
            centerTitle: true,
          ),
          fontFamily: 'Delecta',
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: kSecendoryColor, primary: kUniversalColor),
          primarySwatch: Colors.blue,
        ),
        initialRoute: splashNormal,
        onGenerateRoute: CustomRoutes.allRoutes,
        navigatorKey: NavigationService.instance.navigationKey,
        navigatorObservers: <NavigatorObserver>[
          NavigationService.instance.routeObserver
        ],
      ),
    );
  }
}
