import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/post_cubit/post_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../logic/story/story_cubit.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
class MyStoryWidgetPage extends StatefulWidget {

  const MyStoryWidgetPage({Key? key,}) : super(key: key);
  @override
  _MyStoryWidgetPageState createState() => _MyStoryWidgetPageState();
}

class _MyStoryWidgetPageState extends State<MyStoryWidgetPage> {

  int index = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    // widget.controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryCubit>();
    final feedB = context.read<FeedsCubit>();
    final postBloc = context.read<PostCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Hero(
                tag: 'story',
                child: StoryView(
                    repeat: false,
                    inline: true,
                    storyItems: state.myStoryShow![0].storyItem,
                    controller: state.myStoryShow![0].controller, // pass controller here too
                    // should the stories be slid forever
                    onStoryShow: (s) {print("sssss $s");
                    index++;
                    print("inddd $index");
                      // state.myStoryShow![0].controller.playbackNotifier.stream.listen((event) {
                      //   print("streeeen   ${event.index}");
                      // });
                    },
                    onComplete: (){
                      Navigator.pop(context);
                    },
                    onVerticalSwipeComplete: (direction) {
                      if (direction == Direction.down) {
                        Navigator.pop(context);
                      }
                    } // To disable vertical swipe gestures, ignore this parameter.
                  // Preferrably for inline story view.
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(state.myStoryShow![0].profileImage),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.myStoryShow![0].title,style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                                  Text(state.myStoryShow![0].date,style: const TextStyle(fontSize: 11,color: Colors.white),)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                state.myStoryShow![0].controller.pause();
                                showModalBottomSheet(
                                    isDismissible: false,
                                    context: context, builder: (ctx){
                                  return Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap:(){
                                            for(var i = 0; i < state.myStoryShow!.length; i++){
                                              for(var n in state.myStoryShow![i].storyIdModel){
                                                postBloc.deleteStory(authB.userID!, authB.accesToken!, context, n.storyId);
                                                print("called ${n.storyId}");
                                              }
                                            }
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          title: Text("Delete Story",style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),
                                        ),
                                        ListTile(
                                          onTap:(){
                                            Navigator.pop(context);
                                            state.myStoryShow![0].controller.play();
                                          },
                                          title: Text("Cancel",style: TextStyle(),textAlign: TextAlign.center,),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }, icon: Icon(Icons.more_vert,color: Colors.white,)),
                              InkWell(onTap: ()=> Navigator.pop(context), child: Icon(Icons.clear,color: Colors.white,),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 100.0),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Text(state.myStoryShow![0].title,style: TextStyle(fontSize: 20),),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     height: 80,
              //     child: Card(
              //       shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(20),
              //             topRight: Radius.circular(20),
              //           )),
              //       child: GestureDetector(
              //         onVerticalDragDown: (v){
              //           state.myStoryShow![0].controller.play();
              //         },
              //         onVerticalDragStart: (v){
              //           state.myStoryShow![0].controller.pause();
              //           showModalBottomSheet(
              //               shape: const RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(20),
              //                     topRight: Radius.circular(20),
              //                   )),
              //               context: context, builder: (c){
              //             return Container(
              //               child: Column(
              //                 children: [
              //                   ListTile(
              //                     leading: Icon(LineIcons.eye),
              //                     title: Text("5 views"),
              //                     trailing: Icon(Icons.keyboard_arrow_down),
              //                   ),
              //                   Divider(),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Row(
              //                       children: [
              //                         Text("Commnets",style: TextStyle(color: Colors.grey),),
              //                       ],
              //                     ),
              //                   ),
              //                   Expanded(
              //                     child: ListView.builder(
              //                       shrinkWrap: true,
              //                       itemCount: 30,
              //                       itemBuilder: (c,i){
              //                         return ListTile(
              //                           leading: CircleAvatar(
              //                             backgroundImage: NetworkImage("http://marianatech.co.uk/postdoc/25db7a4f189f75cb4bcab3b088473b93.jpg"),
              //                           ),
              //                           title: Text("Ameer HAmza $i"),
              //                           subtitle: Text(i % 2 == 0 ? "My Comment bda gnda hai tu loolll sdf sdfdfdsf df dfds sdf sdfs sgsdfds sdf sdf dsf sd ds gfsgsgfdg fg":""),
              //                         );
              //                       },
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             );
              //           });
              //         },
              //         child: ListTile(
              //           leading: Icon(LineIcons.eye),
              //           title: Text("5 views"),
              //           trailing: Icon(Icons.keyboard_arrow_up_sharp),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: [
              //           Container(
              //             height: 40,
              //             padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
              //             decoration:BoxDecoration(
              //               borderRadius: BorderRadius.circular(10) ,
              //               color:Colors.white,
              //             ),
              //             width: MediaQuery.of(context).size.width - 50,
              //             child: TextField(
              //               controller: state.storyCommentController,
              //               decoration: InputDecoration(
              //                   border: InputBorder.none,
              //                   hintText: "Type Something",
              //                   suffixIcon: IconButton(
              //                     onPressed: (){
              //                       state.storyCommentController.clear();
              //                       bloc.sendStoryCommnet(authB.userID!,authB.accesToken!,widget.storyId);
              //                     },
              //                     icon: Icon(Icons.send),
              //                   )
              //               ),
              //
              //             ),
              //           ),
              //           // IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,)),
              //           // IconButton(onPressed: (){}, icon: Icon(Icons.star,color: Colors.orangeAccent,)),
              //           // IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_sharp,color: Colors.blue,)),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        );
        // return DismissiblePage(
        //   onDismissed: () {
        //     Navigator.of(context).pop();
        //   },
        //   direction: DismissiblePageDismissDirection.multi,
        //   child:
        // );
      },
    );
  }
}
