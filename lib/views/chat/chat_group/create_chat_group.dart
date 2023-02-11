import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/groups/groups_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/utils.dart';

class CreateChatGroup extends StatefulWidget {
  const CreateChatGroup({Key? key}) : super(key: key);

  @override
  _CreateChatGroupState createState() => _CreateChatGroupState();
}

class _CreateChatGroupState extends State<CreateChatGroup> {
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final groupB = context.read<GroupsCubit>();
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("New Group"),
            actions: [
              BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profileState) {
    return MaterialButton(
                onPressed: state.chatGroupName == null || state.chatGroupImage == null || state.chatGroupName!.length == 0 ? null: () {
                  // nextScreen(context, CreateChatGroup());
                  groupB.createChatGroup(authB.userID!, profileState.profileName!, profileState.profileImage!,context);
                },
                child: Text("Create", style: TextStyle(color:state.chatGroupName == null || state.chatGroupImage == null || state.chatGroupName!.length == 0 ? Colors.grey: Colors.white),),
              );
  },
)
            ],
          ),
          body: UniversalCard(
            widget: Column(
              children: [
                Row(
                  children: [
                    state.chatGroupImage != null ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(state.chatGroupImage!),
                        ),
                        TextButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              groupB.takeChatGroupImageCamera();
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(LineIcons.camera),
                                                SizedBox(width: 10,),
                                                Text("Camera")
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          MaterialButton(
                                            onPressed: () {
                                              groupB.takeChatGroupImageGallery();
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(LineIcons.image),
                                                SizedBox(width: 10,),
                                                Text("Gallary")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                          }, child: Text("Edit"))
                      ],
                    ):InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          groupB.takeChatGroupImageCamera();
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(LineIcons.camera),
                                            SizedBox(width: 10,),
                                            Text("Camera")
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      MaterialButton(
                                        onPressed: () {
                                          groupB.takeChatGroupImageGallery();
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(LineIcons.image),
                                            SizedBox(width: 10,),
                                            Text("Gallary")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                    const SizedBox(width: 10,),
                     Expanded(child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Group Name"
                      ),
                      onChanged: (val){
                        groupB.assignChatGroupName(val);
                      },
                    ))
                  ],
                ),
                const SizedBox(height: 40,),
                Row(
                  children: const[
                     Text("Participents",style: TextStyle(color: Colors.grey),),
                  ],
                ),
                const SizedBox(height: 10,),
                SingleChildScrollView(
                  child: Row(
                    children: List.generate(state.addedMemberChatGroup!.length, (index){
                      var p = state.addedMemberChatGroup![index];
                      return Container(
                        height: 70,
                        width: 60,
                        child: Stack(
                          children: [
                            Align(
                              alignment:Alignment.center,
                              child: Container(
                                width: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${p.userImage}"),
                                    ),
                                    Text(p.userName,style: TextStyle(fontSize: 10),)
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
