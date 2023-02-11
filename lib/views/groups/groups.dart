import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/groups/groups_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/groups/components/groups_widget.dart';
import '../../views/groups/view_group.dart';
import 'package:line_icons/line_icons.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<RegisterCubit>();
    final gBloc = context.read<GroupsCubit>();
    return BlocBuilder<GroupsCubit, GroupsState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'GROUPS')!),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, createGroups),
                icon: const Icon(
                  LineIcons.plusCircle,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, groupSearch),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            // give the indicator a decoration (color and border radius)
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                              color: kUniversalColor,
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            onTap: (i) {
                              setState(() {
                                _tabController.index = i;
                              });
                            },
                            tabs: [
                              // first tab [you can add an icon using the icon property]
                              Tab(
                                text: getTranslated(context, 'MY_GROUPS')!,
                              ),

                              // second tab [you can add an icon using the icon property]
                              Tab(
                                text: getTranslated(context, 'INVITES')!,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _tabController.index == 1
                            ? Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(context,
                                          'INVITE_FRIENDS_TO YOUR GROUPS')!,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    state.groupInvites == null
                                        ? Center(
                                            child: CupertinoActivityIndicator(),
                                          )
                                        : state.groupInvites!.isEmpty
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                          "No Group Invites"),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    state.groupInvites!.length,
                                                itemBuilder: (ctx, i) {
                                                  if (state
                                                      .groupInvites!.isEmpty) {
                                                    return Center(
                                                      child: Text(
                                                          "No Group Invites"),
                                                    );
                                                  } else {
                                                    return Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage("${Utils.baseImageUrl}${state.groupInvites![i].profileImageUrl}"),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(state
                                                                    .groupInvites![
                                                                        i]
                                                                    .username),
                                                                Text(getTranslated(
                                                                    context,
                                                                    'INVITE_FRIENDS_TO YOUR GROUPS')!),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        // ListTile(
                                                        //   contentPadding: EdgeInsets.all(0),
                                                        //   leading: CircleAvatar(
                                                        //     backgroundImage: NetworkImage(state.groupInvites![i].profileImageUrl),
                                                        //   ),
                                                        //   title: Text(state.groupInvites![i].username),
                                                        //   subtitle: Text(getTranslated(context, 'INVITE_FRIENDS_TO YOUR GROUPS')!),
                                                        //   onTap: (){},
                                                        // ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            MaterialButton(
                                                              height: 30,
                                                              onPressed: () {
                                                                gBloc.joinGroup(authBloc
                                                                    .userID!,
                                                                    authBloc
                                                                        .accesToken!, state
                                                                        .groupInvites![
                                                                    i]
                                                                        .groupId, state
                                                                        .groupInvites![
                                                                    i]
                                                                        .inviterId, context);
                                                                gBloc.fetchSingleGroupFromInvite(
                                                                    authBloc
                                                                        .userID!,
                                                                    authBloc
                                                                        .accesToken!,
                                                                    state
                                                                        .groupInvites![
                                                                    i]
                                                                        .groupId,
                                                                    context,
                                                                    state
                                                                        .groupInvites![
                                                                    i]
                                                                        .username,
                                                                    state
                                                                        .groupInvites![
                                                                    i]
                                                                        .profileImageUrl,
                                                                    state
                                                                        .groupInvites![
                                                                    i]
                                                                        .inviterId,i);
                                                              },
                                                              shape:
                                                                  StadiumBorder(),
                                                              color:
                                                                  kSecendoryColor,
                                                              child: Text(
                                                                getTranslated(
                                                                    context,
                                                                    'JOIN')!,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                print(state
                                                                    .groupInvites![
                                                                        i]
                                                                    .groupId);
                                                                gBloc.fetchSingleGroupFromInvite(
                                                                    authBloc
                                                                        .userID!,
                                                                    authBloc
                                                                        .accesToken!,
                                                                    state
                                                                        .groupInvites![
                                                                            i]
                                                                        .groupId,
                                                                    context,
                                                                    state
                                                                        .groupInvites![
                                                                            i]
                                                                        .username,
                                                                    state
                                                                        .groupInvites![
                                                                            i]
                                                                        .profileImageUrl,
                                                                    state
                                                                        .groupInvites![
                                                                            i]
                                                                        .inviterId,i);
                                                              },
                                                              child: Text(
                                                                getTranslated(
                                                                    context,
                                                                    'VIEW_GROUP')!,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider()
                                                      ],
                                                    );
                                                  }
                                                },
                                              )
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  if (_tabController.index == 1) {
                                    context.read<GroupsCubit>().getGroups(
                                        authBloc.userID!, authBloc.accesToken!);
                                  }
                                },
                                child: Container(
                                  child: state.isGroupLoading
                                      ? Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : state.groups!.isEmpty
                                          ? Center(
                                              child: Text(getTranslated(
                                                  context, 'NO_GROUP')!),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state.groups!.length,
                                              itemBuilder: (ctx, i) {
                                                return InkWell(
                                                  onTap: () {
                                                    // Navigator.pushNamed(context, viewGroups);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ViewGroups(
                                                                      index: i,
                                                                    )));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: GroupsWidget(
                                                      groupCover:
                                                          "${Utils.baseImageUrl}${state.groups![i].groupImageUrl}",
                                                      groupName: state
                                                          .groups![i].groupName,
                                                      membersCount: "0",
                                                      privacy: state.groups![i]
                                                          .groupPrivacy,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
