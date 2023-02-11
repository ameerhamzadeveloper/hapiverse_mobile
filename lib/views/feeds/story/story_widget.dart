import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/data/model/story_api_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../data/model/story_id.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../logic/story/story_cubit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
class StoryWidgetPage extends StatefulWidget {
  final List<StoryItem> storyItem;
  final StoryController controller;
  final VoidCallback onFinish;
  final String title;
  final String image;
  final String date;
  final String storyId;
  final List<StoryAPI> storyIdModel;
  const StoryWidgetPage({Key? key,
    required this.storyItem,required this.controller,
    required this.onFinish,required this.date,required this.title,required this.image,required this.storyId,required this.storyIdModel}) : super(key: key);
  @override
  _StoryWidgetPageState createState() => _StoryWidgetPageState();
}

class _StoryWidgetPageState extends State<StoryWidgetPage> {
  int storyIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
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
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<StoryCubit, StoryState>(
  builder: (context, state) {
    return GestureDetector(
      onTap: widget.onFinish,
      child: Stack(
        children: [
          // Expanded(
          //   child: Column(
          //     children: [
          //       SafeArea(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: widget.storyIdModel.map((e){
          //             return Padding(
          //               padding: const EdgeInsets.only(left: 4.0),
          //               child: Expanded(
          //                 child: LinearProgressIndicator(
          //                   value: 0.6,
          //                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
          //                   // width: 100.0,
          //                   // lineHeight: 5.0,
          //                   // percent: 0.5,
          //                   backgroundColor: Colors.grey[300],
          //                   // progressColor: Colors.grey,
          //                   // barRadius: const Radius.circular(4),
          //                 ),
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          StoryView(
              repeat: true,
              inline: false,
              // progressPosition: ProgressPosition.,
              storyItems: widget.storyItem,
              controller: widget.controller, // pass controller here too
              // should the stories be slid forever
              onStoryShow: (s) {
                storyIndex++;
                print("indexxxx $storyIndex");
              },
              onComplete: widget.onFinish,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              } // To disable vertical swipe gestures, ignore this parameter.
            // Preferrably for inline story view.
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
                                backgroundImage: NetworkImage(widget.image),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                              Text(widget.date,style: TextStyle(fontSize: 11,color: Colors.white),)
                            ],
                          )
                        ],
                      ),
                      IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear,color: Colors.white,))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10) ,
                        color:Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextField(
                        controller: state.storyCommentController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Something",
                            suffixIcon: IconButton(
                              onPressed: (){
                                state.storyCommentController.clear();
                                bloc.sendStoryCommnet(authB.userID!,authB.accesToken!,widget.storyId);
                              },
                              icon: Icon(Icons.send),
                            )
                        ),

                      ),
                    ),
                    // IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,)),
                    // IconButton(onPressed: (){}, icon: Icon(Icons.star,color: Colors.orangeAccent,)),
                    // IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_sharp,color: Colors.blue,)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
