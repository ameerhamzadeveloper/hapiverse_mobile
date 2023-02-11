import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:happiverse/views/profile/education.dart';
import 'package:happiverse/views/profile/select_relegion.dart';
import 'package:happiverse/views/profile/work_at.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../../views/profile/components/clip_path.dart';
import 'package:line_icons/line_icons.dart';

import '../components/secondry_button.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  DateFormat dateFormat =  DateFormat('dd / MMM / yyyy');
  RangeValues _distance = const RangeValues(0, 13000);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit,RegisterState>(
      builder: (context,state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Text(state.fullName ??"",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold),),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      // height: getHeight(context) / 1.8,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Row(
                              //   children: [
                              //     Text(state.errorMessage,style: const TextStyle(color: Colors.red),),
                              //   ],
                              // ),
                              TextFormField(
                                onChanged: (val)=>bloc.setHobby(val),
                                decoration: const InputDecoration(
                                    labelText: "Hobby",
                                    hintText: "eg: football, dancing",
                                    suffixIcon: Icon(LineIcons.walking)),
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: (){
                                  DatePicker.showDatePicker(
                                      context,
                                      showTitleActions: true,
                                      minTime: DateTime(1940, 3, 5),
                                      onChanged: (date) => bloc.changeDate(date),
                                      onConfirm: (date) {},
                                      currentTime: DateTime.now(),
                                  );
                                },
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(LineIcons.birthdayCake),
                                        Text(dateFormat.format(state.dateOfBirth).toString()),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.grey,thickness: 1.5,),
                              const SizedBox(height: 20,),
                              Container(
                                height: 45,
                                child: DropdownButton<String>(
                                  underline: const Divider(color: Colors.grey,thickness: 1.5,),
                                  isExpanded: true,
                                  iconEnabledColor: kUniversalColor,
                                  items: state.relationDropList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: state.relationVal,
                                  onChanged: (val)=>bloc.changeRelationDrop(val),
                                  isDense: true,
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Container(
                                height: 45,
                                child: DropdownButton<String>(
                                  underline: const Divider(color: Colors.grey,thickness: 1.5,),
                                  isExpanded: true,
                                  iconEnabledColor: kUniversalColor,
                                  items: state.genderList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                   },
                                  ).toList(),
                                  value: state.genderVal,
                                  onChanged: (val)=>bloc.changeGenderDrop(val),
                                  isDense: true,
                                ),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: TextEditingController(text: state.jobTitle),
                                onTap: ()=> nextScreen(context, WrokAt()),
                                onChanged: (val)=>bloc.setHobby(val),
                                decoration: const InputDecoration(
                                    labelText: "Work at",
                                    hintText: "eg: software, comapny",
                                    suffixIcon: Icon(LineIcons.briefcase)),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: TextEditingController(text: state.educationName),
                                onTap: ()=> nextScreen(context, Educations()),
                                onChanged: (val)=>bloc.setHobby(val),
                                decoration: const InputDecoration(
                                    labelText: "Education",
                                    hintText: "eg: CS, Master",
                                    suffixIcon: Icon(LineIcons.graduationCap)),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: TextEditingController(text: state.religion),
                                onTap: ()=> nextScreen(context, SelectReligion()),
                                // onChanged: (val)=>bloc.setHobby(val),
                                decoration: const InputDecoration(
                                    labelText: "Religion",
                                    hintText: "eg: Islam, Christianity",
                                    suffixIcon: Icon(LineIcons.starAndCrescent)),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: state.heightfeet == null ? TextEditingController():TextEditingController(text: "${state.heightfeet}ft ${state.heightInches}in"),
                                onTap: () {
                                  showCupertinoModalPopup(
                                      barrierDismissible: false,
                                      context:context,
                                      builder:(c){
                                        return CupertinoActionSheet(
                                          title: Text("Choose Height"),
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 200,
                                                    child: CupertinoPicker(
                                                      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                                        background: CupertinoColors.activeBlue.withOpacity(0.2),
                                                      ),
                                                      itemExtent: 50,
                                                      looping: true,
                                                      onSelectedItemChanged: (v){
                                                        print("ffet ${v+1}");
                                                        bloc.assignHeightFeet("${v+1}");
                                                      },
                                                      useMagnifier: true,
                                                      children: [
                                                        Center(child: Text("1'"),),
                                                        Center(child: Text("2'"),),
                                                        Center(child: Text("3'"),),
                                                        Center(child: Text("4'"),),
                                                        Center(child: Text("5'"),),
                                                        Center(child: Text("6'"),),
                                                        Center(child: Text("7'"),),
                                                        Center(child: Text("8'"),),
                                                        Center(child: Text("9'"),),
                                                      ],),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 200,
                                                    child: CupertinoPicker(
                                                      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                                        background: CupertinoColors.activeBlue.withOpacity(0.2),
                                                      ),
                                                      itemExtent: 50,
                                                      onSelectedItemChanged: (v){
                                                        bloc.assignHeightInches("${v+1}");
                                                      },
                                                      children: [
                                                        Center(child: Text("1\""),),
                                                        Center(child: Text("2\""),),
                                                        Center(child: Text("3\""),),
                                                        Center(child: Text("4\""),),
                                                        Center(child: Text("5\""),),
                                                        Center(child: Text("6\""),),
                                                        Center(child: Text("7\""),),
                                                        Center(child: Text("8\""),),
                                                        Center(child: Text("9\""),),
                                                        Center(child: Text("10\""),),
                                                        Center(child: Text("11\""),),
                                                        Center(child: Text("12\""),),
                                                      ],),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: SecendoryButton(text: "Done", onPressed: (){Navigator.pop(context);}),
                                            )
                                          ],
                                        );
                                      }
                                  );
                                },
                                // onChanged: (val)=>bloc.setHobby(val),
                                decoration: const InputDecoration(
                                    labelText: "Height",
                                    hintText: "eg: 6ft 2in",
                                    suffixIcon: Icon(LineIcons.rulerVertical)),
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(context: context, builder: (c){
                                    return AlertDialog(
                                      title: const Text("Hair Colour"),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              bloc.assignHairColor("Red", CupertinoColors.systemRed);
                                              Navigator.pop(context);
                                            },
                                            child:const CircleAvatar(
                                              backgroundColor: CupertinoColors.systemRed,
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              bloc.assignHairColor("Black", CupertinoColors.black);
                                              Navigator.pop(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: CupertinoColors.black,
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              bloc.assignHairColor("White", CupertinoColors.white);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                shape: BoxShape.circle
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor: CupertinoColors.white,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              bloc.assignHairColor("Brown", Colors.brown);
                                              Navigator.pop(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.brown,
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              bloc.assignHairColor("Blue", CupertinoColors.systemBlue);
                                              Navigator.pop(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: CupertinoColors.systemBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      state.hairColorMaterial == null ? Text("Hair Colour") : Row(
                                        children: [
                                          Text("Hair Colour : ${state.hairColor!}"),
                                          SizedBox(width: 10,),
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: state.hairColorMaterial!,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right:10.0),
                                        child: Icon(LineIcons.tint),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Distance ${_distance.start.round().toString()} km - ${_distance.end.round().toString()} km",style: TextStyle(fontSize: 16,),),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              RangeSlider(
                                values: _distance,
                                min: 0,
                                max: 13000,
                                divisions: 300,
                                labels: RangeLabels(
                                  _distance.start.round().toString(),
                                  _distance.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _distance = values;
                                    // bloc.setAdsAudionce("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",_currentRangeValues.start.round().toString(),'${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}');
                                  });
                                },
                              ),
                              const SizedBox(height: 40,),
                              // IconButton(onPressed: (){
                              //   bloc.setLoading();
                              // }, icon: Icon(Icons.abc_sharp)),
                              Row(
                                children: [
                                  Text(state.errorMessage,style: const TextStyle(color: Colors.red),),
                                ],
                              ),
                              state.loadingState ? const Center(child: CircularProgressIndicator(),):
                              MaterialButton(
                                minWidth: getWidth(context) / 3,
                                shape: const StadiumBorder(),
                                color: kSecendoryColor,
                                onPressed: (){
                                  if(state.profileImagePath == null){
                                    bloc.imageNotSelected();
                                  }else{
                                    bloc.createProfile(context);
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
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
