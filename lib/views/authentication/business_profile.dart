import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../views/authentication/components/add_business_hours.dart';
import '../../views/authentication/pick_business_location.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../profile/components/clip_path.dart';

class BusinessProfile extends StatefulWidget {
  const BusinessProfile({Key? key}) : super(key: key);

  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  DateFormat dateFormat =  DateFormat('dd / MMM / yyyy');
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit,RegisterState>(
        builder: (context,state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                ClipPath(
                  clipper: ProfileClipPath(),
                  child: state.businessCoverPath == null ? Container(
                    height: getHeight(context) / 3,
                    color: kUniversalColor,
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: (){
                                          bloc.getImageCamera(true);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(LineIcons.camera),
                                            SizedBox(width: 10,),
                                            Text("Camera")
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      MaterialButton(
                                        onPressed: () {
                                          bloc.getImage(true);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(LineIcons.image),
                                            SizedBox(width: 10,),
                                            Text("Gallary")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LineIcons.plus,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text("Add Business Cover",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ):Container(
                    height: getHeight(context) / 3,
                    // color: kUniversalColor,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(state.businessCoverPath!))
                      )
                    ),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: (){
                                          bloc.getImageCamera(true);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(LineIcons.camera),
                                            SizedBox(width: 10,),
                                            Text("Camera")
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      MaterialButton(
                                        onPressed: () {
                                          bloc.getImage(true);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(LineIcons.image),
                                            SizedBox(width: 10,),
                                            Text("Gallary")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LineIcons.plus,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text("Change Business Cover",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                state.profileImagePath == null ? Align(
                  alignment: const Alignment(0.0,-0.5),
                  child: Container(
                    height: getWidth(context) / 3,
                    width: getWidth(context) / 4,
                    decoration: BoxDecoration(
                        color: kUniversalColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 3),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                AssetConfig.kLogo
                            )
                        )
                    ),
                  ),
                ):
                Align(
                  alignment: const Alignment(0.0,-0.5),
                  child: Container(
                    height: getWidth(context) / 3,
                    width: getWidth(context) / 4,
                    decoration: BoxDecoration(
                        color: kUniversalColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white,width: 3),
                        image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(state.profileImagePath!))
                        )
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0,-0.2),
                  child: Text(state.fullName!,style: TextStyle(fontSize: 22),),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: getHeight(context) / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(state.errorMessage,style: const TextStyle(color: Colors.red),),
                              ],
                            ),
                            TextFormField(
                              controller: state.businessLocation,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PickBusinessLocation()));
                              },
                              onChanged: (val)=>bloc.assignBusinessLocation(val),
                              decoration: const InputDecoration(
                                  labelText: "Location",
                                  hintText: "eg: football, dancing",
                                  suffixIcon: Icon(LineIcons.mapMarked)),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              onChanged: (val){
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                bloc.assignPhoneNo(val);
                                if(val.length == 13){
                                  currentFocus.unfocus();
                                }else if(val.length == 15){
                                  currentFocus.unfocus();
                                }
                              },
                              decoration: const InputDecoration(
                                  labelText: "Contact Number",
                                  hintText: "+1 xxx xxx xxxx",
                                  suffixIcon: Icon(LineIcons.phone)),
                            ),
                            // const Divider(color: Colors.grey,thickness: 1.5,),
                            const SizedBox(height: 20,),
                            state.isHoursSelected == false ? InkWell(
                              onTap: (){
                                nextScreen(context, AddBusinessHours());
                                bloc.hoursSelected();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Add Business Hours",style: TextStyle(color: Colors.black54,fontSize: 15),),
                                  Icon(LineIcons.clock)
                                ],
                              ),
                            ): InkWell(
                              onTap: (){
                                nextScreen(context, AddBusinessHours());
                              },
                              child: Container(
                                width: getWidth(context),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Saturday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"): state.closedAllDaySaturday ? Text("Closed All Day"):Text("${state.saturdayStartTime.format(context)} - ${state.saturdayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 35,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Sunday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"):state.closedAllDaySunday ? Text("Closed All Day"):Text("${state.sundaryStartTime.format(context)} - ${state.sundayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 35,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Monday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"):state.closedAllDayMonday ? Text("Closed All Day"):Text("${state.mondayStartTime.format(context)} - ${state.mondayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 35,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tuesday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"):state.closedAllDayTuesday ? Text("Closed All Day"):Text("${state.tuesdayStartTime.format(context)} - ${state.tuesdayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 20,),
                                              Icon(Icons.arrow_forward_ios_sharp,size: 15,color: Colors.grey,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Wednesday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"):state.closedAllDayWednesDay ? Text("Closed All Day"):Text("${state.wednesdayStartTime.format(context)} - ${state.wednesdayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 35,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Thursday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"):state.closedAllDayThursday ? Text("Closed All Day"):Text("${state.thursdayStartTime.format(context)} - ${state.thursdayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 35,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Friday",style: TextStyle(fontFamily: ""),),
                                          Row(
                                            children: [
                                              state.alwaysOpen ? Text("Open 24 hours"):state.closedAllDayFriday ? Text("Closed All Day"):Text("${state.fridayStartTime.format(context)} - ${state.firdayEndTime.format(context)}",style: TextStyle(fontFamily: ""),),
                                              SizedBox(width: 35,)
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.black,),

                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   height: 45,
                            //   child: DropdownButton<String>(
                            //     underline: const Divider(color: Colors.grey,thickness: 1.5,),
                            //     isExpanded: true,
                            //     iconEnabledColor: kUniversalColor,
                            //     items: state.relationDropList.map((String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //     value: state.relationVal,
                            //     onChanged: (val)=>bloc.changeRelationDrop(val),
                            //     isDense: true,
                            //   ),
                            // ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 45,
                              child: DropdownButton<String>(
                                underline: const Divider(color: Colors.grey,thickness: 1.5,),
                                isExpanded: true,
                                iconEnabledColor: kUniversalColor,
                                items: state.profileCategoryList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                                ).toList(),
                                value: state.profileCategoryVal,
                                onChanged: (val)=>bloc.changeProfileCategory(val),
                                isDense: true,
                              ),
                            ),
                            const SizedBox(height: 40,),
                            state.loadingState ? const Center(child: CircularProgressIndicator(),):MaterialButton(
                              minWidth: getWidth(context) / 3,
                              shape: const StadiumBorder(),
                              color: kSecendoryColor,
                              onPressed: (){
                                if(state.profileImagePath == null){
                                  bloc.imageNotSelected();
                                }else{
                                  bloc.createBusinessProfile(context);
                                }
                              },
                              child: const Text("Done",style: TextStyle(color: Colors.white),),
                            ),
                            const SizedBox(height: 50,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment(0.0,-0.3),
                  child: Text("Add Business Logo",style: TextStyle(color: Colors.grey,fontSize: 10),),
                ),
                SizedBox(
                  height: getHeight(context),
                  width: getWidth(context),
                  child: Align(
                    alignment: const Alignment(0.3,-0.4),
                    child: IconButton(onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){
                                        bloc.getImageCamera(false);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.camera),
                                          SizedBox(width: 10,),
                                          Text("Camera")
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    MaterialButton(
                                      onPressed: () {
                                            bloc.getImage(false);
                                            Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.image),
                                          SizedBox(width: 10,),
                                          Text("Gallary")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                      //
                    }, icon: const Icon(LineIcons.camera,size: 30,)),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
