import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/utils/constants.dart';
class PickBusinessMapLocation extends StatefulWidget {
  const PickBusinessMapLocation({Key? key}) : super(key: key);

  @override
  State<PickBusinessMapLocation> createState() => _PickBusinessMapLocationState();
}

class _PickBusinessMapLocationState extends State<PickBusinessMapLocation> {
  bool setMyLocation = false;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Container(
      child: SafeArea(
        child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("Cancel")),
                  TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("Save")),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Divider(color: Colors.black,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(state.businessAddress == null ? state.businessProfile!.address! : state.businessAddress!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Set My Location"),
                    Switch(value: setMyLocation, onChanged: (v){
                      setState(() {
                        setMyLocation = v;
                      });
                      Geolocator.getCurrentPosition().then((value){
                        bloc.setBusinessMarker(false,marker: Marker(
                          markerId: MarkerId(DateTime.now().toString()),
                          position: LatLng(value.latitude,value.longitude)
                        ));
                      });
                    },
                    )
                  ],
                ),
              ),
              Container(
                height: getHeight(context) / 1.5,
                child: GoogleMap(
                  zoomControlsEnabled: true,
                  initialCameraPosition:
                  CameraPosition(target: state.initPosition, zoom: 13.0),
                  onMapCreated: bloc.onMapCreated,
                  tiltGesturesEnabled: true,
                  onCameraMove: (pos) async {
                  },
                  onTap: (lat) {
                    print("Camerea moving ${lat.longitude}");
                  },
                  mapType: MapType.normal,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: state.businessLocationMArker!,
                ),
              ),
            ],
          ),
        ),
    )
    )
    );
  },
);
  }
}
