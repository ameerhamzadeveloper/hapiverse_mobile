import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/feeds/feeds_cubit.dart';

import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'other_profile/other_profile_page.dart';

class ImageSearchUsers extends StatefulWidget {
  const ImageSearchUsers({Key? key}) : super(key: key);

  @override
  State<ImageSearchUsers> createState() => _ImageSearchUsersState();
}

class _ImageSearchUsersState extends State<ImageSearchUsers> {
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Search result"),
          ),
          body: state.isSearching ? Center(child: CupertinoActivityIndicator(),) :state.searchedUsersList == null ? Center(child: CupertinoActivityIndicator(),):state.searchedUsersList!.isEmpty ? Center(child: Text("No Detected Face Found"),):ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx,i){
              var d = state.searchedUsersList![i];
              return ListTile(
                onTap: (){
                  profileBloc.fetchOtherProfile(d.userId!, authB.accesToken!,authB.userID!);
                  profileBloc.fetchOtherAllPost(d.userId!, authB.accesToken!,authB.userID!);
                  profileBloc.getOtherFriends(authB.userID!, authB.accesToken!,d.userId!);
                  nextScreen(context, OtherProfilePage(userId: d.userId!));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.searchedUsersList![i].profileImageUrl}"),
                ),
                title: Text(state.searchedUsersList![i].userName!),
                subtitle: Text(d.country ?? ""),
                trailing: TextButton(
                  onPressed: (){
                    context.read<ProfileCubit>().addFollow(d.userId!, authB.userID!, authB.accesToken!,context,authB.isBusinessShared! ? true:false);
                    context.read<FeedsCubit>().searchUser(authB.userID!, authB.accesToken!);
                    print(d.isFriend);
                  },
                  child: Text(d.martialStatus!),
                ),
              );
            },
            itemCount: state.searchedUsersList == null ? 0:state.searchedUsersList!.length,
          ),
        );
      },
    );
  }
}
