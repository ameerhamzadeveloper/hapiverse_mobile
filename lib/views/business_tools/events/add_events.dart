import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../views/business_tools/events/event_locations.dart';
import '../../../views/business_tools/events/preview_event_image.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../add_product/preview_product_image.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({Key? key}) : super(key: key);

  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  List<String> userType = [
    "Birthday",
    "Wedding",
    "Baby shower",
    "Party",
    "Bachelor/Bachelorette party",
    "Family Reunion",
    "Holiday gathering",
    "Christmas",
    "New Years",
    "Other",
  ];
  String userTypeVal = 'Birthday';

  List<String> businessType = [
    "Grand opening",
    "Sale",
    "Black Friday",
    "Product launch",
    "New location",
    "Other",
  ];
  String businessTypeVal = 'Grand opening';
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Event"),
            actions: [
              TextButton(onPressed: state.eventName == null || state.eventName!.isEmpty || state.eventDescription == null || state.eventDescription!.isEmpty || state.eventTimeController == null || state.eventTimeController!.text.isEmpty || state.eventDateController == null || state.eventDateController!.text.isEmpty || state.addEventImages== null || state.addEventImages!.isEmpty?null:(){
                bloc.addEvent(authB.userID!, authB.accesToken!, context);
              }, child: Text("Add",style: TextStyle(color: state.eventName == null || state.eventName!.isEmpty || state.eventDescription == null || state.eventDescription!.isEmpty || state.eventTimeController == null || state.eventTimeController!.text.isEmpty || state.eventDateController == null || state.eventDateController!.text.isEmpty || state.addEventImages == null || state.addEventImages!.isEmpty?Colors.grey:kSecendoryColor),))
            ],
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  state.addEventsImagesWidget == null || state.addEventsImagesWidget!.isEmpty ? InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){
                                        bloc.pickEventsImages(1);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.camera),
                                          SizedBox(width: 10,),
                                          Text("Camera")
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    MaterialButton(
                                      onPressed: () {
                                        bloc.pickEventsImages(2);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.image),
                                          SizedBox(width: 10,),
                                          Text("Gallery")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      height: getHeight(context) / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200]
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(LineIcons.camera),
                            SizedBox(width: 5,),
                            Text("Add Images"),
                          ],
                        ),
                      ),
                    ),
                  ):
                  CarouselSlider(
                      options: CarouselOptions(height: getHeight(context) / 4,aspectRatio: 16/9,
                        viewportFraction: 0.9,enableInfiniteScroll: false,),
                      items: List.generate(state.addEventsImagesWidget!.length, (index){
                        return InkWell(
                          onTap: (){
                            if(index != state.addEventImages!.length){
                              nextScreen(context, PreviewEventImage(index: index));
                            }else{
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        height: 120,
                                        child: Column(
                                          children: [
                                            MaterialButton(
                                              onPressed: (){
                                                bloc.pickEventsImages(1);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(LineIcons.camera),
                                                  SizedBox(width: 10,),
                                                  Text("Camera")
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            MaterialButton(
                                              onPressed: () {
                                                bloc.pickEventsImages(2);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(LineIcons.image),
                                                  SizedBox(width: 10,),
                                                  Text("Gallery")
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state.addEventsImagesWidget![index]),
                        );
                      })
                  ),
                  const Divider(),
                  const SizedBox(height: 10,),
                  TextField(
                    onChanged: (val){
                      bloc.assignEventValue(1,val);
                    },
                    decoration: const InputDecoration(
                        hintText: "Event Name"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    maxLines: 3,
                    onChanged: (val){
                      bloc.assignEventValue(2,val);
                    },
                    decoration: const InputDecoration(
                        hintText: "Event Description"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  authB.isBusinessShared! ? SizedBox(
                    height: 45,
                    child: DropdownButton<String>(
                      underline: const Divider(color: Colors.grey,thickness: 1.5,),
                      isExpanded: true,
                      iconEnabledColor: kUniversalColor,
                      items: businessType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                         );
                        },
                      ).toList(),
                      value: businessTypeVal,
                      onChanged: (val){
                        setState(() {
                          businessTypeVal = val.toString();
                         },
                        );
                      },
                      isDense: true,
                    ),
                  ) : SizedBox(
                    height: 45,
                    child: DropdownButton<String>(
                      underline: const Divider(color: Colors.grey,thickness: 1.5,),
                      isExpanded: true,
                      iconEnabledColor: kUniversalColor,
                      items: userType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                      ).toList(),
                      value: userTypeVal,
                      onChanged: (val){
                        setState(() {
                          userTypeVal = val.toString();
                        });
                      },
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: state.eventTimeController,
                    readOnly: true,
                    onTap: (){
                      bloc.selectEventTime(context);
                    },
                    decoration: const InputDecoration(
                        hintText: "Event Time",
                        suffixIcon: Icon(LineIcons.clock)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: state.eventDateController,
                    readOnly: true,
                    onTap: (){
                      bloc.selectEventDate(context);
                    },
                    decoration: const InputDecoration(
                        hintText: "Event Date",
                      suffixIcon: Icon(Icons.date_range)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const Text("Event is Physical ?",textAlign: TextAlign.start,),
                      Checkbox(value: state.eventOnlineval, onChanged: (v){
                        bloc.assingEventOnlineVal(v!);
                       },
                      ),
                    ],
                  ),
                  state.eventOnlineval! ? TextField(
                    controller: state.eventLocation,
                    onTap: (){
                      nextScreen(context, const EventLocationsSelect());
                    },
                    decoration: const InputDecoration(
                        hintText: "Event Location",
                        suffixIcon: Icon(LineIcons.mapMarker)
                    ),
                  ): Container(),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
