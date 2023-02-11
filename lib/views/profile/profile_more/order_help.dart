import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import 'cancle_orderPage.dart';
class OrderHelp extends StatefulWidget {
  final int index;

  const OrderHelp({Key? key, required this.index}) : super(key: key);

  @override
  State<OrderHelp> createState() => _OrderHelpState();
}

class _OrderHelpState extends State<OrderHelp> {
  DateFormat datef =  DateFormat('dd/MMM/yyyy , hh:mm a');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var d = state.userOrder![widget.index];
        return Scaffold(
          appBar: AppBar(
            title: Text("Help"),
          ),
          body: Column(
            children: [
              ListTile(
                title: Text(d.businessName!,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                tileColor: Colors.grey[300],
                subtitle: Text(datef.format(d.addDate!)),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: d.orderStatus == "0" ? Colors.orange: d.orderStatus == "3" ? Colors.red:Colors.green,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SizedBox(
                    width: d.orderStatus == "1" ? 100 : 90,
                    child: Row(
                      children: [
                        Icon(d.orderStatus == "0" ? CupertinoIcons.info_circle_fill : d.orderStatus == "1" ? LineIcons.truck: d.orderStatus == "3" ? CupertinoIcons.clear:CupertinoIcons.check_mark_circled_solid,size: 15,),
                        SizedBox(width: 5,),
                        Text(d.orderStatus == "0" ? "Pending" : d.orderStatus == "1" ? "On the way":d.orderStatus == "3" ?"Cancelled": "Delivered"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              d.orderStatus == "0" ?  ListTile(
                onTap: (){
                  nextScreen(context, CancelOrderPage(index: widget.index,));
                },
                tileColor: Colors.white,
                title: Text("I want to cancel my order"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ):Container(),
            ],
          ),
        );
      },
    );
  }
}
