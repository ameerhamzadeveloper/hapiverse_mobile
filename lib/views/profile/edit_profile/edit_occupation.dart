import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/secondry_button.dart';
class EditOccupations extends StatefulWidget {
  const EditOccupations({Key? key}) : super(key: key);

  @override
  State<EditOccupations> createState() => _EditOccupationsState();
}

class _EditOccupationsState extends State<EditOccupations> {
  bool currentlyWorkhere = false;
  DateFormat dateFormat =  DateFormat('dd / MMM / yyyy');
  GlobalKey<FormState> key = GlobalKey<FormState>();

  String title = '';
  String workspaceName = '';
  String location = '';
  String description = '';
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
        title: Text("Edit Occupation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child:  Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(LineIcons.briefcase),
                    ),
                    Expanded(child: TextField(
                      controller: TextEditingController(text: state.workName),
                      decoration: InputDecoration(
                          hintText: "Workplace Name",
                          border: InputBorder.none
                      ),
                      onChanged: (v){
                        workspaceName = v;
                        // bloc.assignWorkValue(1, v);
                      },
                    ))
                  ],
                ),
                Divider(),
                TextField(
                  controller: TextEditingController(text: state.workTitle),
                  decoration: InputDecoration(
                      hintText: "Job Title",
                      border: InputBorder.none
                  ),
                  onChanged: (v){
                    title = v;
                    // bloc.assignWorkValue(2, v);
                  },
                ),
                Divider(),
                TextField(
                  controller: TextEditingController(text: state.workLocation),
                  decoration: InputDecoration(
                      hintText: "Location",
                      border: InputBorder.none
                  ),
                  onChanged: (v){
                    location = v;
                    // bloc.assignWorkValue(3, v);
                  },
                ),
                Divider(),
                TextField(
                  controller: TextEditingController(text: state.workDescription),
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Describe your work",
                      border: InputBorder.none
                  ),
                  onChanged: (v){
                    description = v;
                    // bloc.assignWorkValue(4, v);
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Currently work here"),
                    Platform.isIOS ? CupertinoSwitch(
                        value: currentlyWorkhere, onChanged: (v) {
                      setState(() {
                        currentlyWorkhere = !currentlyWorkhere;
                      });
                      // bloc.assignWorkValue(5, v == true ? "1":"0");
                    }) : Switch(value: currentlyWorkhere, onChanged: (v) {
                      setState(() {
                        currentlyWorkhere = !currentlyWorkhere;
                      });
                      // bloc.assignWorkValue(5, v == true ? "1":"0");
                    },
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text(currentlyWorkhere ? "Since" :"Start Date"),
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
                          Text(dateFormat.format(DateTime.parse(state.workStartDate ?? '2022-02-21')).toString()),
                          Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ),
                    ),
                  ),
                ),
                !currentlyWorkhere ? Column(
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
                          onChanged: (date){

                          },
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
                              Text(dateFormat.format(DateTime.parse(state.workEndDate ?? '2022-12-21')).toString()),
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
                  if(title != ''){
                    b['title'] = title;
                  }
                  if(workspaceName != ''){
                    b['workSpaceName'] = workspaceName;
                  }
                  if(location != ''){
                    b['location'] = location;
                  }
                  if(description != ''){
                    b['description'] = description;
                  }
                  if(currentlyWorkhere == false){
                    currentlyWorkhere ? b['current_working'] = '1':b['current_working'] = '0';
                  }
                  if(startDate != null){
                    b['startDate'] = startDate.toString();
                  }
                  if(endDate != null){
                    b['endDate'] = endDate.toString();
                  }
                  b['userId'] = authBloc.userID!;
                  b['token'] = authBloc.accesToken!;
                  bloc.editOcupation(authBloc.userID!,authBloc.accesToken!, b,context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
