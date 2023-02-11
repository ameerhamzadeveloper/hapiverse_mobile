import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/feeds/feeds_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';

import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import '../other_profile/other_profile_page.dart';
class FriendSuggestionWidget extends StatelessWidget {
  final int index;
  const FriendSuggestionWidget({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return SizedBox(
      height:  330,
      width: getWidth(context) / 1.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                profileBloc.fetchOtherProfile(state.sugeestedFriends![index].userId, authBloc.accesToken!,authBloc.userID!);
                profileBloc.fetchOtherAllPost(state.sugeestedFriends![index].userId, authBloc.accesToken!,authBloc.userID!);
                profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,state.sugeestedFriends![index].userId);
                nextScreen(context, OtherProfilePage(userId: state.sugeestedFriends![index].userId));
              },
              child: Container(
                height: 210,
                width: getWidth(context)/1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("${Utils.baseImageUrl}${state.sugeestedFriends![index].profileImageUrl}")
                    ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(state.sugeestedFriends![index].userName,style: const TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            state.sugeestedFriends![index].isFollowed ? Container(
              width: double.infinity,
              height: 40,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: kSecendoryColor),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: MaterialButton(
                onPressed: (){
                  profileBloc.fetchOtherProfile(state.sugeestedFriends![index].userId, authBloc.accesToken!,authBloc.userID!);
                  profileBloc.fetchOtherAllPost(state.sugeestedFriends![index].userId, authBloc.accesToken!,authBloc.userID!);
                  profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,state.sugeestedFriends![index].userId);
                  nextScreen(context, OtherProfilePage(userId: state.sugeestedFriends![index].userId));
                },
                child: const Text("See Profile",style: TextStyle(color: kSecendoryColor),),
              ),
            ):Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    height: 30,
                    color:kSecendoryColor,
                    shape:const StadiumBorder(),
                    onPressed: (){
                      profileBloc.addFollow(state.sugeestedFriends![index].userId,authBloc.userID!, authBloc.accesToken!,context,authBloc.isBusinessShared! ? true: false);
                      bloc.followUnfollowFriendSuggestion(index);
                    },
                    child: const Text("Follow",style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: kSecendoryColor),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        bloc.removeFriendSuggestion(index);
                      },
                      child: const Text("Remove",style: TextStyle(color: kSecendoryColor),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  },
);
  }
}
