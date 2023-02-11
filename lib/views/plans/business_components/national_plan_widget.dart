import 'package:flutter/material.dart';
import '../../../utils/config/assets_config.dart';

import '../../../utils/constants.dart';
class NationalBusinessPlanWidget extends StatelessWidget {
  final VoidCallback button;
  const NationalBusinessPlanWidget({Key? key,required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: kSecendoryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("National Business Plan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("\$10,000/Month",style: TextStyle(fontSize: 17,color: Colors.white,fontFamily: ""),),
            SizedBox(height: 20,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Sponsor 20 gold, and 5 Platinum user plans",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Rewards Center",style: TextStyle(color: Colors.white),)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("One regional business plan",style: TextStyle(color: Colors.white),)),
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
                Expanded(child: Text("Artificial Intelligence",style: TextStyle(color: Colors.white),)),
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
