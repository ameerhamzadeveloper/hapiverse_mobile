import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:jiffy/jiffy.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/components/universal_card.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'my_location_request_to_others.dart';
class OtherLocationTracing extends StatefulWidget {
  const OtherLocationTracing({Key? key}) : super(key: key);

  @override
  _OtherLocationTracingState createState() => _OtherLocationTracingState();
}

class _OtherLocationTracingState extends State<OtherLocationTracing> {

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchMyLocationSharing(authBloc.userID!, authBloc.accesToken!,false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Tracking"),
        actions: [
          TextButton(onPressed: (){
            nextScreen(context, MyLocationRequestToOthers());
          }, child: Text("Requests",style: TextStyle(color: kSecendoryColor),))
        ],
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Text("Other Users who have allowed you to track their locations"),
            SizedBox(height: 20,),
            state.locationshareToMe == null ? Center(child: CircularProgressIndicator(),) : state.locationshareToMe!.isEmpty ? Center(child: Text("No Location Tracing"),):
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.locationshareToMe!.length,
              itemBuilder: (ctx,i){
                var data = state.locationshareToMe![i];
                return  ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${Utils.baseImageUrl}${data.profileImageUrl}"),
                  ),
                  title: Text(data.userName ?? ""),
                  subtitle: Text(Jiffy(data.addDate!, "MM dd, yyyy at hh:mm a").fromNow().toString()),
                  trailing: TextButton(
                    onPressed: (){
                      MapsLauncher.launchCoordinates(24.8607, 67.0011,);
                    },
                    child: Text("Track"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
