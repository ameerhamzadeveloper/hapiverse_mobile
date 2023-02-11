import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../logic/groups/groups_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/components/secondry_button.dart';
import '../../views/components/universal_card.dart';

class AddMembersToGroup extends StatefulWidget {
  final String groupId;
  final int index;

  const AddMembersToGroup({Key? key, required this.groupId,required this.index}) : super(key: key);

  @override
  _AddMembersToGroupState createState() => _AddMembersToGroupState();
}

class _AddMembersToGroupState extends State<AddMembersToGroup> {
  List<String> invited = [];
  bool isRequested = false;


  @override
  void initState() {
    super.initState();
    final authB = context.read<RegisterCubit>();
    final groupB = context.read<GroupsCubit>();
    groupB.getFriendForGroupInvite(authB.userID!, authB.accesToken!, widget.groupId);
  }
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final groupB = context.read<GroupsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Members"),
      ),
      body: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) {
          return UniversalCard(
            widget: state.groups![widget.index].groupAdminId == authB.userID! ? Padding(
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
                  state.getFriendForGroupInviteList == null ? Center(child: CupertinoActivityIndicator(),):
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.getFriendForGroupInviteList!.length,
                        itemBuilder: (ctx,i){
                          var d = state.getFriendForGroupInviteList![i];
                          return ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            leading: CircleAvatar(
                              foregroundColor: Colors.grey[300],
                              backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl!}"),
                            ),
                            title: Text(d.userName!),
                            trailing: d.alreadyInvited! ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kSecendoryColor),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Text("Invited"),
                            ):MaterialButton(
                              color: kSecendoryColor,
                              shape: StadiumBorder(),
                              onPressed: (){
                                groupB.inviteToGroup(i,d.userId!,authB.userID!,authB.accesToken!,widget.groupId,d.userName!);
                              },
                              child: Text("Invite",style: TextStyle(color: Colors.white),),
                            ),
                          );
                        },
                      )
                ],
              ),
            ):Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Want to add member into group",style: TextStyle(fontSize: 18),),
                   SizedBox(height: 10,),
                   Text("Adding member to group it's neccesary to get access from group admin for invitation other to Admin's group",style: TextStyle(color: Colors.grey),),
                   SizedBox(height: 30,),
                   isRequested ? Container(
                     height: 40,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         border: Border.all(color: kSecendoryColor)
                     ),
                     padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                     child: Center(
                       child: Text("Requested"),
                     ),
                   ):SecendoryButton(text: "Request Admin", onPressed: (){
                     setState(() {
                       isRequested = true;
                     });
                     Fluttertoast.showToast(msg: "Request has been sent to admin");
                   })
                 ],
               ),
            ),
          );
        },
      ),
    );
  }
}
