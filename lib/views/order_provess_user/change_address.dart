import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/profile/profile_cubit.dart';
class ChangeOrderLocation extends StatefulWidget {
  const ChangeOrderLocation({Key? key}) : super(key: key);

  @override
  State<ChangeOrderLocation> createState() => _ChangeOrderLocationState();
}

class _ChangeOrderLocationState extends State<ChangeOrderLocation> {
  double lat = 000;
  double long = 000;

  Completer<GoogleMapController> completer = Completer();
  onMapCreated(GoogleMapController controller) {
    _controller = controller;
    completer.complete(_controller);
    animateCamera(LatLng(lat, long));
  }

  onCameraMove(CameraPosition position) {
    // initPosition = position.target;
  }

  GoogleMapController? _controller;

  String flat = '';
  String streat = '';
  // String city = '';

  void animateCamera(LatLng position) async {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 13.0,
    )));
  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition().then((position){
      // animateCamera(LatLng(position.latitude, position.longitude));
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
      bloc.setOrderLatLong(LatLng(position.latitude,position.longitude));
    });
  }
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileCubit>(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            buildingsEnabled: true,
            indoorViewEnabled: true,
            initialCameraPosition:
            CameraPosition(target: LatLng(lat,long), zoom: 13.0),
            onMapCreated: onMapCreated,
            // myLocationEnabled: true,
            mapType: MapType.normal,
            markers: Set<Marker>.of(markers.values),
            onCameraMove: (pos) async {
              print(
                  "Camerea moving ${pos.target.latitude} ${pos.target.longitude}");
              BlocProvider.of<ProfileCubit>(context).setIsMapMoving(true);
              await BlocProvider.of<ProfileCubit>(context).setOrderLatLong(LatLng(pos.target.latitude, pos.target.longitude));
            },
            onCameraIdle: () {
              print("Ideleee");
              BlocProvider.of<ProfileCubit>(context).setIsMapMoving(false);
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              // height: 130,
              // width: getWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(state.orderAddress!)),
                          IconButton(onPressed: (){
                            showModalBottomSheet(
                               enableDrag: true,
                                context: context, builder: (c){
                              return Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "house,flat,villa",
                                        label: Text("house,flat,villa"),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        disabledBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                      ),
                                      onChanged: (v){
                                        flat = v;
                                      },
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                                      onChanged: (v){
                                        streat = v;
                                      },
                                      controller: TextEditingController(text: state.orderStreet),
                                      decoration: InputDecoration(
                                        hintText: "streat",
                                        label: Text("streat"),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        disabledBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                                      controller: TextEditingController(text: state.orderCity),
                                      decoration: InputDecoration(
                                        hintText: "city",
                                        label: Text("city"),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        disabledBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(

                                      decoration: InputDecoration(
                                        hintText: "province",
                                        label: Text("province"),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        disabledBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder:  const OutlineInputBorder(
                                          borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                      ),
                                      controller: TextEditingController(text: state.orderProvince),
                                    ),
                                    SizedBox(height: 30,),
                                    SecendoryButton(text: "Save", onPressed: (){
                                      bloc.setAddress("$flat $streat, ${state.orderCity} ${state.orderProvince}");
                                      Navigator.pop(context);
                                    })
                                  ],
                                ),
                              );
                            });
                          }, icon: Icon(Icons.edit))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          state.isMapMoving
              ? const Align(
            alignment: Alignment.center,
            child: Icon(LineIcons.mapPin,
                size: 52.0, color: kUniversalColor),
          )
              : const Align(
            alignment: Alignment.center,
            child: Icon(LineIcons.mapMarker,
                size: 52.0, color: kUniversalColor),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SecendoryButton(text: "Done", onPressed: (){Navigator.pop(context);}),
      ),
    );
  },
);
  }
}
