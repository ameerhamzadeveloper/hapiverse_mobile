import 'dart:async';
import 'dart:isolate';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/caller_info.dart';
import '../../services/foreground_service.dart';
import '../../utils/constants.dart';
part 'agora_video_call_state.dart';

void startCallback(_) {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}

class AgoraVideoCallCubit extends Cubit<AgoraVideoCallState> {
  AgoraVideoCallCubit() : super(AgoraVideoCallState(
      muted: false,
      isAudioCall: false,
      isCallAccepted: false,
      isPhoneNear: false,
      currentCallTime: "",
      context: null,
      isSpeaker: false,
      isCalling:false,
      alreadyInCall:false,
    users:[]
  ));

  late StreamSubscription<dynamic> _streamSubscription;


  static bool isPhoneNear = false;

  String get channelName => state.channelName ?? "";
  String get userName => state.userName ?? "";
  String get avatar => state.avatar ?? "";
  String get time => state.time ?? "";
  bool get isAudioCall => state.isAudioCall;
  bool get alreadyInCall => state.alreadyInCall;

  setSpeakerMode(){
    if(state.isSpeaker){
      engine.setEnableSpeakerphone(false);
      emit(state.copyWith(isSpeakerr: false));
    } else{
      engine.setEnableSpeakerphone(true);
      emit(state.copyWith(isSpeakerr: true));
    }
  }
  // late StreamSubscription<dynamic> _streamSubscription;

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
    };
    _streamSubscription = ProximitySensor.events.listen((int event) async {
      // emit(state.copywith(isPhoneNear: (event > 0) ? true : false));
      if(event > 0) {
        // print("isPhoneNear: true");
        try {
          await ScreenBrightness().setScreenBrightness(0);
        } catch (e) {
          print(e);
          throw 'Failed to set brightness';
        }
        state.copyWith(isPhoneNear:true);
      } else {
        // print("isPhoneNear: false");
        state.copyWith(isPhoneNear:false);
        await ScreenBrightness().resetScreenBrightness();
      }
    });
  }
  removeSendor()async{
    _streamSubscription.cancel();
    await ScreenBrightness().resetScreenBrightness();
  }

  updateService({required String timeUpdate}) {
    FlutterForegroundTask.updateService(
      notificationTitle: 'Calling..',
      notificationText:
      timeUpdate,
    );
    print("callTime in Function: $timeUpdate");
    print("state before: ${state.currentCallTime}");
    isPhoneNear = !isPhoneNear ? true : false;
    print("isPhoneNear: $isPhoneNear");
    emit(state.copyWith(currentCallTime: timeUpdate, isPhoneNear: isPhoneNear));
    print("state after: ${state.currentCallTime}");
  }

  saveCallerInfo({required String callerName, required String callerAvatar,
    required String callTimer }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(callerNameKey, callerName);
    await pref.setString(callerAvatarKey, callerAvatar);
    await pref.setString(callerTimerKey, callTimer);
  }

  Future<CallerInfo> getCallerInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return CallerInfo(callerName: pref.getString(callerNameKey),
        callerAvatar:  pref.getString(callerAvatarKey),
        callerTimer: pref.getString(callerTimerKey));
  }

  deleteCallerInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(callerNameKey);
    await pref.remove(callerAvatarKey);
    await pref.remove(callerTimerKey);
  }

  int getDifference({required DateTime previousTime}) {

    // print('$index) productID ($productID) => date1 $date1');
    // print('$index) productID ($productID) => date2 $date');
    // var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    // final date2 = inputFormat.parse(date);

    DateTime date1 = DateTime.now();

    final seconds = date1.difference(previousTime).inSeconds;
    final minutes = date1.difference(previousTime).inMinutes;

    print("difference in seconds: $seconds");
    print("difference in minutes: $minutes");

    return seconds.toInt();
    // if (date1.difference(date2).inMinutes < 59) {
    //   print("$index) productID ($productID) => ${date1.difference(date2).inMinutes} mins");
    //   if(date1.difference(date2).inMinutes > 1) {
    //     return "${date1.difference(date2).inMinutes} mins";
    //   } else {
    //     return "${date1.difference(date2).inMinutes} min";
    //   }
    // } else if (date1.difference(date2).inHours <= 24) {
    //   print("$index) productID ($productID) => ${date1.difference(date2).inHours} hours");
    //   if (date1.difference(date2).inHours > 1) {
    //     return "${date1.difference(date2).inHours} hrs ";
    //   } else {
    //     return "${date1.difference(date2).inHours} hr ";
    //   }
    // } else if (date1.difference(date2).inDays > 1) {
    //   print("$index) productID ($productID) => ${date1.difference(date2).inDays} days");
    //   return "${date1.difference(date2).inDays} days";
    // } else {
    //   print("$index) productID ($productID) => ${date1.difference(date2).inDays} day");
    //   return "${date1.difference(date2).inDays} day";
    // }
  }

  callTimerStart({required int maxTime}) async {

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      maxTime++;
      print("minute: ${maxTime ~/ 60} seconds: ${maxTime % 60}");
      emit(state.copyWith(currentCallTime: '${(maxTime ~/ 60).toString().padLeft(2, '0')}:${(maxTime % 60)
          .toString()
          .padLeft(2, '0')}'));
    });
  }

  ReceivePort? _receivePort;

  Future<bool> startForegroundTask() async {

    ReceivePort? receivePort;
    // if (await FlutterForegroundTask.isRunningService) {
    //   receivePort = await FlutterForegroundTask.restartService();
    // } else {
    //   receivePort = await FlutterForegroundTask.startService(
    //     notificationTitle: 'Calling..',
    //     notificationText: 'Tap to return to the app',
    //     callback: startCallback,
    //   );
    // }

    if (receivePort != null) {
      _receivePort = receivePort;
      _receivePort?.listen((message) {
        if (message is DateTime) {
          print('receive timestamp: $message');
        } else if (message is int) {
          print('receive updateCount: $message');
        }
      });
      return true;
    }
    return false;
  }

  Future<bool> stopForegroundTask() async {
    return await FlutterForegroundTask.stopService();
  }


  final infoStrings = <String>[];
  late RtcEngine engine;

  bool getIsMuted() {
    return state.muted;
  }

  setMute({required bool mute}) {
    emit(state.copyWith(muted: mute));
  }

  setIsAudioCall({required bool isAudioCall}) {
    emit(state.copyWith(isAudioCall: isAudioCall));
  }

  setIsCallAccepted({required bool isCallAccepted}) {
    emit(state.copyWith(isCallAccepted: isCallAccepted));
  }

  setCallValue(Map<String,dynamic> data){
    startTimer();
    emit(state.copyWith(channelNamee: data['channelId'],userNamee: data['userName'],
        alreadyInCalll: true,
        avatarr: data['avatar'],
        secondss: data['seconds'],
        isAudioCall: data['callType'] == 'AUDIO' ? true:false,
        timee:  data['time'] != null ?  data['time'] : ''));
  }

  int secondss = 0;
  late Timer timer;
  String timeee = '00:00';

  startTimer(){
    if(secondss == 0){
      timer = Timer.periodic(Duration(seconds: 1), (sed) {
        print(sed.tick);
        var timee = '${(Duration(seconds: sed.tick))}'.split('.')[0].padLeft(8, '0');
          timeee = timee;
          print(timeee);
        emit(state.copyWith(timee: timeee,secondss: secondss));
      });

    }else{
      secondss = secondss;
      timer = Timer.periodic(Duration(seconds: 1), (sed) {
        print(sed.tick);
        var timee = '${(Duration(seconds: secondss + 1))}'.split('.')[0].padLeft(8, '0');
          timeee = timee;
        emit(state.copyWith(timee: timeee,secondss: secondss));
      });
    }
  }

  dispose(){
    timer.cancel();
  }

  List<int> user = [];

  addUsers(int data){
    user.add(data);
    emit(state.copyWith(userss: user));
  }
  clearUser(){
    user.clear();
    emit(state.copyWith(userss: user));
  }
  clearSpecificUser(int id){
    user.remove(id);
    emit(state.copyWith(userss: user));
  }
}
