import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
class PreviewProfileAvatar extends StatefulWidget {
  final String avatarType;
  final String profileUrl;
  final String flatColor;
  final String gredient1;
  final String gredient2;
  final String? text;
  const PreviewProfileAvatar({Key? key,required this.flatColor,required this.avatarType,required this.text,required this.gredient1,required this.gredient2,required this.profileUrl}) : super(key: key);

  @override
  State<PreviewProfileAvatar> createState() => _PreviewProfileAvatarState();
}

class _PreviewProfileAvatarState extends State<PreviewProfileAvatar> {
   getColors(int i){
    switch(i){
      case 1:
        return Colors.blue;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.deepOrangeAccent;
      case 4:
        return Colors.green;
      case 5:
        return Colors.yellowAccent;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: widget.avatarType  == "0"? CircleAvatar(radius: 180,backgroundImage: NetworkImage(widget.profileUrl),):
            widget.avatarType  == "1" ? SizedBox(
              // width: 100,
              child: Stack(
                children: [
                  Center(
                      child: CircleAvatar(
                        radius: 180,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 25,
                                  color: getColors(int.parse(widget.flatColor)).withOpacity(0.8)
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.profileUrl)
                              )
                          ),
                        ),
                      )
                  ),
                  widget.text == null ? Container():Center(
                    child: CircularText(
                      children: [
                        TextItem(
                          text: Text(
                            widget.text!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          space: 10,
                          startAngle: 90,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: CircularTextDirection.anticlockwise,
                        ),
                      ],
                      radius: 180,
                      position: CircularTextPosition.inside,
                    ),
                  ),
                ],
              ),
            ): SizedBox(
              // width: 100,
              child: Stack(
                children: [
                  Center(
                      child: CircleAvatar(
                        radius: 180,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [
                                    getColors(int.parse(widget.gredient1)),
                                    getColors(int.parse(widget.gredient2)),
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.profileUrl)
                                )
                            ),
                          ),
                        ),
                      )
                  ),
                  widget.text == null ? Container():Center(
                    child: CircularText(
                      children: [
                        TextItem(
                          text: Text(
                            widget.text!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          space: 10,
                          startAngle: 90,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: CircularTextDirection.anticlockwise,
                        ),
                      ],
                      radius: 180,
                      position: CircularTextPosition.inside,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.clear,color: Colors.black,),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
