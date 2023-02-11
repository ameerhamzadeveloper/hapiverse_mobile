import 'dart:async';
import 'dart:isolate';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../logic/video_audio_call/agora_video_call_cubit.dart';
import '../main.dart';
import '../routes/routes_names.dart';

class ForegroundTaskHandler implements TaskHandler {

  final cuibit = AgoraVideoCallCubit();

  @override
  void onButtonPressed(String id) async {
    // TODO: implement onButtonPressed
    print('onButtonPressed >> $id');
    await FlutterForegroundTask.stopService();
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    // TODO: implement onEvent
    print("onEvent called");
    navigatorKey.currentState?.pushNamed(splashNormal);
  }

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    print("onStart called");
    int maxTime = 0;
    // SharedPreferences.setMockInitialValues({});
    // SharedPreferences pref = await SharedPreferences.getInstance();

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      maxTime++;
      print("minute: ${maxTime ~/ 60} seconds: ${maxTime % 60}");
      // await FlutterForegroundTask.saveData(key: "maxtime", value: maxTime);
      cuibit.updateService(timeUpdate: '${(maxTime ~/ 60).toString().padLeft(2, '0')}:${(maxTime % 60)
          .toString()
          .padLeft(2, '0')}');
    });
  }

  @override
  void onNotificationPressed() {
    // TODO: implement onNotificationPressed
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) {
    // TODO: implement onDestroy
    throw UnimplementedError();
  }

}
