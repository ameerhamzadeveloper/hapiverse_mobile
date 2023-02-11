import 'package:flutter/material.dart';
import '../../../views/components/universal_card.dart';
class CustomerRewards extends StatefulWidget {
  const CustomerRewards({Key? key}) : super(key: key);

  @override
  _CustomerRewardsState createState() => _CustomerRewardsState();
}

class _CustomerRewardsState extends State<CustomerRewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Rewards"),
      ),
      body: UniversalCard(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Give rewards to your recent customers"),
            SizedBox(height: 50,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Recents Customers",style: TextStyle(fontSize: 25,color: Colors.grey,),textAlign: TextAlign.center,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
