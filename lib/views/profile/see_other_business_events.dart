import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../utils/utils.dart';
import '../../views/business_tools/events/other_events_details.dart';
import '../../views/components/universal_card.dart';
import 'package:intl/intl.dart';

import '../../utils/constants.dart';

class SeeOtherBusinessEvents extends StatefulWidget {
  @override
  _SeeOtherBusinessEventsState createState() => _SeeOtherBusinessEventsState();
}

class _SeeOtherBusinessEventsState extends State<SeeOtherBusinessEvents> {
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  DateFormat timeFormat = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Business Events"),),
          body: UniversalCard(
            widget: ListView.builder(
              itemCount: state.otherBusinessEvent!.length,
              itemBuilder: (c,i){
                var d =state.otherBusinessEvent![i];
                return InkWell(
                  onTap: (){
                    nextScreen(context, OtherEventDetails(index: i));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: getHeight(context) / 4,
                          width: getWidth(context),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("${Utils.baseImageUrl}${d.images![0].imageUrl}")
                            )
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.s,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${dateFormat.format(d.eventDate!)} at ${d.eventTime}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
                              Text(d.eventName ?? "",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  Expanded(child: Text(d.eventDescription!,style: TextStyle(fontSize: 14,color: Colors.grey),)),
                                ],
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ),
        );
      },
    );
  }
}
