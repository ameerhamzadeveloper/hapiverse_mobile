import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/feeds/see_single_image_post.dart';
import 'package:jiffy/jiffy.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../views/components/secondry_button.dart';
import '../../views/profile/location_request_to_me.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'other_profile/other_profile_page.dart';
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  void initState() {
    super.initState();
    fetchNotification();

  }

  Future<void> fetchNotification()async{
    final bloc = context.read<RegisterCubit>();
    bloc.fetchNotificationList(bloc.userID!, bloc.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(getTranslated(context, 'NOTIFICATION')!,style: TextStyle(color: Colors.black),),
      ),
      body: state.notificationList == null ? RefreshIndicator( onRefresh: ()async{
        return fetchNotification();
      },child: Center(child: CupertinoActivityIndicator(),)) : RefreshIndicator(
        onRefresh: ()async{
          return fetchNotification();
        },
        child: ListView.builder(
          itemCount: state.notificationList!.length,
          itemBuilder: (ctx,i){
            var noti = state.notificationList![i];
            // like post widget
            if(noti.notificationTypeId == '2'){
              return Container(
                        color: noti.haveSeen == '0' ? Colors.blue.withOpacity(0.1) :Colors.transparent,
                        child: ListTile(
                          onTap: (){
                            authBloc.addViewNotification(authBloc.userID!, authBloc.accesToken!, noti.notificationId!);
                            // nextScreen(context, SeeSingleImagePost());
                          },
                          // selectedColor: Colors.blue.withOpacity(0.3),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${Utils.baseImageUrl}${noti.profileImageUrl}"),
                          ),
                          title: Text("${noti.userName} ${noti.subject!}",style: TextStyle(fontSize: 13),),
                          trailing: Text(Jiffy(noti.addDate, "MM dd, yyyy at hh:mm a").fromNow().toString(),style: TextStyle(fontSize: 10),),
                        ),
                      );
            }else if(noti.notificationTypeId == '7'){
              // location request part
              return Container(
                color: noti.haveSeen == '0' ? Colors.blue.withOpacity(0.1) :Colors.transparent,
                child: ListTile(
                  onTap: (){
                    authBloc.addViewNotification(authBloc.userID!, authBloc.accesToken!, noti.notificationId!);
                    nextScreen(context, LocationRequestToMe());
                  },
                  // selectedColor: Colors.blue.withOpacity(0.3),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${Utils.baseImageUrl}${noti.profileImageUrl}"),
                  ),
                  title: Text("${noti.userName} ${noti.body!}",style: TextStyle(fontSize: 13),),
                  trailing: Text("5h ago",style: TextStyle(fontSize: 10),),
                ),
              );
            }else{
              // follow widget
              return Container(
                        color: noti.haveSeen == '0' ? Colors.blue.withOpacity(0.1) :Colors.transparent,
                        child: ListTile(
                          onTap: (){
                            authBloc.addViewNotification(authBloc.userID!, authBloc.accesToken!, noti.notificationId!);
                            profileBloc.fetchOtherProfile(noti.senderId!, authBloc.accesToken!,authBloc.userID!);
                            profileBloc.fetchOtherAllPost(noti.senderId!, authBloc.accesToken!,authBloc.userID!);
                            profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,noti.senderId!);
                            nextScreen(context, OtherProfilePage(userId: noti.senderId!));
                          },
                          // selectedColor: Colors.blue.withOpacity(0.3),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${Utils.baseImageUrl}${noti.profileImageUrl}"),
                          ),
                          title: Text("${noti.userName} ${noti.body!}",style: TextStyle(fontSize: 13),),
                          subtitle: Text("${noti.addDate}",style: TextStyle(fontSize: 10),),
                          trailing: SizedBox(
                            width: 100,
                            height: 30,
                            child: MaterialButton(
                              shape: const StadiumBorder(),
                              color:kSecendoryColor,
                              onPressed: (){
                                authBloc.addViewNotification(authBloc.userID!, authBloc.accesToken!, noti.notificationId!);
                                profileBloc.fetchOtherProfile(noti.senderId!, authBloc.accesToken!,authBloc.userID!);
                                profileBloc.fetchOtherAllPost(noti.senderId!, authBloc.accesToken!,authBloc.userID!);
                                profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,noti.senderId!);
                                nextScreen(context, OtherProfilePage(userId: noti.senderId!));
                              },
                              child: Text("Follow Back",style: TextStyle(fontSize: 10,color: Colors.white),),
                            ),
                          ),
                        ),
                      );
            }
          },
        ),
      )
      // Column(
      //   children: [
      //     Container(
      //       color: Colors.blue.withOpacity(0.1),
      //       child: ListTile(
      //         // selectedColor: Colors.blue.withOpacity(0.3),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
      //         ),
      //         title: Text("Ameer Started Following",style: TextStyle(fontSize: 13),),
      //         subtitle: Text("5h",style: TextStyle(fontSize: 10),),
      //         trailing: SizedBox(
      //           width: 100,
      //           height: 30,
      //           child: MaterialButton(
      //             shape: StadiumBorder(),
      //             color:kSecendoryColor,
      //             onPressed: (){},
      //             child: Text("Follow Back",style: TextStyle(fontSize: 10,color: Colors.white),),
      //           )
      //         ),
      //       ),
      //     ),
      //     Container(
      //       // color: Colors.blue.withOpacity(0.1),
      //       child: ListTile(
      //         // selectedColor: Colors.blue.withOpacity(0.3),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
      //         ),
      //         title: Text("Ameer liked your post",style: TextStyle(fontSize: 13),),
      //         trailing: Text("5h ago",style: TextStyle(fontSize: 10),),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.blue.withOpacity(0.1),
      //       child: ListTile(
      //         // selectedColor: Colors.blue.withOpacity(0.3),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
      //         ),
      //         title: Text("Ameer commented on your post",style: TextStyle(fontSize: 13),),
      //         trailing: Text("5h ago",style: TextStyle(fontSize: 10),),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.blue.withOpacity(0.1),
      //       child: ListTile(
      //         // selectedColor: Colors.blue.withOpacity(0.3),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
      //         ),
      //         title: Text("Ameer Follow Back you",style: TextStyle(fontSize: 13),),
      //         subtitle: Text("5h",style: TextStyle(fontSize: 10),),
      //         trailing: SizedBox(
      //             width: 100,
      //             height: 30,
      //             child: MaterialButton(
      //               shape: StadiumBorder(),
      //               color:kSecendoryColor,
      //               onPressed: (){},
      //               child: Text("See profile",style: TextStyle(fontSize: 10,color: Colors.white),),
      //             )
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  },
);
  }
}
