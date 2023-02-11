import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {

  List<String> dropDown = [
    "Positive",
    "Negative",
  ];
  String selected = 'Positive';

  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    final format = DateFormat('dd MMM yyyy');
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      appBar: AppBar(
        title: const Text("Add Record"),
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        actions: [
          TextButton(onPressed: (){
            bloc.addCovidRecord(authBloc.userID!, authBloc.accesToken!);
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "Record Added");
          }, child: Text("Done"),style: TextButton.styleFrom(
            primary: Colors.white,
          ),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            Text("Hospital",style: TextStyle(fontFamily: '',fontSize: 18),),
                            Expanded(
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Hospital Name is Required";
                                  }
                                },
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  hintText: "victoria medical",
                                  border: InputBorder.none
                                ),
                                onChanged: (val){
                                  bloc.assignHospitalName(val);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 30,
                        child: InkWell(
                          onTap: (){
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(1940, 3, 5),
                              onChanged: (date) {
                                bloc.assignHealthDate(date);
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                              onConfirm: (date) {},
                              currentTime: DateTime.now(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              const Text("Expire On",style: TextStyle(fontFamily: '',fontSize: 18),),
                              Text(format.format(selectedDate).toString())
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status",style: TextStyle(fontFamily: '',fontSize: 18),),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: dropDown.map((e){
                                  return DropdownMenuItem<String>(child: Text(e),value: e,);
                                }).toList(),
                                onChanged: (v){
                                  bloc.assignCovidStatus(v.toString());
                                  setState(() {
                                    selected = v.toString();
                                  });
                                },
                                value: selected,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
