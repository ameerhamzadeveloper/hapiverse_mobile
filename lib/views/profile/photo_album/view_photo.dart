import 'package:flutter/material.dart';
class ViewPhoto extends StatefulWidget {
  final String path;
  final String tag;
  final String title;
  const ViewPhoto({Key? key,required this.path,required this.tag,required this.title}) : super(key: key);
  @override
  _ViewPhotoState createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(widget.title),
      // ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: widget.tag,
              child: Image.network(widget.path)),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: ()=> Navigator.pop(context),
                icon: Icon(Icons.clear,color: Colors.white,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
