import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happiverse/logic/post_cubit/post_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';

import '../../../utils/constants.dart';

class EditLocalPost extends StatefulWidget {
  final String postType;
  final bool isBusiness;
  const EditLocalPost({Key? key,required this.postType,required this.isBusiness}) : super(key: key);

  @override
  State<EditLocalPost> createState() => _EditLocalPostState();
}

class _EditLocalPostState extends State<EditLocalPost> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PostCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white70,
            leading: const BackButton(color: Colors.black,),
            title: Text("Edit Post",style: TextStyle(color: Colors.black),),
            actions: [
              TextButton(
                onPressed: (){
                  bloc.editPost(authB.userId,authB.accesToken!,state.postId!,state.postController.text,state.dropVal == "🌎 Public" ? "Public" : "Private",context);
                },
                child: Text(getTranslated(context, 'SHARE')!),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<ProfileCubit,ProfileState>(
                          builder: (context,stateP) {
                            return Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    children:  [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(widget.isBusiness ? "${Utils.baseImageUrl}${stateP.businessProfile!.logoImageUrl}":"${Utils.baseImageUrl}${stateP.profileImage}"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Row(
                                          children: [
                                            Expanded(child: Text("${widget.isBusiness ? stateP.businessProfile!.businessName:stateP.profileName} ${state.currentPlace != null ? " - ${state.currentPlace}":""}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),)),
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          height: 25,
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.3)
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              items: state.dropList.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value,style: const TextStyle(fontSize: 9),),
                                                );
                                              }).toList(),
                                              value: state.dropVal,
                                              onChanged: (val)=>bloc.changeDropVal(val!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      widget.postType != 'text' ? AutoSizeTextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        controller: state.postController,
                      ):Container(),
                      SizedBox(height: 10,),
                      if(widget.postType == 'image')...[
                        StaggeredGrid.count(
                          crossAxisCount: state.showImages!.length == 1 ? 1 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          children: state.showImages!.map((e){
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.file(File(e),fit: BoxFit.fill,)
                              ),
                            );
                          }).toList(),
                        ),
                      ]
                      else if(widget.postType == 'text')...[
                        Container(
                          height: getHeight(context) / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit:BoxFit.fill,
                                  image: AssetImage(
                                      state.postBGImage!
                                  )
                              )
                          ),
                          child: Center(
                            child: AutoSizeTextField(
                              maxLines: null,
                              style: state.captionTextStyle,
                              controller: state.postController,
                              textAlign: TextAlign.center,
                              onTap: ()=> bloc.changeBottomSheetSize(),
                              decoration: InputDecoration(
                                  hintText: getTranslated(context, 'WRITE_SOMETHING')!,
                                  border: InputBorder.none,
                                  hintStyle: state.captionTextStyle
                              ),
                              onChanged: (val){
                                bloc.ontextControllerChange(val);
                              },
                            ),
                          ),
                        )
                      ]
                      else ...[

                        ]
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
