import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';

import '../../../utils/constants.dart';
class EditHoursTime extends StatefulWidget {
  final int whichDay;
  const EditHoursTime({Key? key,required this.whichDay}) : super(key: key);

  @override
  _EditHoursTimeState createState() => _EditHoursTimeState();
}

class _EditHoursTimeState extends State<EditHoursTime> {
  String day = 'Saturday';
  getTitle(){
    switch(widget.whichDay){
      case 1:
        setState(() {
          day = "Saturday";
        });
        break;
      case 2:
        setState(() {
          day = "Sunday";
        });
        break;
      case 3:
        setState(() {
          day = "Monday";
        });
        break;
      case 4:
        setState(() {
          day = "Tuesday";
        });
        break;
      case 5:
        setState(() {
          day = "Wednesday";
        });
        break;
      case 6:
        setState(() {
          day = "Thursday";
        });
        break;
      case 7:
        setState(() {
          day = "Friday";
        });
        break;
    }
  }
  @override
  void initState() {
    super.initState();
    getTitle();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(day),
        actions: [
          MaterialButton(
            onPressed: ()=> Navigator.pop(context),
            child: const Text("Save", style: TextStyle(color: kSecendoryColor,),),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if(widget.whichDay == 1){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDaySaturday,
                          onChanged: (val){
                            bloc.saturdayAllDayOff();
                          })
                    ],
                  ),
                  const SizedBox(height: 20,),
                  state.closedAllDaySaturday ? Container():Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectSaturdayStartTime(context);
                        },
                        child: Column(
                          children: [
                            const Text("Start Time"),
                            const SizedBox(
                              height: 10,
                            ),
                            state.saturdayStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.saturdayStartTime.format(context)}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      const Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectSaturdayEndTime(context);
                        },
                        child: Column(
                          children: [
                            const Text("End Time"),
                            const SizedBox(
                              height: 10,
                            ),
                            state.saturdayEndTime != TimeOfDay.now()
                                ? Text(
                              state.saturdayEndTime.format(context),
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else if(widget.whichDay == 2){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDaySunday,
                          onChanged: (val){
                            bloc.saturdayAllDayOff();
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  state.closedAllDaySunday ? Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectSundayStartTime(context);
                        },
                        child: Column(
                          children: [
                            Text("Start Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.sundaryStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.sundaryStartTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectSundayEndTime(context);
                        },
                        child: Column(
                          children: [
                            Text("End Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.sundayEndTime != TimeOfDay.now()
                                ? Text(
                              "${state.sundayEndTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else if(widget.whichDay == 3){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDayMonday,
                          onChanged: (val){
                            bloc.mondayAllDayOff();
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  state.closedAllDayMonday ? Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectMondayStartTime(context);
                        },
                        child: Column(
                          children: [
                            Text("Start Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.mondayStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.mondayStartTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectSundayEndTime(context);
                        },
                        child: Column(
                          children: [
                            Text("End Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.mondayEndTime != TimeOfDay.now()
                                ? Text(
                              "${state.mondayEndTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else if(widget.whichDay == 4){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDayTuesday,
                          onChanged: (val){
                            bloc.tuesdayAllDayOff();
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  state.closedAllDayTuesday ? Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectTuesdayStartTime(context);
                        },
                        child: Column(
                          children: [
                            Text("Start Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.tuesdayStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.tuesdayStartTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectTuesdayEndTime(context);
                        },
                        child: Column(
                          children: [
                            Text("End Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.tuesdayEndTime != TimeOfDay.now()
                                ? Text(
                              "${state.tuesdayEndTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else if(widget.whichDay == 5){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDayWednesDay,
                          onChanged: (val){
                            bloc.wednesdayAllDayOff();
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  state.closedAllDayWednesDay ? Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectWednesdayStartTime(context);
                        },
                        child: Column(
                          children: [
                            Text("Start Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.wednesdayStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.wednesdayStartTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectWednesdayEndTime(context);
                        },
                        child: Column(
                          children: [
                            Text("End Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.wednesdayEndTime != TimeOfDay.now()
                                ? Text(
                              "${state.wednesdayEndTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else if(widget.whichDay == 6){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDayThursday,
                          onChanged: (val){
                            bloc.thursdayAllDayOff();
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  state.closedAllDayThursday ? Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectThursdayStartTime(context);
                        },
                        child: Column(
                          children: [
                            Text("Start Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.thursdayStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.thursdayStartTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectThursdayEndTime(context);
                        },
                        child: Column(
                          children: [
                            Text("End Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.thursdayEndTime != TimeOfDay.now()
                                ? Text(
                              "${state.thursdayEndTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }else{
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Closed All Day"),
                      CupertinoSwitch(
                          value: state.closedAllDayFriday,
                          onChanged: (val){
                            bloc.fridayAllDayOff();
                          })
                    ],
                  ),
                  SizedBox(height: 20,),
                  state.closedAllDayFriday ? Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectFridayStartTime(context);
                        },
                        child: Column(
                          children: [
                            Text("Start Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.fridayStartTime != TimeOfDay.now()
                                ? Text(
                              "${state.fridayStartTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                      Text("To"),
                      InkWell(
                        onTap: () {
                          bloc.selectFridayEndTime(context);
                        },
                        child: Column(
                          children: [
                            Text("End Time"),
                            SizedBox(
                              height: 10,
                            ),
                            state.firdayEndTime != TimeOfDay.now()
                                ? Text(
                              "${state.firdayEndTime.format(context)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              "assets/date.png",
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

          },
        ),
      ),
    );
  }
}
