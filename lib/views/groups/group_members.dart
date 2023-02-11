import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/profile/my_profile.dart';
import '../../logic/groups/groups_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/utils.dart';
import '../../views/components/universal_card.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/constants.dart';
import '../feeds/other_profile/other_profile_page.dart';
class GroupMembers extends StatefulWidget {
  final String id;
  final int index;
  const GroupMembers({Key? key,required this.id,required this.index}) : super(key: key);

  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<RegisterCubit>();
    final grupBloc = context.read<GroupsCubit>();
    grupBloc.fetchAllGroupMembers(bloc.userID!, bloc.accesToken!, widget.id);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return BlocBuilder<GroupsCubit, GroupsState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            state.groupMembers == null ? Center(child: CupertinoActivityIndicator(),):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${state.groupMembers!.length} Participants",style: TextStyle(fontSize: 22),),
          SizedBox(height: 20,),
          ListView.separated(
            separatorBuilder: (c,i){
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Divider(),
              );
            },
            shrinkWrap: true,
          itemCount: state.groupMembers!.length,
          itemBuilder: (context,i){
            var d = state.groupMembers![i];
            if(d.groupMemberId == null || d.userName == null){
              return Container();
            }else{
              return ListTile(
                  onTap: (){
                    if(d.groupMemberId == bloc.userID!){
                      nextScreen(context, MyProfile());
                    }else{
                      profileBloc.fetchOtherProfile(d.groupMemberId!, bloc.accesToken!,bloc.userID!);
                      profileBloc.fetchOtherAllPost(d.groupMemberId!, bloc.accesToken!,bloc.userID!);
                      profileBloc.getOtherFriends(bloc.userID!, bloc.accesToken!,d.groupMemberId!);
                      nextScreen(context, OtherProfilePage(userId: d.groupMemberId!));
                    }

                  },
                  title: Text(d.userName ?? ""),
                  subtitle: d.memberRole == 'Member' && state.groups![widget.index].groupAdminId == bloc.userID! ? Text(d.memberRole!):null,
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl ?? ""}"),
                  ),
                  trailing: d.memberRole == 'Admin' || d.groupMemberId == bloc.userID!?Text(d.memberRole!,style: TextStyle(color: Colors.grey),):
                  d.memberRole == 'Member' && state.groups![widget.index].groupAdminId == bloc.userID! ? MaterialButton(
                    color: kSecendoryColor,
                    height: 25,
                    shape: const StadiumBorder(),
                    onPressed: (){

                    },
                    child: Text("Remove",style: TextStyle(color: Colors.white),),
                  ):Text(d.memberRole!,style: TextStyle(color: Colors.grey),)
              );
            }
          },
    ),
        ],
      )
          ],
        )
      ),
    );
  },
);
  }
}
