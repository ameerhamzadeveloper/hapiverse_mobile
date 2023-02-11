import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class LocalBusinessPlanWidget extends StatelessWidget {
  final VoidCallback button;
  const LocalBusinessPlanWidget({Key? key,required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.red.withOpacity(0.8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("Local Business Plan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("\$500/Month",style: TextStyle(fontSize: 17,color: Colors.white,fontFamily: ""),),
            SizedBox(height: 20,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle,size: 10,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Sponsor 50 basic accounts paid individual plans activated",style: TextStyle(color: Colors.white),)),
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
              children: [
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
