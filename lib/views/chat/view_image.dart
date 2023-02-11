import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewImage extends StatefulWidget {
  final userName;
  final String imageURl;
  final String id;
  final DocumentReference ref;

  ViewImage({required this.userName,required this.imageURl,required this.id,required this.ref});
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.userName),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(context: context, builder: (c){
              return Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Center(child: Text("Delete",style: TextStyle(color: Colors.red),)),
                        onTap: (){
                          widget.ref.delete();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Center(child: Text("Cancel",style: TextStyle(color: Colors.blue),)),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
          }, icon: Icon(Icons.more_vert,color: Colors.white,))
        ],
      ),
      body: Hero(
        tag: widget.userName,
        child: Center(
          child: Image.network(widget.imageURl),
        ),
      ),
    );
  }
}
