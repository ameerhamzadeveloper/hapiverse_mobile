import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:io';

class WrokAt extends StatefulWidget {
  const WrokAt({Key? key}) : super(key: key);

  @override
  State<WrokAt> createState() => _WrokAtState();
}

class _WrokAtState extends State<WrokAt> {
  bool currentlyWorkhere = false;
  DateFormat dateFormat =  DateFormat('dd / MMM / yyyy');

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Work At"),
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
                          decoration: InputDecoration(
                              hintText: "Workplace Name",
                              border: InputBorder.none
                          ),
                          onChanged: (v){
                            bloc.assignWorkValue(1, v);
                          },
                        ))
                      ],
                    ),
                    Divider(),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Job Title",
                          border: InputBorder.none
                      ),
                      onChanged: (v){
                        bloc.assignWorkValue(2, v);
                      },
                    ),
                    Divider(),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Location",
                          border: InputBorder.none
                      ),
                      onChanged: (v){
                        bloc.assignWorkValue(3, v);
                      },
                    ),
                    Divider(),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText: "Describe your work",
                          border: InputBorder.none
                      ),
                      onChanged: (v){
                        bloc.assignWorkValue(4, v);
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
                          bloc.assignWorkValue(5, v == true ? "1":"0");
                        }) : Switch(value: currentlyWorkhere, onChanged: (v) {
                          setState(() {
                            currentlyWorkhere = !currentlyWorkhere;
                          });
                          bloc.assignWorkValue(5, v == true ? "1":"0");
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
                          onChanged: (date) => bloc.workStartDate(date),
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
                              Text(dateFormat.format(state.workStartDate!).toString()),
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
                              onChanged: (date) => bloc.workEndDate(date),
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
                                  Text(dateFormat.format(state.workEndDate!).toString()),
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
          ),
        );
      },
    );
  }
}
