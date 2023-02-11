import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../views/chat/chat_group/create_chat_group.dart';
import '../../../views/components/universal_card.dart';

import '../../../logic/groups/groups_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
class AddMemberChatGroup extends StatefulWidget {
  const AddMemberChatGroup({Key? key}) : super(key: key);

  @override
  _AddMemberChatGroupState createState() => _AddMemberChatGroupState();
}

class _AddMemberChatGroupState extends State<AddMemberChatGroup> {
  @override
  void initState() {
    super.initState();
    final authB = context.read<RegisterCubit>();
    final groupB = context.read<GroupsCubit>();
    groupB.getFriendForChatGroupInvite(authB.userID!, authB.accesToken!, '44');
  }
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final groupB = context.read<GroupsCubit>();
    return BlocBuilder<GroupsCubit, GroupsState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Add Members"),
            Text("${state.addedMemberChatGroup == null ? "0":state.addedMemberChatGroup!.length}/250 Members",style: TextStyle(fontSize: 10),),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: state.addedMemberChatGroup == null ||state.addedMemberChatGroup!.isEmpty ? null: (){
              nextScreen(context, CreateChatGroup());
            },
            child: Text("Next",style: TextStyle(color: state.addedMemberChatGroup == null ||state.addedMemberChatGroup!.isEmpty ? Colors.grey:Colors.white),),
          )
        ],
      ),
      body: UniversalCard(
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                // width: getWidth(context) - 70,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                  // border: Border.all()
                ),
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  // controller: state.searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    // bloc.assignSearchText(val);
                    // bloc.searchUser(authB.userID!, authB.accesToken!);
                  },
                  // autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, size: 20,),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              state.addedMemberChatGroup == null ? Container():SingleChildScrollView(
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
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 40,
                            bottom: 40,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                              ),
                              child: InkWell(
                                onTap: (){
                                  groupB.removeMembersChatGroupAdded(index);
                                },
                                child: Center(
                                  child: Icon(Icons.clear,size: 15,color: Colors.white,),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              state.addMemberChatGroup == null ? Center(child: CupertinoActivityIndicator(),):
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.addMemberChatGroup!.length,
                itemBuilder: (ctx,i){
                  var d = state.addMemberChatGroup![i];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: CircleAvatar(
                      foregroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.userImage}"),
                    ),
                    title: Text(d.userName),
                    trailing: Checkbox(
                      value: d.isSelect,
                      onChanged: (va){
                        groupB.addMemberChatGroupList(i);
                      },
                    )
                  );
                },
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
