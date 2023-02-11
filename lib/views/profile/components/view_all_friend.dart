import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../views/components/universal_card.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../feeds/other_profile/other_profile_page.dart';
class ViewAllFriendPage extends StatefulWidget {
  final bool isMyProfile;
  const ViewAllFriendPage({Key? key,required this.isMyProfile}) : super(key: key);

  @override
  _ViewAllFriendPageState createState() => _ViewAllFriendPageState();
}

class _ViewAllFriendPageState extends State<ViewAllFriendPage> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text("All Friends (${widget.isMyProfile ? state.myFriendsList!.length: state.otherFriendsList!.length})",style: TextStyle(color: Colors.black),),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
          widget.isMyProfile ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 6 / 8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: state.myFriendsList!.length,
            itemBuilder: (ctx,i){
              return InkWell(
                onTap: (){
                  profileBloc.fetchOtherProfile(state.myFriendsList![i].userId, authBloc.accesToken!,authBloc.userID!);
                  profileBloc.fetchOtherAllPost(state.myFriendsList![i].userId, authBloc.accesToken!,authBloc.userID!);
                  profileBloc.getOtherFriends(authBloc.userID!,authBloc.accesToken!,state.myFriendsList![i].userId, );
                  nextScreen(context, OtherProfilePage(userId: state.myFriendsList![i].userId));
                  },
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(15),
                    // ),
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(6)),
                      child: Column(
                        children: [
                          Image.network("${Utils.baseImageUrl}${state.myFriendsList![i].profileImageUrl}",fit: BoxFit.cover,height: 100,width: 100,),
                          Text(state.myFriendsList![i].userName)
                        ],
                      )
                  ),
                ),
              );
            },
          ):
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 6 / 8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: state.otherFriendsList!.length,
            itemBuilder: (ctx,i){
              return SizedBox(
                height: 100,
                child: InkWell(
                  onTap: (){
                    profileBloc.fetchOtherProfile(state.otherFriendsList![i].userId, authBloc.accesToken!,authBloc.userID!);
                    profileBloc.fetchOtherAllPost(state.otherFriendsList![i].userId, authBloc.accesToken!,authBloc.userID!);
                    profileBloc.getOtherFriends(authBloc.userID!,authBloc.accesToken!,state.otherFriendsList![i].userId, );
                    nextScreen(context, OtherProfilePage(userId: state.otherFriendsList![i].userId));
                    // nextScreen(context, SeeProfileImage(imageUrl: data['message'],title: data['profileImage'],));
                  },
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(6)),
                        child: Column(
                          children: [
                            Image.network("${Utils.baseImageUrl}${state.otherFriendsList![i].profileImageUrl}",fit: BoxFit.cover,height: 100,width: 100,),
                            Text(state.otherFriendsList![i].userName)
                          ],
                        )
                    ),
                  ),
                ),
              );
            },
          )
          ],
        ),
      )
    );
  },
);
  }
}
