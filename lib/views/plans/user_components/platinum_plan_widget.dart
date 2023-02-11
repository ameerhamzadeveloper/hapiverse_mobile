import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class PlatinumPlanWidget extends StatelessWidget {
  final VoidCallback button;
  const PlatinumPlanWidget({Key? key,required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.green,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("Platinum Plan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("\$9.99/Month",style: TextStyle(fontSize: 17,color: Colors.white,fontFamily: ""),),
            SizedBox(height: 20,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Location Based Info's",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 6,),
            Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Public & Private Groups",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Push Notificaions Alerts",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Covid-19 tracking-local tracking",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Multi Language",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Matching Algorithem",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 6,),
                Expanded(child: Text("Video Audio Voice Text Chat",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Profile Avatar",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Rate / Review",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Customer Loyalty Program",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            Spacer(),
            MaterialButton(
              minWidth: getWidth(context) / 2,
              shape: StadiumBorder(),
              color: Colors.white,
              onPressed: button,
              child: Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}
