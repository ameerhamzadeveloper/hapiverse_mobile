import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/story/story_cubit.dart';

import '../../../logic/register/register_cubit.dart';
class AddImagePageStory extends StatefulWidget {
  const AddImagePageStory({Key? key}) : super(key: key);

  @override
  _AddImagePageStoryState createState() => _AddImagePageStoryState();
}

class _AddImagePageStoryState extends State<AddImagePageStory> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<StoryCubit,StoryState>(
      builder: (context,state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("Add Image"),
            actions: [
              IconButton(onPressed: (){
                bloc.postStory(authB.userID!,authB.accesToken!,authB.isBusinessShared! ? true:false,context);
                Navigator.pop(context);
              }, icon: Icon(Icons.check))
            ],
          ),
          body: Stack(
            children: [
              Center(
                child: Image.file(File(state.storyImage!.path),),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child: Container(
              //       padding: const EdgeInsets.only(left: 8),
              //       height: 40,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         // border: Border.all(),
              //         color: Colors.grey[300]
              //       ),
              //       child: TextField(
              //         controller: state.message,
              //         decoration: InputDecoration(
              //           hintText: "Add Caption",
              //           border: InputBorder.none
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        );
      }
    );
  }
}
