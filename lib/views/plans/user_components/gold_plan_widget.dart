import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class GoldUserPlanWidget extends StatelessWidget {
  final VoidCallback button;
  const GoldUserPlanWidget({Key? key,required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("Basic Gold Plan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("free",style: TextStyle(fontSize: 17,color: Colors.white,fontFamily: ""),),
            SizedBox(height: 20,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Location Based Info's",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Public & Private Groups",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Push Notificaions Alerts",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Covid-19 tracking-local tracking",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Multi Language",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Matching Algorithem",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Video Audio Voice Text Chat",style: TextStyle(color: Colors.white),)),
              ],
            ),
            Spacer(),
            MaterialButton(
              minWidth: getWidth(context) / 2,
              shape: StadiumBorder(),
              color: Colors.white,
              onPressed: button,
              child: Text("Buy Now"),
            )
          ],
        ),
      ),
    );
  }
}
