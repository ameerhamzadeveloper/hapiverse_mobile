import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/story_model.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../views/feeds/story/story_widget.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final int index;

  StoryViewPage({Key? key,required this.index}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  late PageController pageController;

  void onStatusFinished(int index) {
    setState(() {
      pageController.jumpToPage(index);
    });
  }
  var currentPageValue = 1.0;

  @override
  void initState() {
    super.initState();
    // widget.index == 0 ? currentPageValue = 0.0:1.0;
    // setState(() {});
    pageController = PageController(
      initialPage: widget.index,
      keepPage: true,
    );
    pageController.addListener(() {
      setState(() {
        print(pageController.page);
        currentPageValue = pageController.page!;
        print(currentPageValue);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        void changePageViewPostion(int whichPage) {
          print("Func call");
          if(pageController != null){
            whichPage = whichPage + 1; // because position will start from 0
            double jumpPosition = MediaQuery.of(context).size.width / 2;
            double orgPosition = MediaQuery.of(context).size.width / 2;
            for(int i=0; i < state.storyList!.length; i++){
              pageController.jumpTo(jumpPosition);
              if(i==whichPage){
                break;
              }
              jumpPosition = jumpPosition + orgPosition;
            }
          }
        }
        return Scaffold(
          body: PageView.builder(
            controller: pageController,
            clipBehavior: Clip.antiAlias,
            itemCount: state.storyList!.length,
            itemBuilder: (ctx, i) {
              var inde = i;
              if (i == currentPageValue.floor()) {
                return Transform(
                  transform: Matrix4.identity()..rotateX(currentPageValue - i),
                  child: InkWell(
                    onTap: (){
                      changePageViewPostion(inde++);
                      print("cahngel");
                    },
                    child: StoryWidgetPage(
                      storyIdModel: state.storyApiList!,
                      title: state.storyList![i].title,
                      image: state.storyList![i].profileImage,
                      date: state.storyList![i].date,
                      storyItem: state.storyList![i].storyItem,
                      controller: state.storyList![i].controller,
                      storyId: i.toString(),
                      onFinish: () {
                        // onStatusFinished(inde++);
                        if(state.storyList!.length > inde){
                          print(i++);
                          print("Finish Call Back");
                          pageController.jumpToPage(i++);
                        }
                        //   changePageViewPostion(inde++);
                        // }
                      },
                    ),
                  )
                );
              }else if(i == currentPageValue.floor() + 1){
                return Transform(
                  transform: Matrix4.identity()..rotateX(currentPageValue - i),
                  child: InkWell(
                    onTap: (){
                      changePageViewPostion(inde++);
                      print("cahngel");
                    },
                    child: StoryWidgetPage(
                      storyIdModel: state.storyApiList!,
                      title: state.storyList![i].title,
                      image: state.storyList![i].profileImage,
                      date: state.storyList![i].date,
                      storyItem: state.storyList![i].storyItem,
                      controller: state.storyList![i].controller,
                      storyId: i.toString(),
                      onFinish: () {
                        // onStatusFinished(inde++);
                        if(state.storyList!.length > inde){
                          print(i++);
                          print("Finish Call Back");
                          pageController.jumpToPage(i++);
                        }
                        //   changePageViewPostion(inde++);
                        // }
                      },
                    ),
                  )
                );
              }else{
                return InkWell(
                  onTap: (){
                    changePageViewPostion(inde++);
                    print("cahngel");
                  },
                  child: StoryWidgetPage(
                    storyIdModel: state.storyApiList!,
                    title: state.storyList![i].title,
                    image: state.storyList![i].profileImage,
                    date: state.storyList![i].date,
                    storyItem: state.storyList![i].storyItem,
                    controller: state.storyList![i].controller,
                    storyId: i.toString(),
                    onFinish: () {
                      // onStatusFinished(inde++);
                      if(state.storyList!.length > inde){
                        print(i++);
                        print("Finish Call Back");
                        print("cpdf${pageController.page}");
                        pageController.jumpToPage(i++);
                      }
                      //   changePageViewPostion(inde++);
                      // }
                    },
                  ),
                );
              }
              print("Story Item ${state.storyList![i].storyItem.length}");
            },
          ),
        );

      },
    );

  }

}
