import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:jiffy/jiffy.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/components/universal_card.dart';
import '../../views/profile/location_request_to_me.dart';
import 'package:line_icons/line_icons.dart';
class SharingLocation extends StatefulWidget {
  const SharingLocation({Key? key}) : super(key: key);

  @override
  _SharingLocationState createState() => _SharingLocationState();
}

class _SharingLocationState extends State<SharingLocation> {

  String address = '';
  double lat = 0;
  double long = 0;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchMyLocationSharing(authBloc.userID!, authBloc.accesToken!,true);
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high).then((value) async{
      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.latitude);
      address = "${placemarks[0].street},${placemarks[0].locality} ${placemarks[0].administrativeArea} ${placemarks[0].country}";
      lat = value.latitude;
      long = value.longitude;
      print("${placemarks[0].street},${placemarks[0].locality} ${placemarks[0].administrativeArea} ${placemarks[0].country}");
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Sharing"),
        actions: [
          TextButton(onPressed: (){
            nextScreen(context, LocationRequestToMe());
          }, child: Text("Requests",style: TextStyle(color: kSecendoryColor),))
        ],
      ),
      body: UniversalCard(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const[
                 Text("Allow Location Sharing",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Icon(LineIcons.locationArrow)
              ],
            ),
            const SizedBox(height: 10,),
            const Text("Allow your personal location with others so others can see your location and can track your location and can visit your location"),
            const SizedBox(height: 20,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text("Turn On/Off Location Sharing",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            //     Platform.isAndroid ?
            //     Switch(value: true, onChanged: (v){}):
            //     CupertinoSwitch(value: false, onChanged: (v){})
            //   ],
            // ),
            Text("Your Location",style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 10,),
            Text(address),
            const SizedBox(height: 5,),
            Row(
              children: [
                Text("Latitude  "),
                Text(lat.toString()),
              ],
            ),
            Row(
              children: [
                Text("Longitude  "),
                Text(long.toString()),
              ],
            ),
            Divider(),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Who are tracking your locations",style: TextStyle(fontSize: 16,color: Colors.grey),),
                TextButton(
                  onPressed: (){
                    showCupertinoDialog(context: context, builder: (ctxm){
                      return CupertinoAlertDialog(
                        title: Text("Remove All"),
                        content: Text("Do you want to remove all friends to see your locations?"),
                        actions: [
                          CupertinoDialogAction(
                            child: Text("Yes",style: TextStyle(color: Colors.red),),
                            onPressed: (){
                              bloc.deleteLocationSharingAll(authBloc.userID!, authBloc.token,);
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text("No"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
                  },
                  child: Text("Remove All",style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            state.locationshareToOthers == null ? Center(child: CircularProgressIndicator(),) : state.locationshareToOthers!.isEmpty ? Center(child: Text("You are not sharing your location with anyone"),):
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.locationshareToOthers!.length,
              itemBuilder: (ctx,i){
                var data = state.locationshareToOthers![i];
                return  ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${Utils.baseImageUrl}${data.profileImageUrl}"),
                  ),
                  title: Text(data.userName ?? ""),
                  subtitle: Text(Jiffy(data.addDate!, "MM dd, yyyy at hh:mm a").fromNow().toString()),
                  trailing: TextButton(
                    onPressed: (){
                      showCupertinoDialog(context: context, builder: (ctxm){
                        return CupertinoAlertDialog(
                          title: Text(data.userName ?? ""),
                          content: Text("Do you want to remove ${data.userName ?? ""} to see your locations?"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Yes",style: TextStyle(color: Colors.red),),
                              onPressed: (){
                                bloc.deleteLocationSharingSingle(authBloc.userID!, authBloc.token, data.trackLocationId!);
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("No"),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                    },
                    child: Text("Remove",style: TextStyle(color: Colors.red),),
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
