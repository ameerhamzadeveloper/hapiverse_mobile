import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
class StealthGhosting extends StatefulWidget {
  const StealthGhosting({Key? key}) : super(key: key);

  @override
  _StealthGhostingState createState() => _StealthGhostingState();
}

class _StealthGhostingState extends State<StealthGhosting> {
  List<String> stealthDays = [
    '15 Minutes',
    '30 Minutes',
    '1 Hour',
    '1 Day',
  ];
  String stealthValue = '15 Minutes';
  bool stealthValueEnabled = false;
  
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.getStealthStatus(authBloc.userID!, authBloc.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stealth"),
      ),
      body: UniversalCard(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.stealthModeEnable == null ? "Loading...":"Stealth is ${state.stealthModeEnable! ? "Enabled":"Disabled"} (${state.stealthModeTimeLeft})",style: TextStyle(color: state.stealthModeEnable == null ? Colors.green :state.stealthModeEnable! ? Colors.red:Colors.green),),
              ],
            ),
            Text("Stealth",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("The attribute or characteristic of acting in secrecy, or in such a way that the actions are unnoticed or difficult to detect by others. This feature allows users to go undetected by other devices and users"),
            SizedBox(height: 10,),
            Text("Select Time Period for Stealth",style: TextStyle(color: Colors.blue),),
            Container(
              height: 45,
              child: DropdownButton<String>(
                underline: const Divider(color: Colors.grey,thickness: 1.5,),
                isExpanded: true,
                iconEnabledColor: kUniversalColor,
                items: stealthDays.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
                ).toList(),
                value: stealthValue,
                onChanged: (val){
                  stealthValue = val.toString();
                  setState(() {});
                },
                isDense: true,
              ),
            ),ListTile(
              title: Text("Turn On/OFF Stealth"),
              trailing: Container(
                height: 5,
                child: CupertinoSwitch(
                  value: state.stealthModeEnable ?? false,
                  onChanged: (va)async{
                    setState(() {
                      // bloc.getStealthStatus(au, token)
                    });
                    bloc.addRemoveStealthStatus(authBloc.userID!, authBloc.accesToken!, stealthValue);
                  },
                ),
              ),
              leading: Icon(LineIcons.eyeSlash),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
