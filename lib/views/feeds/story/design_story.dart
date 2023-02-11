import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../logic/story/story_cubit.dart';
class DesignStory extends StatefulWidget {
  const DesignStory({Key? key}) : super(key: key);
  @override
  _DesignStoryState createState() => _DesignStoryState();
}
class _DesignStoryState extends State<DesignStory> {

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<StoryCubit,StoryState>(
      builder: (context,state) {
        return Scaffold(
          body: PageView.builder(
            onPageChanged: (v){
              bloc.assignColor(v);
            },
            itemCount: 5,
            itemBuilder: (ctx,i){
              return Container(
                color: state.pageColor[i],
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeTextField(
                        maxLines: null,
                          // openEmoji()
                        onTap: (){
                          bloc.hideEmoji();
                          // if(_keyboardIsVisible()){
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          //   bloc.openEmoji();
                          // }else{
                          //   bloc.openEmoji();
                          // }
                        },
                        onChanged: (v){
                          bloc.assignText(v);
                        },
                        controller: state.message,
                        style: state.textStyle1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintStyle: state.textStyle,
                          hintText: "Type a Status",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed: (){
                                    if(_keyboardIsVisible()){
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      bloc.openEmoji();
                                    }else{
                                      bloc.openEmoji();
                                    }
                                  }, icon: Icon(Icons.emoji_emotions,color: Colors.white,),),
                                  const SizedBox(width: 20,),
                                  IconButton(onPressed: (){bloc.getFonst();}, icon: Icon(Icons.text_format,color: Colors.white,),)
                                ],
                              ),
                              Row(
                                children: [
                                  state.captionVal.isNotEmpty ? InkWell(
                                    onTap: (){
                                      bloc.postStory(authB.userID!,authB.accesToken!,authB.isBusinessShared! ? true:false,context);
                                      Navigator.pop(context);
                                    },
                                    child: const CircleAvatar(
                                      child: Icon(Icons.check),
                                    ),
                                  ):const Text("")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Offstage(
                        offstage: state.isEmojiOpen,
                        child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                              onEmojiSelected: (Category? category, Emoji? emoji) {
                                bloc.onEmojiSelected(emoji!);
                              },
                              onBackspacePressed: bloc.onBackspacePressed,
                              config: Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  noRecents: Text('No Recents',style:TextStyle(
                                      fontSize: 20, color: Colors.black26),),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL)),
                        ),),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}
