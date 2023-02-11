import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../views/chat/chat_group/add_members.dart';
import '../../views/chat/conservation.dart';
import '../../views/components/universal_card.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_icons/line_icons.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final Stream<QuerySnapshot> documentStream = firestore.collection('recentChats').doc(authB.userID).collection('myChats').orderBy('timestamp',descending: true).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'CHAT')!),
        // actions: [
        //   IconButton(onPressed: (){
        //     showModalBottomSheet(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(15.0),
        //         ),
        //         context: context, builder: (ctx,){
        //       return Container(
        //         height: 340,
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           children: [
        //             Container(
        //               width: 40,
        //               height: 5,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: Colors.grey[300],
        //               ),
        //             ),
        //             SizedBox(height: 20,),
        //             InkWell(
        //               onTap: (){
        //                 nextScreen(context, AddMemberChatGroup());
        //               },
        //               child: Container(
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(7),
        //                     color: Colors.grey[300]
        //                 ),
        //                 child: Center(
        //                   child: Row(
        //                     children: [
        //                       Icon(LineIcons.plus),
        //                       SizedBox(width: 10,),
        //                       Text("Create Group")
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     });
        //   }, icon: Icon(Icons.add))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          shape: cardRadius,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left:8.0),
                  child: Center(
                    child: TextField(
                      // autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search,size: 20,),
                            onPressed: () {},
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              StreamBuilder(
                stream: documentStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.data == null){
                    return Center(child: Text("No Message"),);
                  }else if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx,i){
                        var data = snapshot.data!.docs[i];
                        return Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (v){
                                  firestore.collection('chats').doc(authB.userID!).collection(data['recieverID']).get().then((doc){
                                    for(var i in doc.docs){
                                      firestore.collection('chats').doc(authB.userID!).collection(data['recieverID']).doc(i.id).delete();
                                    }
                                  });
                                  firestore.collection('recentChats').doc(authB.userID!).collection('myChats').doc(data['recieverID']).delete();
                                },
                                // backgroundColor: Colors.red,
                                foregroundColor: Colors.red,
                                icon: LineIcons.trash,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: (){
                              nextScreen(context, ConservationPage(profileImage: data['profileImage'], recieverPhone: data['recieverID'] == authB.userID ? data['senderID'] : data['recieverID'], recieverName: data['recieverName']));
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(data['profileImage']),
                            ),
                            title: Text(data['recieverName']),
                            subtitle:data['messageType'] == 'voice'? Row(
                              children: [
                                Icon(Icons.mic),
                                Text("Voice Message")
                              ],
                            ): data['messageType'] == 'image'? Row(
                              children: [
                                Icon(Icons.image,size: 15,),
                                SizedBox(width: 2,),
                                data['recieverID'] == authB.userID!  && data['isSeen'] == false ? Text("Image",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),): Text("Image")
                              ],
                            ):data['recieverID'] == authB.userID! && data['isSeen'] == false ? Text(data['lastMessage'].toString().length > 24 ? "${data['lastMessage'].toString().substring(0,24)}..." : data['lastMessage'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),):Text(data['lastMessage'].toString().length > 24 ? "${data['lastMessage'].toString().substring(0,24)}..." : data['lastMessage'].toString(),),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Jiffy(data['timestamp'].toDate(), "MM dd, yyyy at hh:mm a").fromNow().toString(),style: const TextStyle(fontSize: 11),),
                                data['recieverID'] == authB.userID!  && data['isSeen'] == false ? Icon(Icons.circle,color: kUniversalColor,size: 10,):Container(width: 10,)
                                // data['senderID'] == authB.userID ? const Text(""):CircleAvatar(
                                //   radius: 10,
                                //   backgroundColor: kUniversalColor,
                                //   child: Text(data['count'].toString(),style: TextStyle(fontSize: 11),),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.data!.docs.length == 0){
                    return Center(
                      child: Text("No Messages"),
                    );
                  }else{
                    return Center(child: Text("Something Went Wrong"),);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

