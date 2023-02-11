import 'package:flutter/material.dart';
import '../../../views/business_tools/reward_center/customer_rewards.dart';
import '../../../views/business_tools/reward_center/sponsor_accounts.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';
class RewardCenter extends StatefulWidget {
  const RewardCenter({Key? key}) : super(key: key);

  @override
  _RewardCenterState createState() => _RewardCenterState();
}

class _RewardCenterState extends State<RewardCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reward Center"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            ListTile(
              onTap: ()=> nextScreen(context, SponsorAccount()),
              leading: Container(
                width: 70,
                // height: 100,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Icon(LineIcons.userCircle,color: Colors.blue,),
                ),
              ),
              title: const Text("Sponsor Accounts"),
              subtitle: const Text("Sponsor others for customer and business accounts"),
              dense:true,
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: ()=> nextScreen(context, CustomerRewards()),
              leading: Container(
                width: 70,
                // height: 100,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Icon(LineIcons.gifts,color: Colors.orangeAccent,),
                ),
              ),
              title: const Text("Customer Rewards"),
              subtitle: const Text("Give rewards to your recent customers to get their retentions"),
              dense:true,
            ),
          ],
        ),
      ),
    );
  }
}
