import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/order_provess_user/change_address.dart';
class CheckOutPage extends StatefulWidget {
  final String productName;
  final String productId;
  final String productPrice;
  final String productImage;
  final String businessId;
  const CheckOutPage({Key? key,required this.productId,required this.businessId, required this.productPrice, required this.productImage,required this.productName}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

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
      var markerIdVal = DateTime.now().toString();
      final MarkerId markerId = MarkerId(markerIdVal);

      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(position.latitude,position.longitude),
        // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),

      );

      setState(() {
        // adding a new marker to map
        markers[markerId] = marker;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text("Checkout",style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Item",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w400),),
                  SizedBox(height: 20,),
                  ListTile(
                    contentPadding: EdgeInsets.only(left:0,right: 0),
                    title: Text(widget.productName),
                    leading: Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.productImage)
                        )
                      ),
                    ),
                    trailing: Text("\$${widget.productPrice}")
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.location_solid,color: kUniversalColor,),
                          Text("Shipping Address",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeOrderLocation())).then((value){
                          animateCamera(LatLng(state.orderLat!, state.orderLong!));
                          var markerIdVal = DateTime.now().toString();
                          final MarkerId markerId = MarkerId(markerIdVal);

                          // creating a new MARKER
                          final Marker marker = Marker(
                            markerId: markerId,
                            position: LatLng(state.orderLat!, state.orderLong!),
                            // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),

                          );

                          setState(() {
                            // adding a new marker to map
                            markers[markerId] = marker;
                          });
                        });
                        // nextScreen(context, ChangeOrderLocation());
                      }, icon: Icon(Icons.edit,color: kUniversalColor,))
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: getHeight(context) / 6,
                    width: double.infinity,
                    child: GoogleMap(
                      buildingsEnabled: true,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      tiltGesturesEnabled: false,
                      indoorViewEnabled: true,
                      scrollGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      initialCameraPosition:
                      CameraPosition(target: LatLng(lat,long), zoom: 13.0),
                      onMapCreated: onMapCreated,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(markers.values),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(state.orderAddress ?? "")
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sticky_note_2_outlined,color: kUniversalColor,),
                          Text("Order summary",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: kUniversalColor,))
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("subtotal"),
                      Text("\$${widget.productPrice}"),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("shipping fee"),
                      Text("will be added",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",style: TextStyle(fontSize: 18),),
                      Text("\$${widget.productPrice}",style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          color: Colors.grey[300],
          onPressed: (){
            bloc.addOrder(widget.productId, widget.businessId, authB.userID!, authB.token, widget.productPrice, context,widget.productName);
            // nextScreen(context, CheckOutPage());
          },
          child: Text("Buy Now"),
        ),
      ),
    );
  },
);
  }
}
