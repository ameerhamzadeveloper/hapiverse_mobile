import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayerScreen extends StatefulWidget {
  final YoutubePlayerController controller;
  MoviePlayerScreen({Key? key, required this.controller})
      : super(key: key);
  @override
  _MoviePlayerScreenState createState() => _MoviePlayerScreenState(controller);
}

class _MoviePlayerScreenState extends State<MoviePlayerScreen> {
  final YoutubePlayerController controller;

  _MoviePlayerScreenState(this.controller);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Stack(
          children: <Widget>[
            Center(
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
              ),
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: IconButton(icon: Icon(EvaIcons.closeCircle, color: Colors.white, size: 30.0,), onPressed: () {
                Navigator.pop(context);
              }),
            )
          ],
        )
    );
  }
}