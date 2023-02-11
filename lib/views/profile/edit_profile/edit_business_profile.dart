import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/authentication/pick_business_location.dart';
import 'package:happiverse/views/profile/components/clip_path.dart';
import 'package:happiverse/views/profile/edit_profile/edit_business_profile_cover.dart';
import 'package:happiverse/views/profile/edit_profile/pick_business_map_location.dart';

import 'edit_business_hours.dart';

class EditBusinessProfile extends StatefulWidget {
  const EditBusinessProfile({Key? key}) : super(key: key);

  @override
  _EditBusinessProfileState createState() => _EditBusinessProfileState();
}

class _EditBusinessProfileState extends State<EditBusinessProfile> {


  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    bloc.setBusinessMarker(true);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Business Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Profile Logo",style: TextStyle(),),
                      TextButton(onPressed: ()=> nextScreen(context, EditBusinessProfileCover()), child: const Text("Edit"))
                    ],
                  ),
                  SizedBox(
                    height: getHeight(context) / 4.0,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.businessProfile!.featureImageUrl == null || state.businessProfile!.featureImageUrl == ""? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${state.businessProfile!.featureImageUrl}")
                            )
                          ),
                          height: getHeight(context) / 5,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.businessProfile!.logoImageUrl}"),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("BUSINESS NAME",style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller:TextEditingController(text: state.businessProfile!.businessName),
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                            onChanged: (v){},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OWNER NAME",style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller:TextEditingController(text: state.businessProfile!.ownerName),
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            onChanged: (v){},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("BUSINESS CONTACT",style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller:TextEditingController(text: state.businessProfile!.businessContact),
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            onChanged: (v){},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("BUSINESS HOURS",style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (c,i){
                                    return Divider();
                                  },
                                  shrinkWrap: true,
                                  itemCount: state.businessProfile!.businessHours!.length-1,
                                  itemBuilder: (c,index){
                                    var data = state.businessProfile!.businessHours![index];
                                    return  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data.day,style: TextStyle(fontSize: 13),),
                                          state.businessProfile!.isAlwaysOpen == '1'? Padding(
                                            padding: const EdgeInsets.only(right:40.0),
                                            child: Text("Open 24 hours"),
                                          ):Padding(
                                            padding: const EdgeInsets.only(right:40.0),
                                            child: data.openTime == "12:00 AM" ? Text("Closed All Day"): Text("Open ${data.openTime} - Close ${data.closeTime}",style: TextStyle(fontSize: 13),),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              IconButton(onPressed: (){
                                if(state.businessProfile!.isAlwaysOpen == "1"){
                                  bloc.selectAlwayBusinessHours(true);
                                }
                               print(state.businessProfile!.isAlwaysOpen);
                                nextScreen(context, EditBusinessHours());
                              }, icon: Icon(Icons.arrow_forward_ios_rounded))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("BUSINESS LOCATION",style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  // readOnly: true,
                                  controller:TextEditingController(text: state.businessProfile!.address),
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                  onChanged: (v){},
                                ),
                              ),
                              TextButton(onPressed: (){
                                showCupertinoModalPopup(context: context, builder: (c){
                                  return Builder(
                                    builder: (context) {
                                      return PickBusinessMapLocation();
                                    }
                                  );
                                });
                              }, child: const Text("Edit"))
                            ],
                          ),
                          Container(
                            height: 200,
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
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
