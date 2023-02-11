import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../views/business_tools/business_tools.dart';
import '../../../views/business_tools/events/add_events.dart';
import '../../../views/components/universal_card.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../add_product/add_collection.dart';
class BusinessEvents extends StatefulWidget {
  const BusinessEvents({Key? key}) : super(key: key);

  @override
  _BusinessEventsState createState() => _BusinessEventsState();
}

class _BusinessEventsState extends State<BusinessEvents> {
  @override
  void initState() {
    super.initState();
    final authb = context.read<RegisterCubit>(); 
    final bloc = context.read<BusinessProductCubit>();
    bloc.fetchBusinessEvent(authb.userID!, authb.accesToken!);
  }
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  DateFormat timeFormat = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    final authb = context.read<RegisterCubit>();
    final bloc = context.read<BusinessProductCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              onTap: (){
                nextScreen(context,const AddEvents());
              },
              leading: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Icon(LineIcons.plusCircle),
                ),
              ),
              title: const Text("Add New Event"),
              dense: true,
            ),
            const SizedBox(height: 20,),
            state.businessEvent == null ? Center(child: CupertinoActivityIndicator(),):
                state.businessEvent!.isEmpty ? Center(child: Text("No Events"),):
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.businessEvent!.length,
                  itemBuilder: (ctx,i){
                    var data = state.businessEvent![i];
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: getWidth(context) / 3,
                                // width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data.images == null || data.images!.isEmpty ? "":
                                          "${Utils.baseImageUrl}${data.images![0].imageUrl!}",
                                        )
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${dateFormat.format(data.eventDate!)} at ${data.eventTime}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
                                    Text(data.eventName!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    // Text(data.eventName!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Container(
                                      width: getWidth(context)/ 1.8,
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        subtitle: Text(data.eventDescription!,style: TextStyle(fontSize: 14,color: Colors.grey),),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(context),
                                      child: OutlinedButton(onPressed: (){ showDialog(context: context, builder: (c){
                                        return AlertDialog(
                                          title: const Text("Do you want to delete event?"),
                                          actions: [
                                            TextButton(onPressed: ()=>Navigator.pop(context), child: Text("No")),
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                              bloc.deleteEvent(authb.userID!, authb.accesToken!, data.eventId!);
                                            } , child: Text("Yes",style: TextStyle(color: Colors.red),)),
                                          ],
                                        );
                                      });}, child: Text("Delete Event",style: TextStyle(color: Colors.red),)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    );
                  },
                )
          ],
        ),
      ),
    );
  },
);
  }
}
