import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
class AudioOnGoing extends StatefulWidget {
  final String userName;
  final String avatar;
  final String channelId;

  const AudioOnGoing({Key? key,required this.userName,required this.avatar,required this.channelId}) : super(key: key);

  @override
  _AudioOnGoingState createState() => _AudioOnGoingState();
}

class _AudioOnGoingState extends State<AudioOnGoing> {

  AudioPlayer audioPlayer = AudioPlayer();

  ringCallTune(){
    audioPlayer.play('outgoing.mp3');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.avatar
            )
          )
        ),
        child: Column(
          children: [
            SizedBox(height: getHeight(context) / 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,size: 40,),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.avatar),
            ),
            const SizedBox(height: 10,),
            Text(widget.userName,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            const Text("Calling"),
            Spacer(),
            InkWell(
              onTap: ()=> ringCallTune(),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red,
                child: Icon(Icons.call_end,color: Colors.white,size: 35,),
              ),
            ),
            SizedBox(height: getHeight(context) / 9,)
          ],
        ),
      ),
    );
  }
}
