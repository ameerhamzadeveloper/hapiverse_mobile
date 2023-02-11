import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart'  as http;
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
class ShareLiveLocation extends StatefulWidget {
  final String requestId;

  const ShareLiveLocation({Key? key,required this.requestId}) : super(key: key);
  @override
  _ShareLiveLocationState createState() => _ShareLiveLocationState();
}

class _ShareLiveLocationState extends State<ShareLiveLocation> {
  static double lat = 34.00;
  static double long = 34.00;
  Completer<GoogleMapController> completer = Completer();

  canSendLiveLocation()async{
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationAlways
    ].request();
    print("handler${statuses[Permission.location]}");
   var locationPermission =  await Permission.location.status;
   var locationPermissionAlways = await Permission.locationAlways.status;
   print("Location Persmi $locationPermission");
   print("Location Persmi Always ${locationPermissionAlways.isDenied}");
   print("Location Persmi Always ${locationPermissionAlways.isGranted}");
   print("Location Persmi Always ${locationPermissionAlways.isRestricted}");
   print("Location Persmi Always ${locationPermissionAlways.isPermanentlyDenied}");
   if(locationPermissionAlways.isDenied){
     await Geolocator.requestPermission();
   }
  }

  LatLng initPosition = LatLng(lat, long);

  onMapCreated(GoogleMapController controller) {
    _controller = controller;
    completer.complete(_controller);
  }

  onCameraMove(CameraPosition position) {
    initPosition = position.target;
  }


  GoogleMapController? _controller;

  void animateCamera(LatLng position) async {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 13.0,
    )));
  }
  @override
  void initState() {
    super.initState();
    canSendLiveLocation();
    Future.delayed(Duration(seconds: 0),()async{
     await Geolocator.requestPermission();
     await Geolocator.getCurrentPosition().then((value){
       print(value);
        setState(() {
          lat = value.latitude;
          long = value.longitude;
        });
        animateCamera(LatLng(value.latitude, value.longitude));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.white,
        leading: TextButton(
          child: Text("Cancel",style: TextStyle(color: Colors.blue,fontSize: 17),),
          onPressed: ()=> Navigator.pop(context),
        ),
        title: Text("Share Location",style: TextStyle(color: Colors.black.withOpacity(0.8)),),
        actions: [
          IconButton(onPressed: ()async{
            await Geolocator.requestPermission();
            await Geolocator.getCurrentPosition().then((value){
              setState(() {
                lat = value.latitude;
                long = value.longitude;
              });
              animateCamera(LatLng(value.latitude, value.longitude));
            });
          }, icon: Icon(LineIcons.locationArrow,color: Colors.black,))
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: initPosition, zoom: 13.0),
            onMapCreated: onMapCreated,
            myLocationEnabled: true,
            mapType: MapType.normal,
          ),
          DraggableScrollableSheet(
            minChildSize: 0.1,
            initialChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (context, scrollController) => Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Material(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                elevation: 3,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: 6,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        showDialog(context: context, builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("Sharing Live Location"),
                            content: Text("Person can see your Live location who you gave permission"),
                            actions: [
                              CupertinoDialogAction(child: Text("Share Location"),onPressed: (){
                                bloc.acceptLocationRequest(authBloc.userID!, authBloc.accesToken!, lat, long,widget.requestId,context);
                                Navigator.pop(context);
                              },),
                              CupertinoDialogAction(child: Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                            ],
                          );
                        });
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(LineIcons.bullseye),
                      ),
                      title: Text("Share Live Location",style: TextStyle(color: Colors.blue),),
                    ),
                    Divider(
                      height: 10,
                    ),
                    ListTile(
                      onTap: (){
                        showDialog(context: context, builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("Sharing Current Location"),
                            content: Text("Person can see your current location who you gave permission"),
                            actions: [
                              CupertinoDialogAction(child: Text("Share Location"),onPressed: (){
                                bloc.acceptLocationRequest(authBloc.userID!, authBloc.accesToken!, lat, long,widget.requestId,context);
                                Navigator.pop(context);
                              },),
                              CupertinoDialogAction(child: Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                            ],
                          );
                        });
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(LineIcons.mapMarker),
                      ),
                      title: Text("Share Current Location",style: TextStyle(color: Colors.blue),),
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
