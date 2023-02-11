import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';

class SeeFollowers extends StatefulWidget {
  final int index;
  final bool isMyProfile;
  final String userName;
  const SeeFollowers({Key? key,required this.index,required this.isMyProfile,required this.userName}) : super(key: key);

  @override
  State<SeeFollowers> createState() => _SeeFollowersState();
}

class _SeeFollowersState extends State<SeeFollowers> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    var d;
    if(state.otherProfileInfoResponse != null){
      var json = jsonDecode(state.otherProfileInfoResponse!.body);
      d = json['data'];
    }
    return DefaultTabController(
      initialIndex: widget.index,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userName),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Followers (${widget.isMyProfile ? state.followers : d['follower']})",
              ),
              Tab(
                text: "Following (${widget.isMyProfile ? state.following : d['following']})",
              ),
              Tab(
                text: "Friends (${widget.isMyProfile ? state.followers : d['follower']})",
              ),
            ],
          ),
        ),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  },
);
  }
}
