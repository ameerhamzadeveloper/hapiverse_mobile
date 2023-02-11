import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/components/universal_card.dart';
import '../../views/profile/share_live_location.dart';

class LocationRequestToMe extends StatefulWidget {
  @override
  _LocationRequestToMeState createState() => _LocationRequestToMeState();
}

class _LocationRequestToMeState extends State<LocationRequestToMe> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchLocationRequest(authBloc.userID!, authBloc.accesToken!, false);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Location Requests"),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Location Requests Who want to see your location"),
                  state.otherLocationRequestToMe == null ? const Center(child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CupertinoActivityIndicator(),
                  )):state.otherLocationRequestToMe!.isEmpty ? const Center(child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Text("No Location Requests"),
                  ),):ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.otherLocationRequestToMe!.length,
                    separatorBuilder: (c,i){
                      return const Divider();
                    },
                    itemBuilder: (c,i){
                      var d = state.otherLocationRequestToMe![i];
                      return ListTile(
                        title: Text(d.userName),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                        ),
                        subtitle: Text(d.locationType == '1' ? "Live Location":"Current Location"),
                        trailing:d.status == 'rejected' ?
                           Text("rejected",style: TextStyle(color: Colors.red),)
                           : SizedBox(
                          width: 130,
                          child: Row(
                            children: [
                              TextButton(onPressed: (){
                                showDialog(context: context, builder: (c){
                                  return CupertinoAlertDialog(
                                    title: Text("Do you want to reject location request?"),
                                    actions: [
                                      CupertinoDialogAction(child: Text("No"),onPressed: ()=> Navigator.pop(context),),
                                      CupertinoDialogAction(child: Text("Yes",style: TextStyle(color: Colors.red),),onPressed: (){
                                        authBloc.pushNotification(authBloc.userID!, authBloc.accesToken!, d.requesterId, '8', "", "rejected your location share request",'');
                                        bloc.rejectLocationRequest(authBloc.userID!, authBloc.accesToken!, d.requestId);
                                        Navigator.pop(context);
                                      },),
                                    ],
                                  );
                                });
                              }, child: Text("Reject",style: TextStyle(color: Colors.red),)),
                              TextButton(onPressed: (){
                                nextScreen(context, ShareLiveLocation(requestId: d.requestId,));
                              }, child: Text("Share")),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
