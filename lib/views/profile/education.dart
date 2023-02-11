import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import '../components/secondry_button.dart';
class Educations extends StatefulWidget {
  const Educations({Key? key}) : super(key: key);

  @override
  State<Educations> createState() => _EducationsState();
}

class _EducationsState extends State<Educations> {
  bool currentlyReading = false;
  DateFormat dateFormat =  DateFormat('dd / MMM / yyyy');
  List<String> educations = [
    "School",
    "College",
    "University"
  ];

  String educationVal = "School";

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
     builder: (context, state) {
      return Scaffold(
      appBar: AppBar(
        title: const Text("Add Education"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(LineIcons.graduationCap),
                  ),
                  Expanded(child: TextField(
                    // controller: TextEditingController(text: state.educationName),
                    decoration: InputDecoration(
                        hintText: "Education Name",
                        border: InputBorder.none
                    ),
                    onChanged: (v){
                      bloc.assignEducationValue(1, v);
                    },
                  ))
                ],
              ),
              Divider(),
              TextField(
                decoration: InputDecoration(
                    hintText: "Location",
                    border: InputBorder.none
                ),
                onChanged: (v){
                  bloc.assignEducationValue(2, v);
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
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: educationVal,
                    onChanged: (val){
                      setState(() {
                        educationVal = val.toString();
                      });
                      bloc.assignEducationValue(2, val!);
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
                    onChanged: (date) => bloc.educationStartDate(date),
                    onConfirm: (date) {},
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
                        Text(dateFormat.format(state.educationStartDate!).toString()),
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
                        onChanged: (date) => bloc.educationEndDate(date),
                        onConfirm: (date) {},
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
                            Text(dateFormat.format(state.educationEndDate!).toString()),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ):Container(),
              SizedBox(height: 20,),
              SecendoryButton(text: "Done", onPressed: ()=> Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
