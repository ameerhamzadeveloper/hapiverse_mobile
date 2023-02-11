import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../views/plans/business_plan.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
class BusinessProfileAboutInfo extends StatefulWidget {
  bool isMyProfie;
  Map<String, dynamic> data;
  String userId;

  BusinessProfileAboutInfo({Key? key,required this.isMyProfie,required this.userId,required this.data}) : super(key: key);

  @override
  State<BusinessProfileAboutInfo> createState() => _BusinessProfileAboutInfoState();
}

class _BusinessProfileAboutInfoState extends State<BusinessProfileAboutInfo> {
  bool isHoursOpen = false;
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final dd = DateTime.now();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.mapMarker,color: kSecendoryColor,),
                Text("Location")
              ],
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(widget.data['Location'] ?? "",style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 5,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.clock,color: kSecendoryColor,),
                Text("Hours")
              ],
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: widget.isMyProfie ?  ExpansionTile(
                      childrenPadding: EdgeInsets.all(0),
                      expandedAlignment: Alignment.centerLeft,
                      maintainState: true,
                      tilePadding: EdgeInsets.only(left:0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(dd.weekday == 1) ...[
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open Now",style: TextStyle(fontSize: 13,color: Colors.green),):Text("Monday",style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.businessProfile!.businessHours![2].openTime} - Close ${state.businessProfile!.businessHours![2].closeTime} ",style: TextStyle(fontSize: 13),),
                          ]else if(dd.weekday == 2) ... [
                            Text("Tuesday",style: TextStyle(fontSize: 13),),
                            Text("Open ${state.businessProfile!.businessHours![3].openTime} - Close ${state.businessProfile!.businessHours![3].closeTime} ",style: TextStyle(fontSize: 13),),
                          ]else if(dd.weekday == 3) ... [
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open Now",style: TextStyle(fontSize: 13,color: Colors.green),):Text("Wednesday",style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.businessProfile!.businessHours![4].openTime} - Close ${state.businessProfile!.businessHours![4].closeTime} ",style: TextStyle(fontSize: 13),),
                          ]else if(dd.weekday == 4) ... [
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open Now",style: TextStyle(fontSize: 13,color: Colors.green),):Text("Thursday",style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.businessProfile!.businessHours![5].openTime} - Close ${state.businessProfile!.businessHours![5].closeTime} ",style: TextStyle(fontSize: 13),),
                          ]else if(dd.weekday == 5) ... [
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open Now",style: TextStyle(fontSize: 13,color: Colors.green),):Text("Friday",style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.businessProfile!.businessHours![6].openTime} - Close ${state.businessProfile!.businessHours![6].closeTime} ",style: TextStyle(fontSize: 13),),
                          ] else if(dd.weekday == 6) ... [
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open Now",style: TextStyle(fontSize: 13,color: Colors.green),):Text("Saturday",style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.businessProfile!.businessHours![0].openTime} - Close ${state.businessProfile!.businessHours![0].closeTime} ",style: TextStyle(fontSize: 13),),
                          ] else if(dd.weekday == 7) ... [
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open Now",style: TextStyle(fontSize: 13,color: Colors.green),):Text("Sunday",style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.businessProfile!.businessHours![1].openTime} - Close ${state.businessProfile!.businessHours![1].closeTime} ",style: TextStyle(fontSize: 13),),
                          ]
                        ],
                      ),
                      onExpansionChanged: (v){
                        print(dd.weekday);
                      },
                      children: List.generate(state.businessProfile!.businessHours!.length-1, (index){
                        var data = state.businessProfile!.businessHours![index];
                        return  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.day,style: TextStyle(fontSize: 13),),
                            state.businessProfile!.isAlwaysOpen == '1'? Padding(
                              padding: const EdgeInsets.only(right:40.0),
                              child: Text("Open 24 hours"),
                            ):Padding(
                              padding: const EdgeInsets.only(right:40.0),
                              child: data.openTime == "12:00 AM" ? Text("Closed All Day"): Text("Open ${data.openTime} - Close ${data.closeTime}",style: TextStyle(fontSize: 13),),
                            ),
                          ],
                        );
                      }
                      )
                    ):ExpansionTile(
                        childrenPadding: EdgeInsets.all(0),
                        expandedAlignment: Alignment.centerLeft,
                        maintainState: true,
                        tilePadding: EdgeInsets.only(left:0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(dd.weekday == 1) ...[
                              const Text("Monday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![2].openTime} - Close ${state.otherBusinessProfile!.businessHours![2].closeTime} ",style: TextStyle(fontSize: 13),),
                            ]else if(dd.weekday == 2) ... [
                              const Text("Tuesday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![3].openTime} - Close ${state.otherBusinessProfile!.businessHours![3].closeTime} ",style: TextStyle(fontSize: 13),),
                            ]else if(dd.weekday == 3) ... [
                              const Text("Wednesday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![4].openTime} - Close ${state.otherBusinessProfile!.businessHours![4].closeTime} ",style: TextStyle(fontSize: 13),),
                            ]else if(dd.weekday == 4) ... [
                              const Text("Thursday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![5].openTime} - Close ${state.otherBusinessProfile!.businessHours![5].closeTime} ",style: TextStyle(fontSize: 13),),
                            ]else if(dd.weekday == 5) ... [
                              const Text("Friday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![6].openTime} - Close ${state.otherBusinessProfile!.businessHours![6].closeTime} ",style: TextStyle(fontSize: 13),),
                            ] else if(dd.weekday == 6) ... [
                              const Text("Saturday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![0].openTime} - Close ${state.otherBusinessProfile!.businessHours![0].closeTime} ",style: TextStyle(fontSize: 13),),
                            ] else if(dd.weekday == 7) ... [
                              const Text("Sunday",style: TextStyle(fontSize: 13),),
                              state.otherBusinessProfile!.isAlwaysOpen == '1'? Text("Open 24 hours",style: TextStyle(fontSize: 13),):Text("Open ${state.otherBusinessProfile!.businessHours![1].openTime} - Close ${state.otherBusinessProfile!.businessHours![1].closeTime} ",style: TextStyle(fontSize: 13),),
                            ]
                          ],
                        ),
                        onExpansionChanged: (v){
                          print(dd.weekday);
                        },
                        children: List.generate(state.otherBusinessProfile!.businessHours!.length-1, (index){
                          var data = state.otherBusinessProfile!.businessHours![index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data.day,style: TextStyle(fontSize: 13),),
                                state.otherBusinessProfile!.isAlwaysOpen == '1'? Padding(
                                  padding: const EdgeInsets.only(right:40.0),
                                  child: Text("Open 24 hours"),
                                ):Padding(
                                  padding: const EdgeInsets.only(right:40.0),
                                  child: data.openTime == "12:00 AM" ? Text("Closed All Day"):Text("Open ${data.openTime} - Close ${data.closeTime}",style: TextStyle(fontSize: 13),),
                                ),
                              ],
                            );
                        }
                        )
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            // SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.phone,color: kSecendoryColor,),
                Text("Contact")
              ],
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(widget.data['Contact'],style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 5,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.briefcase,color: kSecendoryColor,),
                Text("Category")
              ],
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(widget.data['category'],style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 5,),
          ],
        ),
        widget.isMyProfie ? InkWell(
          onTap: ()=> nextScreen(context, const BusinessPlans()),
          child: Row(
            children: [
              const Icon(LineIcons.arrowCircleUp,color: kSecendoryColor,),
              SizedBox(width: 2,),
              Text(getTranslated(context, 'UPGRAD_MY_PLAN')!)
            ],
          ),
        ):Container(),
      ],
    );
  },
);
  }
}
