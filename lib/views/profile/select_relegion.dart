import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';
class SelectReligion extends StatefulWidget {
  const SelectReligion({Key? key}) : super(key: key);

  @override
  State<SelectReligion> createState() => _SelectReligionState();
}

class _SelectReligionState extends State<SelectReligion> {
  String val = "";
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Religion"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Select Religion",
              prefixIcon: Icon(Icons.search)
            ),
            onChanged: (v){
              setState(() {
                val = v;
              },
              );
            },
          ),
          val == '' ? Container():ListTile(
            onTap: (){
              bloc.setRelegion(val);
              Navigator.pop(context);
            },
            title: Text(val,style: TextStyle(fontWeight: FontWeight.bold),),
            leading: Container(
              // width: 30,
              decoration:  BoxDecoration(
                // border: Border.all(),
                shape: BoxShape.circle,
                color: Colors.grey[200]!
              ),
              // padding: EdgeInsets.all(9),
              child: Icon(LineIcons.starAndCrescent),
            ),
          )
        ],
      ),
    );
  }
}
