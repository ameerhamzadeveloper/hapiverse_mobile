import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/groups/groups_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/components/universal_card.dart';
import '../../views/groups/add_members.dart';
import '../../views/groups/group_members.dart';
import 'package:line_icons/line_icons.dart';
class GroupSettings extends StatefulWidget {
  final String id;
  final String groupName;
  final int index;
  const GroupSettings({Key? key,required this.id,required this.groupName,required this.index}) : super(key: key);

  @override
  _GroupSettingsState createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroupsCubit>();
    final authB = context.read<RegisterCubit>();

    showDialogeee(){
      showDialog(context: context, builder: (ctx){
        return CupertinoAlertDialog(
          content: CupertinoActivityIndicator(),
        );
      });
    }
    return BlocBuilder<GroupsCubit, GroupsState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            ListTile(
              onTap: ()=> nextScreen(context, AddMembersToGroup(groupId: widget.id,index: widget.index,)),
              title: Text("Invite Members",style: TextStyle(fontWeight: FontWeight.bold),),
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                  child: Icon(Icons.add)),
              subtitle: Text("Add invites new members to group"),
            ),
            ListTile(
              onTap: ()=> nextScreen(context, GroupMembers(id: widget.id,index: widget.index,)),
              title: Text("Group Members",style: TextStyle(fontWeight: FontWeight.bold),),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(LineIcons.users)),
              subtitle: Text("See all group members"),
            ),
            state.groups![widget.index].groupAdminId == authB.userID! ?
            ListTile(
              onTap: (){
                print(state.groups![widget.index].groupAdminId);
                print(authB.userID!);
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Column(
                          children: <Widget>[
                            Text("Delete Group",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        content: Text("Do you want to Delete ${widget.groupName}? your group will no longer available for anyone"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text(getTranslated(context, 'YES')!),
                            onPressed: () async{
                              bloc.leaveGroup(authB.userID!, authB.accesToken!, widget.id,context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              // showDialogeee();
                            },),
                          CupertinoDialogAction(
                            child: Text(getTranslated(context, 'NO')!),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },),
                        ],
                      );
                    }
                );
              },
              title: const Text("Delete Group",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(LineIcons.trash,color: Colors.red,)),
              subtitle: Text("Delete your group, your group will no longer available"),
            ):
            ListTile(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Column(
                          children: <Widget>[
                            Text("Leave Group"),
                          ],
                        ),
                        content: Text("Do you want to leave ${widget.groupName}?"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text(getTranslated(context, 'YES')!),
                            onPressed: () async{
                              bloc.leaveGroup(authB.userID!, authB.accesToken!, widget.id,context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              // showDialogeee();
                            },),
                          CupertinoDialogAction(
                            child: Text(getTranslated(context, 'NO')!),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },),
                        ],
                      );
                    }
                );
              },
              title: Text("Leave Group",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.exit_to_app,color: Colors.red)),
              subtitle: Text("Exit to group"),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
