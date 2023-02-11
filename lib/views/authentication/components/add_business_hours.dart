import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/authentication/components/select_time.dart';

class AddBusinessHours extends StatefulWidget {
  const AddBusinessHours({Key? key}) : super(key: key);
  @override
  _AddBusinessHoursState createState() => _AddBusinessHoursState();
}
class _AddBusinessHoursState extends State<AddBusinessHours> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(color: kSecendoryColor,),
            title: const Text("Business Hours"),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Save", style: TextStyle(color: kSecendoryColor,),),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("SCHEDULE", style: TextStyle(color: Colors.grey),),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          bloc.selectAlwayBusinessHours(false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Open For Selected hours"),
                            state.alwaysOpen ? Container():Icon(Icons.check)
                          ],
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          bloc.selectAlwayBusinessHours(true);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Text("Always Open"),
                            state.alwaysOpen ? const Icon(Icons.check):Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      onTap: state.alwaysOpen ? null :(){
                        nextScreen(context, SelectHoursTime(whichDay: 1));
                      },
                      child: ListTile(
                        title: const Text("Saturday"),
                        subtitle: state.alwaysOpen ? Text("Open 24 hours") : state.closedAllDaySaturday ? const Text("Closed All Day"):Text("${state.saturdayStartTime.format(context)} to ${state.saturdayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    InkWell(
                      onTap: state.alwaysOpen ? null :(){
                        nextScreen(context, SelectHoursTime(whichDay: 2));
                      },
                      child: ListTile(
                        title: const Text("Sunday"),
                        subtitle: state.alwaysOpen ? Text("Open 24 hours") : state.closedAllDaySunday ? const Text("Closed All Day"):Text("${state.sundaryStartTime.format(context)} to ${state.sundayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    InkWell(
                      onTap: state.alwaysOpen ? null :(){
                        nextScreen(context, const SelectHoursTime(whichDay: 3));
                      },
                      child: ListTile(
                        title: const Text("Monday"),
                        subtitle: state.alwaysOpen ? const Text("Open 24 hours") : state.closedAllDayMonday ? const Text("Closed All Day"):Text("${state.mondayStartTime.format(context)} to ${state.mondayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    InkWell(
                      onTap: state.alwaysOpen ? null :(){
                        nextScreen(context, const SelectHoursTime(whichDay: 4));
                      },
                      child: ListTile(
                        title: const Text("Tuesday"),
                        subtitle: state.alwaysOpen ? const Text("Open 24 hours") : state.closedAllDayTuesday ? const Text("Closed All Day"):Text("${state.tuesdayStartTime.format(context)} to ${state.tuesdayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    InkWell(
                      onTap: state.alwaysOpen ? null :(){
                        nextScreen(context, const SelectHoursTime(whichDay: 5));
                      },
                      child: ListTile(
                        title: const Text("Wednesday"),
                        subtitle: state.alwaysOpen ? const Text("Open 24 hours") : state.closedAllDayWednesDay ? const Text("Closed All Day"):Text("${state.wednesdayStartTime.format(context)} to ${state.wednesdayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    InkWell(
                      onTap: state.alwaysOpen ? null :(){
                        nextScreen(context, const SelectHoursTime(whichDay: 6));
                      },
                      child: ListTile(
                        title: const Text("Thursday"),
                        subtitle: state.alwaysOpen ? const Text("Open 24 hours") :state.closedAllDayThursday ? const Text("Closed All Day"): Text("${state.thursdayStartTime.format(context)} to ${state.thursdayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                    InkWell(
                      onTap:state.alwaysOpen ? null : (){
                        nextScreen(context, const SelectHoursTime(whichDay: 7));
                      },
                      child: ListTile(
                        title: const Text("Friday"),
                        subtitle: state.alwaysOpen ? const Text("Open 24 hours") :state.closedAllDayFriday ? const Text("Closed All Day"): Text("${state.fridayStartTime.format(context)} to ${state.firdayEndTime.format(context)}"),
                        trailing: state.alwaysOpen ? Container(width: 2,):const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
