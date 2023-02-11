import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happiverse/logic/video_audio_call/agora_video_call_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../logic/chat/chat_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/utils.dart';
import '../../views/chat/call_page.dart';
import '../../views/chat/media.dart';
import '../../views/chat/view_image.dart';
import '../../views/components/secondry_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConservationPage extends StatefulWidget {
  final String recieverName;
  final String profileImage;
  final String recieverPhone;
  const ConservationPage({Key? key,required this.profileImage,required this.recieverPhone,required this.recieverName}) : super(key: key);

  @override
  _ConservationPageState createState() => _ConservationPageState();
}

class _ConservationPageState extends State<ConservationPage> {
  String text = '';
  bool isVoiceMessaging = false;
  static int voiceSeconds = 0;
  late Timer timer;
  var voiceSecondsPreview = '';
  TextEditingController message = TextEditingController();
  bool isEmojiOpen = true;
  static Directory? recordFilePath;
  int totalVoiceLength = 0;
  int transfferedVoiceLength = 0;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  onBackspacePressed() {
    message
      ..text = message.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: message.text.length));
  }

  String formatDuration(Duration duration) {
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
  final record = Record();
  final recorder = FlutterSoundRecorder();
  var filePathh = '';
  startVoiceRecord()async{
    var hasPermission = await Permission.microphone.request();
      recordFilePath = await getApplicationDocumentsDirectory();
    String filepath = recordFilePath!.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';

    filePathh = filepath;
    // recorderr.start();
    // recorder.startRecorder(toFile: 'audio',codec:Codec.defaultCodec );
    // record.start(encoder: AudioEncoder.wav,path: "${recordFilePath!.path}/file.wav").then((value){
    //
    // });
      // var rec = RecordMp3.instance.start(recordFilePath!.path, (p0) => null);
      // print(rec);
    // await myRecorder.startRecorder(toFile: 'foo', codec: t_CODEC.CODEC_AAC,);
      // RecordMp3.instance.start(recordFilePath!.path, (type) {
      //   setState(() {});
      //   print("Tyoeee ${type.name}");
      // });
    setState(() {});
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        voiceSeconds++;
        voiceSecondsPreview = '${(Duration(seconds: voiceSeconds))}'.split('.')[0].padLeft(3, '0');
      });
      print(voiceSeconds);
    });
  }
  final authB = RegisterCubit();
  endVoiceRecording(BuildContext context,String userId,String image)async{
    // RecordMp3.instance.stop();
    // record.stop();
    // final path = await recorder.stopRecorder();
    // final audioFile = File(path!);
    // print("path  ${audioFile.path}");
    var patht = '';
    String filename = filePathh.split("/").last;
    print(authB.userID);
    uploadVoice(widget.recieverPhone,filePathh,userId,context,image,filename);
    voiceSeconds = 0;
    voiceSecondsPreview = '';
    setState(() {});
    timer.cancel();
    // String filename = audioFile.path.split("/").last;


  }
  onEmojiSelected(Emoji emoji) {
    message
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: message.text.length));
  }
  bool isKeyboardOpen = false;
  int lastIndex = 0;
  final ScrollController _controller = ScrollController();
  // late AutoScrollController chatController;
  int messageCount = 0;
  bool isRecording = false;
  bool isUploading = false;
  DateTime date = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool emojiShowing = false;
  Future<String> uploadImage(Uint8List? imageBytes, String cid, String filename,String userid) async {
    var snapshot = await FirebaseStorage.instance.ref().child('chats/${userid}/$cid/$filename${DateTime.now()}').putData(imageBytes!);
    var url = (await snapshot.ref.getDownloadURL()).toString();
    return url;
  }
  void _scrollDown() {
    if (_controller.hasClients) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    message.text = _lastWords;
    text = _lastWords;
    setState(() {

    });
    // Navigator.pop(context);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    print("sdf");
    print(result.finalResult);
    if(result.finalResult){
      message.text = _lastWords;
      text = _lastWords;
      setState(() {

      });
      Navigator.pop(context);
    }
  }

  Future<String> uploadVoice(String cid, String filename,String userid,BuildContext context,String image,String fileName) async {
    // final authB = RegisterCubit();
    // final profileCubit = ProfileCubit();
    print("Called");
    final Uri uri = Uri.file(filePathh);
    if (!File(uri.toFilePath()).existsSync()) {
      throw '$uri does not exist!';
    }
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
    setState(() {
      isUploading = true;
    });
    print(filename);
    UploadTask data = FirebaseStorage.instance.ref().child('chats/${userid}/$cid/${DateTime.now().microsecondsSinceEpoch}$fileName.aac').putFile(File(filename),SettableMetadata(contentType: 'audio/aac'));
    var url =  await (await data).ref.getDownloadURL();
    data.asStream().listen((event) {
      print(event.totalBytes);
      print(event.bytesTransferred);
       totalVoiceLength = event.totalBytes;
       transfferedVoiceLength = event.bytesTransferred;

       if(totalVoiceLength == transfferedVoiceLength){
         isUploading = false;
         print(url);
         sendVoiceMessage(context, url, widget.recieverPhone, messageCount.toString(), widget.recieverName, widget.profileImage,userid,widget.recieverName,"${Utils.baseImageUrl}${image}");
         setState(() {});
       }
       setState(() {});
    });
    // var url = await (await data).ref.getDownloadURL();
    return url;
  }
  XFile? image;

 static String baseIamgePath = 'assets/chat_wal/';

  String selectedBg = '${baseIamgePath}white.png';

  List<String> bgImagesList = [
    '${baseIamgePath}black.jpeg',
    '${baseIamgePath}white.png',
    '${baseIamgePath}wal_1.jpeg',
    '${baseIamgePath}wal_2.jpeg',
    '${baseIamgePath}wal_3.jpeg',
  ];

  bool isBlocked = false;
  bool isBlockedMe = false;

  getPath()async{
    recordFilePath = await getTemporaryDirectory();
  }

  Uri notiUrl = Uri.parse("https://fcm.googleapis.com/fcm/send");

  sendNotification(String userName,String avatar,String channelId,bool isAudio)async{
    http.Response resposen = await http.post(
        notiUrl,
        body: jsonEncode({
          "to":"eo-XYz_CgkFwqlBvkDO3W6:APA91bFprrP5yjM9htCK06AIMFHpJNjv4wGSZeMOZXeNRscrMxPsiOegTjBV0hlit6a5N3f3bQT12tR3_LgnyMaXgpQq33km9eUM3FUeYHyO9LHqTPowtCpGWNjR9bL0ovglZG87kjPe",
          "Priority":"high",
          "notification":{
            "title":"Hapiverse",
            "body":"Hapiverse ${isAudio ? "Audio" : "Video"} Call",
            "notificationType": isAudio ? "AUDIO_CALL" : "VIDEO_CALL",
            "notificationId": "6"
          },
          "data":{
            "notificationType":"CALL",
            "notificationId":"6",
            "callType":isAudio ?"AUDIO":"VIDEO",
            "channelId":channelId,
            "avatar":avatar,
            "userName":userName
          }
        }),
        headers: {
          'Authorization':'key=AAAAzrdi-rU:APA91bHI5gkJ8rk86kuarso26RwIlRaQcNRUU9ND-Zd5Zzda7tH4TzMB0sPttx5XhrS643TwyMUD4gGXBrcwZ4VKwFydRl02z2w8tRogAz01e2LKJzijjWlF-hfdvOA1431fAR-9299Q',
          'Content-Type':'application/json'
        });

    print(resposen.body);
  }

  @override
  void initState() {
    super.initState();
    // getPath();
    _scrollDown();
    _initSpeech();
    print(widget.recieverPhone);
    final authB = context.read<RegisterCubit>();
    firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(widget.recieverPhone).get().then((value){
      setState(() {
        isBlocked = value.data()!['isBlocked'];
        isBlockedMe = value.data()!['senderID'] == authB.userID! ? true: false;
      });
    });
    firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(widget.recieverPhone).update({
      'isSeen':true,
    });
    firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(widget.recieverPhone).snapshots().listen((event) {
      firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(widget.recieverPhone).update({
        'isSeen':true,
      });
    });
  }
  var agoraChannelID = const Uuid().v4();
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final chatBloc = BlocProvider.of<ChatCubit>(context);
    final callCubit = BlocProvider.of<AgoraVideoCallCubit>(context);
    final profileBloc = context.read<ProfileCubit>();
    final Stream<QuerySnapshot> documentStream = firestore.collection('chats').doc(authB.userID).collection(widget.recieverPhone).orderBy('timestamp').snapshots();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profileState) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.recieverName),
        actions: [
          isBlocked ? Container():IconButton(
            onPressed: ()async{
              SharedPreferences pre = await SharedPreferences.getInstance();
              pre.setString('callerName', widget.recieverName);
              pre.setString('callerId', agoraChannelID);
              pre.setString('callTime', DateTime.now().toString());
              pre.setString('channelId', agoraChannelID);
              pre.setString('avatar', widget.profileImage);
              pre.setString('isAudio', 'true');
              print(agoraChannelID);
              // navigatorKey.currentState!.push(route);
              // String ranChannelID = generateRandomString(10);
              callCubit.setCallValue({
                'userName':widget.recieverName,
                'avatar':widget.profileImage,
                'seconds':0,
                'callType':'AUDIO',
                'channelId': agoraChannelID,
              });
              nextScreen(context, CallPage(avatar: widget.profileImage,channelId: agoraChannelID,isAudio: true,seconds: 0,userName: widget.recieverName,));
              sendNotification(authB.isBusinessShared! ? profileState.businessProfile!.businessName! : profileState.profileName!, authB.isBusinessShared! ? "${Utils.baseImageUrl}${profileState.businessProfile!.logoImageUrl!}" : "${Utils.baseImageUrl}${profileState.profileImage!}", agoraChannelID, true);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CallPage()));
            },
            icon: const Icon(
              LineIcons.phone,
              color: Colors.white,
            ),
          ),
          isBlocked ? Container():IconButton(
            onPressed: ()async{
              // String ranChannelID = generateRandomString(10);
              // print("channel idddd $ranChannelID");
              print(agoraChannelID);
              SharedPreferences pre = await SharedPreferences.getInstance();
              pre.setString('callerName', widget.recieverName);
              pre.setString('callerId', agoraChannelID);
              pre.setString('callTime', DateTime.now().toString());
              pre.setString('channelId', agoraChannelID);
              pre.setString('avatar', widget.profileImage);
              pre.setString('isAudio', 'false');
              callCubit.setCallValue({
                'userName':widget.recieverName,
                'avatar':widget.profileImage,
                'seconds':0,
                'callType':'VIDEO',
                'channelId': agoraChannelID,
              });
              nextScreen(context, CallPage(avatar: widget.profileImage,channelId: agoraChannelID,isAudio: false,seconds: 0,userName: widget.recieverName,));
              sendNotification(authB.isBusinessShared! ? profileState.businessProfile!.businessName! : profileState.profileName!, authB.isBusinessShared! ? "${Utils.baseImageUrl}${profileState.businessProfile!.logoImageUrl!}" : "${Utils.baseImageUrl}${profileState.profileImage!}", agoraChannelID, false);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CallPage()));
            },
            icon: const Icon(
              LineIcons.video,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: (){
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    context: context, builder: (ctx,){
                  return Container(
                    height: 340,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(child: InkWell(
                              onTap:(){
                                Navigator.pop(context);
                                nextScreen(context, ChatMediaPage(collectionID: firestore.collection('chats').doc(authB.userID).collection(widget.recieverPhone).where("messageType",isEqualTo: "image").get()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(LineIcons.images),
                                      Text("Media")
                                    ],
                                  ),
                                ),
                              ),
                             ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(child: InkWell(
                              onTap:(){
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  context: context, builder: (ctx){
                                    return Container(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Text("Chat Wallpaper"),
                                      StaggeredGrid.count(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        children: bgImagesList.map((e){
                                          return InkWell(
                                            onTap: (){
                                             setState(() {
                                               selectedBg = e;
                                             });
                                             Navigator.pop(context);
                                              // nextScreen(context, SeeProfileImage(imageUrl: data['message'],title: data['profileImage'],));
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                // borderRadius: BorderRadius.all(
                                                //   Radius.circular(15),
                                                // ),
                                              ),
                                              child: ClipRRect(
                                                // borderRadius: const BorderRadius.all(
                                                //     Radius.circular(15)),
                                                  child: Image.asset(e)
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      )
                                        ],
                                      ),
                                    );
                                },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(LineIcons.mountain),
                                      Text("Wallpaper")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        // Text("sdfdsffds"),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Column(
                                      children: <Widget>[
                                        Text("Do you want to delete all chat?"),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text("Clear Chat",style: TextStyle(color: Colors.red),),
                                        onPressed: () async{
                                          clearChat(authB.userID!, widget.recieverPhone, widget.recieverName, widget.profileImage);
                                          Navigator.pop(context);
                                          },),
                                      CupertinoDialogAction(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },),
                                    ],
                                  );
                                }
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            padding: EdgeInsets.all(12),
                            child: Center(child: Text("Clear Chat")),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          content: Text("You'll no longer to receive or send ${widget.recieverName} messages or call"),
                                          title: Column(
                                            children: <Widget>[
                                              Text("Do you want to Block ${widget.recieverName}?"),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text("Block",style: TextStyle(color: Colors.red),),
                                              onPressed: () async{
                                                blockUser(authB.userID!, widget.recieverPhone, widget.recieverName, widget.profileImage);
                                                Navigator.pop(context);
                                                firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(widget.recieverPhone).get().then((value){
                                                  setState(() {
                                                    isBlocked = value.data()!['isBlocked'];
                                                    isBlockedMe = value.data()!['senderID'] == authB.userID! ? true: false;
                                                  });
                                                });
                                              },),
                                            CupertinoDialogAction(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },),
                                          ],
                                        );
                                      }
                                  );
                                },
                                child: Center(child: Text("Block ${widget.recieverName}",style: TextStyle(color: Colors.red),))),
                              Divider(),
                              Center(child: Text("Report ${widget.recieverName}",style: TextStyle(color: Colors.red),)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          shape: cardRadius,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(selectedBg)
                    )
                  ),
                  child: StreamBuilder(
                    stream: documentStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_controller.hasClients) {
                          _controller.jumpTo(_controller.position.maxScrollExtent);
                        } else {
                          setState(() => null);
                        }
                      });
                      if(snapshot.data == null){
                        return Container();
                      }else{
                        lastIndex = snapshot.data!.docs.length;
                        print(snapshot.data!.docs.length);
                        print(lastIndex);
                        return ListView(
                          children: [
                            ListView(
                              controller: _controller,
                              // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                return Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:data['senderID'] == authB.userID ?
                                    CrossAxisAlignment.end : CrossAxisAlignment.start,
                                    children: <Widget>[
                                      if(data['messageType'] == 'text')...[
                                        SizedBox(
                                          width: getWidth(context) / 1.5,
                                          child: GestureDetector(
                                            child: Align(
                                              alignment: data['senderID'] == authB.userID ?  Alignment.centerRight :Alignment.centerLeft ,
                                              child: Material(
                                                borderRadius: data['senderID'] == authB.userID
                                                    ? const BorderRadius.only(
                                                    topLeft: Radius.circular(30.0),
                                                    bottomLeft: Radius.circular(30.0),
                                                    bottomRight: Radius.circular(30.0))
                                                    : const BorderRadius.only(
                                                  bottomLeft: Radius.circular(30.0),
                                                  bottomRight: Radius.circular(30.0),
                                                  topRight: Radius.circular(30.0),
                                                ),
                                                elevation: 5.0,
                                                color: data['senderID'] == authB.userID ? kUniversalColor : Colors.grey[200],
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                  child: Text(
                                                    data['message'],
                                                    style: TextStyle(
                                                      color: data['senderID'] == authB.userID ? Colors.white : Colors.black54,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onLongPress: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CupertinoAlertDialog(
                                                      content: Text("Chose action to delete message"),
                                                      title: Column(
                                                        children: <Widget>[
                                                          Text("Delete Message?"),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          child: Text("Delete",style: TextStyle(color: Colors.red),),
                                                          onPressed: () async{
                                                            firestore.collection('chats').doc(authB.userID!).collection(widget.recieverPhone).doc(document.id).delete();
                                                            Navigator.of(context).pop();
                                                          },),
                                                        data['senderID'] == authB.userID ? CupertinoDialogAction(
                                                          child: Text("Delete From Everyone",style: TextStyle(color: Colors.red),),
                                                          onPressed: () {
                                                            firestore.collection('chats').doc(authB.userID!).collection(widget.recieverPhone).doc(document.id).delete();
                                                            firestore.collection('chats').doc(widget.recieverPhone).collection(authB.userID!).doc(document.id).delete();
                                                            Navigator.of(context).pop();
                                                          },):Container(),
                                                        CupertinoDialogAction(
                                                          child: Text("Cancel"),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },),
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                          ),
                                        ),
                                      ]else if(data['messageType'] == 'image')...[
                                        InkWell(
                                          onTap: (){
                                            nextScreen(context, ViewImage(userName: widget.recieverName, imageURl: data['message'],id: document.id,ref: firestore.collection('chats').doc(authB.userID!).collection(widget.recieverPhone).doc(document.id),));
                                          },
                                          child: Hero(
                                            tag: widget.recieverName,
                                            child: SizedBox(
                                              width:getWidth(context) / 1.9,
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment: data['senderID'] == authB.userID ? Alignment.centerRight : Alignment.centerLeft,
                                                    child: Container(
                                                      height: getHeight(context) / 5,
                                                      // padding: const EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        // color: kUniversalColor,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: CachedNetworkImageProvider(
                                                                 data['message'],
                                                                // placeholder: (c,d)=> Container(color: Colors.grey,),
                                                                // fadeInDuration: Duration(seconds: 1),
                                                              )
                                                          )
                                                      ),
                                                      width: getWidth(context) / 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ]
                                      else if(data['messageType'] == 'voice')...[
                                        // Text(data['message'])
                                VoiceMessage(
                                audioSrc: data['message'],
                                played: false, // To show played badge or not.
                                me: data['senderID'] == authB.userID ? true : false, // Set message side.
                                onPlay: () {}, // Do something when voice played.
                                )
                                        ]
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            image == null ? Container() :
                                SizedBox(
                                    width: getWidth(context) / 2,
                                    height: getHeight(context) / 5,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment:Alignment.centerRight,
                                          child: Container(
                                            height: getHeight(context) / 5,
                                            // padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              // color: kUniversalColor,
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(
                                                      File(image!.path),
                                                      // placeholder: (c,d)=> Container(color: Colors.grey,),
                                                      // fadeInDuration: Duration(seconds: 1),
                                                    )
                                                )
                                            ),
                                            width: getWidth(context) / 2,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        )
                                      ],
                                    ))
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              Wrap(
                children: [
                  isBlocked && isBlockedMe ?
                      Card(
                        child: Column(
                          children: [
                            Text("You blocked messages and calls from ${widget.recieverName}'s hapiverse Account",textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                            Text("You can't message or call them in this chat and you won't recieve their messages or calls",textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.grey),),
                            SizedBox(height: 10,),
                            SecendoryButton(text: "Unblock", onPressed: (){
                              unblockUser(authB.userID!, widget.recieverPhone, widget.recieverName, widget.profileImage);
                              // Navigator.pop(context);
                              firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(widget.recieverPhone).get().then((value){
                                setState(() {
                                  isBlocked = value.data()!['isBlocked'];
                                  isBlockedMe = value.data()!['senderID'] == authB.userID! ? true: false;
                                });
                              });
                            }),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ):isBlocked && isBlockedMe == false?
                  Card(
                    child: Column(
                      children: [
                        Text("${widget.recieverName} no longer to recieve your message",textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                        const Text("You can't message or call them in this chat and you won't recieve their messages or calls",textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.grey),),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  ):
                  isVoiceMessaging ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(onPressed: (){}, icon: const Icon(LineIcons.trash,color: Colors.red,)),
                              Text(formatDuration(Duration(seconds: voiceSeconds)),style: TextStyle(color: Colors.blue),),
                            ],
                          ),
                          // Text("Slide to cancel"),
                          GestureDetector(
                            onTap: ()async{
                              generateRandomString(13);
                              HapticFeedback.heavyImpact();
                              setState(() {
                                isVoiceMessaging = false;
                              });
                              endVoiceRecording(context,authB.userID!,authB.isBusinessShared! ? profileState.businessProfile!.logoImageUrl! : profileState.profileImage!);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.send),
                            ),
                          )
                        ],
                      ),
                    ),
                  ):Card(
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                            isEmojiOpen = !isEmojiOpen;
                          });
                        }, icon: const Icon(LineIcons.laughFaceWithBeamingEyes)),
                        Expanded(
                          child: AutoSizeTextField(
                            maxLines: null,
                            controller: message,
                            onTap: (){
                              setState(() {
                                isEmojiOpen = true;
                              });
                            },
                            onChanged: (v){
                              setState(() {
                                text = v;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message',
                            ),
                          ),
                        ),
                        message.text.isEmpty ? Row(
                          children: [
                            IconButton(
                              onPressed: ()async {
                                showModalBottomSheet(context: context, builder: (ctx){
                                  return Container(
                                    height: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap:()async{
                                              Navigator.pop(context);
                                              final ImagePicker _picker = ImagePicker();
                                              var mage = await _picker.pickImage(
                                                  source : ImageSource.camera);
                                              setState(() {
                                                image = mage;
                                              });
                                              if (image == null) return;
                                              var bytes = await image!.readAsBytes();
                                              if(bytes != null) {
                                                // print(image!.path);
                                                String filename = image!.path.split("/").last;
                                                print("fname eee $filename");
                                                String imageUrl = await uploadImage(bytes, widget.recieverPhone, filename,authB.userID!);
                                                print(imageUrl);
                                                generateRandomString(13);
                                                sendImageMessage(context, imageUrl, widget.recieverPhone, messageCount.toString(), widget.recieverName, widget.profileImage,authB.userID!,authB.isBusinessShared! ? profileState.businessProfile!.businessName! : profileBloc.userName,authB.isBusinessShared! ? "${Utils.baseImageUrl}${profileState.businessProfile!.logoImageUrl!}" :profileBloc.userImage).then((value) {
                                                  setState(() {
                                                    // image = null;
                                                  });
                                                });
                                                // _scrollDown();
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                // color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Center(child: Text("Camera",style: TextStyle(color: Colors.blue),)),
                                            ),
                                          ),
                                          Divider(),
                                          InkWell(
                                            onTap:()async{
                                              Navigator.pop(context);
                                              final ImagePicker _picker = ImagePicker();
                                              var mage = await _picker.pickImage(
                                                  source : ImageSource.gallery);
                                              setState(() {
                                                image = mage;
                                              });
                                              if (image == null) return;
                                              var bytes = await image!.readAsBytes();
                                              if(bytes != null) {
                                                print(image!.path);
                                                String filename = image!.path.split("/").last;
                                                String imageUrl = await uploadImage(bytes, widget.recieverPhone, filename,authB.userID!);
                                                print(imageUrl);
                                                generateRandomString(13);
                                                sendImageMessage(context, imageUrl, widget.recieverPhone, messageCount.toString(), widget.recieverName, widget.profileImage,authB.userID!,authB.isBusinessShared! ? profileState.businessProfile!.businessName! : profileBloc.userName,authB.isBusinessShared! ? "${Utils.baseImageUrl}${profileState.businessProfile!.logoImageUrl!}" :profileBloc.userImage).then((value) {
                                                  setState(() {
                                                    image = null;
                                                  });
                                                });
                                                // _scrollDown();
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                // color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Center(child: Text("Gallery",style: TextStyle(color: Colors.blue))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              icon: const Icon(
                                LineIcons.paperclip,
                                color: kUniversalColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async{
                                HapticFeedback.heavyImpact();
                                showModalBottomSheet(context: context, builder: (c){
                                  return StatefulBuilder(
                                    builder: (context,state) {
                                      return Container(
                                        child: SafeArea(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons.clear),
                                                        onPressed: ()=>Navigator.pop(context),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.all(16),
                                                      child: Text(
                                                        // If listening is active show the recognized words
                                                        _speechToText.isListening
                                                            ? '$_lastWords'
                                                        // If listening isn't active but could be tell the user
                                                        // how to start it, otherwise indicate that speech
                                                        // recognition is not yet ready or not supported on
                                                        // the target device
                                                            : _speechEnabled
                                                            ? 'Tap the microphone to start listening...'
                                                            : 'Speech not available',
                                                        style: TextStyle(fontSize: 22),
                                                      ),
                                                    ),
                                                  ),
                                                  _speechToText.isNotListening ? InkWell(
                                                    onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                                                    child: Material(     // Replace this child with your own
                                                      elevation: 8.0,
                                                      shape: const CircleBorder(),
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.grey[100],
                                                        child: Icon(Icons.mic),
                                                        radius: 30.0,
                                                      ),
                                                    ),
                                                  ):AvatarGlow(
                                                    endRadius: 100.0,
                                                    repeat: true,
                                                    animate: true,
                                                    showTwoGlows: true,
                                                    glowColor: kUniversalColor,
                                                    child: InkWell(
                                                      onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                                                      child: Material(     // Replace this child with your own
                                                        elevation: 8.0,
                                                        shape: const CircleBorder(),
                                                        child: CircleAvatar(
                                                          backgroundColor: Colors.grey[100],
                                                          child: Icon(Icons.mic),
                                                          radius: 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 40,)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                });
                                // if(authB.isBusinessShared == null || authB.isBusinessShared == false && authB.planID == 1){
                                //   showDialog(context: context, builder: (ctx){
                                //     return CupertinoAlertDialog(
                                //       // title: Text("Please Wait"),
                                //       content: CupertinoActivityIndicator(),
                                //     );
                                //   });
                                //   Future.delayed(Duration(seconds: 2),(){
                                //     Navigator.pop(context);
                                //     showDialog(context: context, builder: (ctx){
                                //       return CupertinoAlertDialog(
                                //         title: Text("Access Denied"),
                                //         content: Text("Please Upgrade your plan for Voice Chat"),
                                //         actions: [
                                //           CupertinoDialogAction(
                                //             onPressed: ()=> Navigator.pop(context),
                                //             child: Text("Cancel",style: TextStyle(color: Colors.red),),
                                //           ),
                                //           CupertinoDialogAction(
                                //             onPressed: (){},
                                //             child: Text("Upgrade Plan"),
                                //           ),
                                //         ],
                                //       );
                                //     });
                                //   });
                                // }else{
                                //   setState(() {
                                //     isVoiceMessaging = true;
                                //   });
                                //   startVoiceRecord();
                                // }
                              },
                              icon: const Icon(
                                Icons.mic,
                                color: kUniversalColor,
                              ),
                            ),
                          ],
                        ) :
                        IconButton(
                          onPressed: () {
                            print(message.text);
                            generateRandomString(13);
                            sendTextMessage(context, text, widget.recieverPhone, messageCount.toString(), widget.recieverName, widget.profileImage,authB.userID!,authB.isBusinessShared! ? profileState.businessProfile!.businessName! :profileBloc.userName,authB.isBusinessShared! ? "${Utils.baseImageUrl}${profileState.businessProfile!.logoImageUrl!}" :"${Utils.baseImageUrl}${profileBloc.userImage}");
                            message.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.send,
                            color: kUniversalColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: isEmojiOpen,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                          onEmojiSelected: (Category? category, Emoji? emoji) {
                            onEmojiSelected(emoji!);
                          },
                          onBackspacePressed: onBackspacePressed,
                          config: Config(
                              columns: 7,
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              initCategory: Category.RECENT,
                              bgColor: const Color(0xFFF2F2F2),
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              showRecentsTab: true,
                              recentsLimit: 28,
                              noRecents: Text('No Recents',style:TextStyle(
                                  fontSize: 20, color: Colors.black26),),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL)),
                    ),),
                ],
              )
            ],
          ),
        ),
      )
    );
  },
);
  }
  // DateTime date = DateTime.now();
  String docId = '';
  // FirebaseFirestore firestore = FirebaseFirestore.instance;


  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'BCDEFGxcbHIJKLsdfdMNOPhfQRSTUdfdfcvVWXYZ';
    docId = List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  sendTextMessage(BuildContext context,String message,String recieverPhone,String messageCount,String recieverName,String profileImage,String userID,String userName,String userProfile){
    print("here");
    print(message);
    firestore.collection('chats').doc(userID).collection(recieverPhone).doc(docId).set({
      'message': message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userName,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'text',
      'isFavorite':false,
      'id':docId,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
    });
    firestore.collection('chats').doc(recieverPhone).collection(userID).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userName,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      'isFavorite':false,
      'id':docId,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':userName,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token': widget.fcmToken,
    });
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'text',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token':widget.fcmToken,
    });
  }


  clearChat(String userID,String recieverPhone,String recieverName,String profileImage){
    firestore.collection('chats').doc(userID).collection(widget.recieverPhone).get().then((doc){
      for(var i in doc.docs){
        firestore.collection('chats').doc(userID).collection(widget.recieverPhone).doc(i.id).delete();
      }
    });
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':'',
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':true,
      'isOnline':true,
      'messageType': 'text',
      'deleted':false,
      'deleteEveryOne':false,
      'isBlocked':false,
      'isBlockedMe':false,
      'isGroup':true,
      // 'token':widget.fcmToken,
    });
  }

  blockUser(String userID,String recieverPhone,String recieverName,String profileImage){
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':'',
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':true,
      'isOnline':true,
      'messageType': 'text',
      'deleted':false,
      'deleteEveryOne':false,
      'isBlocked':true,
      'isBlockedMe':true,
      // 'token':widget.fcmToken,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      'isBlocked':true,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false
      // 'token': widget.fcmToken,
    });

  }
  unblockUser(String userID,String recieverPhone,String recieverName,String profileImage){
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':'',
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':true,
      'isOnline':true,
      'messageType': 'text',
      'deleted':false,
      'deleteEveryOne':false,
      'isBlocked':false,
      'isBlockedMe':false,
      // 'token':widget.fcmToken,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      'isBlocked':true,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      // 'token': widget.fcmToken,
    });

  }


  Future<bool> sendImageMessage(BuildContext context,message,String recieverPhone,String messageCount,String recieverName,String profileImage,String userID,String userName,String userProfile)async{
print(userID);
print(recieverPhone);

    firestore.collection('chats').doc(userID).collection(recieverPhone).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'image',
      'isFavorite':false,
      'id':docId,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
    });
    firestore.collection('chats').doc(recieverPhone).collection(userID).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'image',
      'isFavorite':false,
      'id':docId,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':userName,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'image',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token': widget.fcmToken,
    });
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'image',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token':widget.fcmToken,
    });
    return true;
  }

  Future<bool> sendVoiceMessage(BuildContext context,message,String recieverPhone,String messageCount,String recieverName,String profileImage,String userID,String userName,String userProfile)async{
    print(userID);
    print(recieverPhone);

    firestore.collection('chats').doc(userID).collection(recieverPhone).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'voice',
      'isFavorite':false,
      'id':docId,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
    });
    firestore.collection('chats').doc(recieverPhone).collection(userID).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'voice',
      'isFavorite':false,
      'id':docId,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':userName,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'voice',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token': widget.fcmToken,
    });
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'voice',
      'isBlocked':false,
      'isBlockedMe':false,
      'deleted':false,
      'deleteEveryOne':false,
      'isGroup':true,
      // 'token':widget.fcmToken,
    });
    return true;
  }
}
