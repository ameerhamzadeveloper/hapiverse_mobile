import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../components/secondry_button.dart';

class EditEducation extends StatefulWidget {
  const EditEducation({Key? key}) : super(key: key);

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  bool currentlyReading = false;
  DateFormat dateFormat = DateFormat('dd / MMM / yyyy');
  List<String> educations = [
    "School",
    "College",
    "University"
  ];
  String educationVal = "School";

  String name = '';
  String location = '';
  bool? currentlyWorking;
  DateTime? startDate;
  DateTime? endDate;


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Educations"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(LineIcons.graduationCap),
                      ),
                      Expanded(child: TextField(
                        controller: TextEditingController(text: state.educationName),
                        decoration: InputDecoration(
                            hintText: "Education Name",
                            border: InputBorder.none
                        ),
                        onChanged: (v){
                          name = v;
                          // bloc.assignEducationValue(1, v);
                        },
                      ))
                    ],
                  ),
                  Divider(),
                  TextField(
                    controller: TextEditingController(text: state.educationLocation),
                    decoration: InputDecoration(
                        hintText: "Location",
                        border: InputBorder.none
                    ),
                    onChanged: (v){
                      location = v;
                      // bloc.assignEducationValue(2, v);
                    },
                  ),
                  Divider(),
                  SizedBox(height: 10,),
                  Container(
                    height: 45,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: educations.map((String value) {
                          // educationVal = educationVal == 'School' ? state.educationLevel! : "School";
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: educationVal,
                        onChanged: (val){
                          print(val);
                          setState(() {
                            educationVal = val.toString();
                          });
                          // bloc.assignEducationValue(2, val!);
                        },
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Currently Studying here"),
                      Platform.isIOS ? CupertinoSwitch(
                          value: currentlyReading, onChanged: (v) {
                        setState(() {
                          currentlyReading = !currentlyReading;
                        });
                        // bloc.assig(5, v == true ? "1":"0");
                      }) : Switch(value: currentlyReading, onChanged: (v) {
                        setState(() {
                          currentlyReading = !currentlyReading;
                        });
                        // bloc.assignWorkValue(5, v == true ? "1":"0");
                      },
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(currentlyReading ? "Since" :"Start Date"),
                    ],
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1940, 3, 5),
                        onChanged: (date) {},
                        onConfirm: (date) {
                          startDate = date;
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const Icon(LineIcons.briefcase),
                            Text(dateFormat.format(DateTime.parse(state.educationStartYear ?? '2022-10-21')).toString()),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                    ),
                  ),
                  !currentlyReading ? Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text("End Date"),
                        ],
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1940, 3, 5),
                            onChanged: (date) => {},
                            onConfirm: (date) {
                              endDate = date;
                            },
                            currentTime: DateTime.now(),
                          );
                        },
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const Icon(LineIcons.briefcase),
                                Text(dateFormat.format(DateTime.parse(state.educationEndYaer?? '2022-12-22')).toString()),
                                Icon(Icons.arrow_drop_down_sharp)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):Container(),
                  SizedBox(height: 20,),
                  SecendoryButton(text: "Update", onPressed: (){
                    Map<String,dynamic> b = {};
                    if(name != ''){
                      b['title'] = name;
                    }
                    if(location != ''){
                      b['location'] = location;
                    }

                    if(educationVal != state.educationLevel){
                       b['level'] = educationVal;
                    }
                    if(currentlyReading == false){
                      currentlyReading ? b['currently_studying'] = '1':b['currently_studying'] = '0';
                    }
                    if(startDate != null){
                      b['startDate'] = startDate.toString();
                    }
                    if(endDate != null){
                      b['endDate'] = endDate.toString();
                    }
                    b['userId'] = authBloc.userID!;
                    b['token'] = authBloc.accesToken!;
                    bloc.editEducation(authBloc.userID!,authBloc.accesToken!, b,context);
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
