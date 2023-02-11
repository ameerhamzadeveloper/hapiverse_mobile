import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/profile/my_profile.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/utils.dart';
import '../../views/profile/components/view_all_friend.dart';
import '../../utils/constants.dart';
import '../feeds/other_profile/other_profile_page.dart';
class ProfileFriendsList extends StatelessWidget {
  final bool isMYProfile;
  const ProfileFriendsList({Key? key,required this.isMYProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text("${getTranslated(context, 'FRIENDS')!} (${isMYProfile ? state.myFriendsList == null ? "0":state.myFriendsList!.length : state.otherFriendsList == null ? "":state.otherFriendsList!.length})",style: TextStyle(color: kUniversalColor),),
            InkWell(
                onTap: (){
                  nextScreen(context, ViewAllFriendPage(isMyProfile: isMYProfile ? true: false));
                },
                child: Text("${getTranslated(context, 'VIEW_ALL')!}",style: TextStyle(color: kUniversalColor),)),
          ],
        ),
        SizedBox(height: 10,),
        isMYProfile ? SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: state.myFriendsList == null ? Center(child: CupertinoActivityIndicator(),):
          state.myFriendsList!.isEmpty ? Center(child: Text("No Friends Found"),):Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(state.myFriendsList!.length, (index) => InkWell(
              onTap: (){
                profileBloc.fetchOtherProfile(state.myFriendsList![index].userId, authB.accesToken!,authB.userID!);
                profileBloc.fetchOtherAllPost(state.myFriendsList![index].userId, authB.accesToken!,authB.userID!);
                profileBloc.getOtherFriends(authB.userID!,authB.accesToken!,state.myFriendsList![index].userId, );
                nextScreen(context, OtherProfilePage(userId: state.myFriendsList![index].userId));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.myFriendsList![index].profileImageUrl}"),
                    ),
                    SizedBox(height: 5,),
                    Text(state.myFriendsList![index].userName.length > 7 ? "${state.myFriendsList![index].userName.substring(0,7)}..":state.myFriendsList![index].userName)
                  ],
                ),
              ),
            )),
          ),
        ):
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: state.otherFriendsList == null ? Center(child: CupertinoActivityIndicator(),):
          state.otherFriendsList!.isEmpty ? Center(child: Text("No Friends"),):Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(state.otherFriendsList!.length, (index) => InkWell(
              onTap: (){
                if(state.otherFriendsList![index].userId == authB.userID!){
                  nextScreen(context, MyProfile());
                }else{
                  profileBloc.fetchOtherProfile(state.otherFriendsList![index].userId, authB.accesToken!,authB.userID!);
                  profileBloc.fetchOtherAllPost(state.otherFriendsList![index].userId, authB.accesToken!,authB.userID!);
                  profileBloc.getOtherFriends(authB.userID!,authB.accesToken!,state.myFriendsList![index].userId, );
                  nextScreen(context, OtherProfilePage(userId: state.otherFriendsList![index].userId));
                }

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius:25,
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.otherFriendsList![index].profileImageUrl}"),
                    ),
                    SizedBox(height: 5,),
                    Text(state.otherFriendsList![index].userName.length > 7 ? "${state.otherFriendsList![index].userName.substring(0,7)}..":state.otherFriendsList![index].userName)
                  ],
                ),
              ),
            )),
          ),
        ),
      ],
    );
  },
);
  }
}
