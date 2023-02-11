import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../utils/utils.dart';

import '../../utils/constants.dart';
import '../profile/see_profile_image.dart';
class ChatMediaPage extends StatefulWidget {
  final Future<QuerySnapshot<Map<String, dynamic>>> collectionID;
  const ChatMediaPage({Key? key,required this.collectionID}) : super(key: key);

  @override
  _ChatMediaPageState createState() => _ChatMediaPageState();
}

class _ChatMediaPageState extends State<ChatMediaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: widget.collectionID,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasData){
                  return StaggeredGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    children: snapshot.data!.docs.map((e){
                      Map<String, dynamic> data = e.data()! as Map<String, dynamic>;
                      if(snapshot.data!.docs.isEmpty){
                        return Center(child: Text("No Media"),);
                      }
                      // return Text(data['message']);
                      return InkWell(
                        onTap: (){
                          nextScreen(context, SeeProfileImage(imageUrl: data['message'],title: data['profileImage'],));
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
                              child: CachedNetworkImage(
                                imageUrl: data['message'],
                              )
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CupertinoActivityIndicator(),);
                }else{
                  return Text("No Media");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
