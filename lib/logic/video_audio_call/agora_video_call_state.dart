part of 'agora_video_call_cubit.dart';


class AgoraVideoCallState {
  bool muted;
  bool isAudioCall;
  bool isCallAccepted;
  bool isPhoneNear;
  String currentCallTime;
  BuildContext? context;
  bool isSpeaker = false;
  bool isCalling = false;
  bool alreadyInCall = false;
  String? channelName;
  String? avatar;
  String? userName;
  int? seconds;
  String? time = '00:00';
  List<int> users;

  AgoraVideoCallState(
      {required this.muted,
        required this.isAudioCall,
        required this.isCallAccepted,
        required this.isPhoneNear,
        required this.currentCallTime,
        this.context,required this.isSpeaker,
        this.userName,
        this.channelName,
        this.seconds,
        this.avatar,
        this.time,
        required this.isCalling,
        required this.alreadyInCall,
        required this.users
      });

  AgoraVideoCallState copyWith(
      {bool? muted,
        bool? isAudioCall,
        bool? isCallAccepted,
        bool? isPhoneNear,
        String? currentCallTime,
        BuildContext? context,
        bool? isSpeakerr,
        String? channelNamee,
        String? avatarr,
        String? userNamee,
        int? secondss,
        String? timee,
        bool? isCallingg,
        bool? alreadyInCalll,
        List<int>? userss,
      }) {
    return AgoraVideoCallState(
        context: context ?? this.context,
        muted: muted ?? this.muted,
        isCallAccepted: isCallAccepted ?? this.isCallAccepted,
        isAudioCall: isAudioCall ?? this.isAudioCall,
        isPhoneNear: isPhoneNear ?? this.isPhoneNear,
        currentCallTime: currentCallTime ?? this.currentCallTime,
        isSpeaker: isSpeakerr ?? isSpeaker,
      seconds: secondss ?? seconds,
      channelName: channelNamee ?? channelName,
      avatar: avatarr ??avatar,
      userName: userNamee ?? userName,
      time: timee ?? time,
      isCalling: isCallingg ?? isCalling,
      alreadyInCall: alreadyInCalll ?? alreadyInCall,
      users: userss ?? users
    );
  }
}
