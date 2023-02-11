import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../views/plans/user_plan.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
class ProfileAboutInfo extends StatelessWidget {
  bool isMyProfie;
  Map<String, dynamic> data;
  String userId;

  ProfileAboutInfo({Key? key,required this.isMyProfie,required this.userId,required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.mapMarker,color: kSecendoryColor,),
                Text(getTranslated(context, 'LIVE_IN')!)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['country']  == null ? "" : data['country'], style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.birthdayCake,color: kSecendoryColor,),
                Text(getTranslated(context, 'BIRTH_DATE')!)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['dobFormat'],style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.userFriends,color: kSecendoryColor,),
                Text(getTranslated(context, 'RELATIONSHIP')!)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['replationship'],style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.graduationCap,color: kSecendoryColor,),
                Text("Education")
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(LineIcons.graduationCap),
                      )
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['educationTitle'] ?? "",style: TextStyle(fontSize: 18),),
                      Text("Level : ${data['educationLevel']}",style: TextStyle(fontSize: 14,fontFamily: '',color: Colors.grey),),
                      Text("${data['educationStartDate']} - ${data['currentlyReading'] == '1' ? "Present" : data['educationEndDate']}",style: TextStyle(fontSize: 12,fontFamily: ''),),
                      Text("${data['educationLocation']}",style: TextStyle(fontSize: 14,),),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.briefcase,color: kSecendoryColor,),
                Text("Works At")
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(CupertinoIcons.briefcase_fill),
                      )
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['workTitle'] ?? "",style: TextStyle(fontSize: 18),),
                      Row(
                        children: [
                          Text(data['workDescription'].toString().length > 40 ?  "${data['workDescription'].toString().substring(0,40)}..." :data['workDescription'].toString(),style: TextStyle(fontSize: 14,fontFamily: '',color: Colors.grey),),
                        ],
                      ),
                      Text("${data['workStartDate']} - ${data['currentlyWorking'] == '1' ? "Present" : data['workEndDate']}",style: TextStyle(fontSize: 12,fontFamily: ''),),
                      Text("${data['workLocation']}",style: TextStyle(fontSize: 14,),),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.rulerVertical,color: kSecendoryColor,),
                Text("Height")
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text("${data['height']} ft",style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.starAndCrescent,color: kSecendoryColor,),
                Text("Religion")
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['religion'] ?? "",style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        isMyProfie ? InkWell(
          onTap: ()=>nextScreen(context, UserPlans()),
          child: Row(
            children: [
              const Icon(LineIcons.arrowCircleUp,color: kSecendoryColor,),
              Text(getTranslated(context, 'UPGRAD_MY_PLAN')!)
            ],
          ),
        ):Container(),
      ],
    );
  }
}
