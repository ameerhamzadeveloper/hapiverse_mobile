import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../views/business_tools/events/view_event_images_slider.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class OtherEventDetails extends StatefulWidget {
  final int index;

  const OtherEventDetails({Key? key, required this.index}) : super(key: key);

  @override
  _OtherEventDetailsState createState() => _OtherEventDetailsState();
}

class _OtherEventDetailsState extends State<OtherEventDetails> {
  Completer<GoogleMapController> completer = Completer();
  onMapCreated(GoogleMapController controller,LatLng location) {
    _controller = controller;
    completer.complete(_controller);
    var markerIdVal = DateTime.now().toString();
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: location,
      // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),

    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  onCameraMove(CameraPosition position) {
    // initPosition = position.target;
  }

  GoogleMapController? _controller;

  void animateCamera(LatLng position) async {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 13.0,
    )));
  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  DateFormat d = DateFormat('yyyy-MM-dd');

  @override
  void initState() {

    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              CarouselSlider(items: state.otherBusinessEvent![widget.index].images!.map((e){
                return InkWell(
                  onTap: (){
                    nextScreen(context, ViewEventImages(index: widget.index));
                  },
                  child: Container(
                    height: getHeight(context) / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${Utils.baseImageUrl}${e.imageUrl}")
                        )
                    ),
                  ),
                );
              }).toList() , options: CarouselOptions(
                  autoPlay: false,enableInfiniteScroll: false,
                  viewportFraction: 1.0,height: getHeight(context) / 3)),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.otherBusinessEvent![widget.index].eventName!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(d.format(state.otherBusinessEvent![widget.index].eventDate!).toString(),style: TextStyle(fontSize: 22),),
                    SizedBox(height: 10,),
                    state.otherBusinessEvent![widget.index].address == 'Online' ?
                        Row(
                          children: [
                            Text("Online Event",style: TextStyle(fontSize: 20,color: Colors.blue),)
                          ],
                        ):
                    InkWell(
                      onTap: (){
                        MapsLauncher.launchCoordinates(double.parse(state.otherBusinessEvent![widget.index].latitude!),double.parse(state.otherBusinessEvent![widget.index].longitude!),"Event Location");
                      },
                      child: SizedBox(
                        height: getHeight(context) / 6,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          ),
                          child: GoogleMap(
                            buildingsEnabled: true,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            myLocationButtonEnabled: false,
                            tiltGesturesEnabled: false,
                            indoorViewEnabled: true,
                            scrollGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            onTap: (v){
                              MapsLauncher.launchCoordinates(double.parse(state.otherBusinessEvent![widget.index].latitude!),double.parse(state.otherBusinessEvent![widget.index].longitude!),"Event Location");
                            },
                            initialCameraPosition:
                            CameraPosition(target: LatLng(double.parse(state.otherBusinessEvent![widget.index].latitude!),double.parse(state.otherBusinessEvent![widget.index].longitude!)), zoom: 13.0),
                            onMapCreated: (cont){
                              onMapCreated(cont,LatLng(double.parse(state.otherBusinessEvent![widget.index].latitude!),double.parse(state.otherBusinessEvent![widget.index].longitude!)));
                            },
                            myLocationEnabled: true,
                            mapType: MapType.normal,
                            markers: Set<Marker>.of(markers.values),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    state.otherBusinessEvent![widget.index].address == 'Online' ? Container():Row(
                      children: [
                        Icon(LineIcons.locationArrow),
                        Text(state.otherBusinessEvent![widget.index].address!)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(state.otherBusinessEvent![widget.index].eventDescription!)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
