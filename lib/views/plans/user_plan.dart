import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/constants.dart';
import '../../views/components/universal_card.dart';
import '../../views/plans/business_components/global_plan_widget.dart';
import '../../views/plans/business_components/local_plan_widget.dart';
import '../../views/plans/business_components/national_plan_widget.dart';
import '../../views/plans/business_components/regional_plan_widget.dart';
import '../../views/plans/plans_checkout.dart';
import '../../views/plans/user_components/diamond_plan_widget.dart';
import '../../views/plans/user_components/gold_plan_widget.dart';
import '../../views/plans/user_components/platinum_plan_widget.dart';
import '../../views/plans/user_components/vip_plan_widget.dart';

import '../../utils/utils.dart';

class UserPlans extends StatefulWidget {
  const UserPlans({Key? key}) : super(key: key);

  @override
  _UserPlansState createState() => _UserPlansState();
}

class _UserPlansState extends State<UserPlans> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Upgrade Hapiverse"),
          ),
          body: UniversalCard(
            widget: Column(
              children: [
                Row(
                  children: [
                    Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Choose your subscription plan",style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                CarouselSlider(
                  items: [
                    // GoldUserPlanWidget(button: ()=>nextScreen(context, PlansCheckOut(amount: '0',))),
                    PlatinumPlanWidget(button: ()=>nextScreen(context, PlansCheckOut(amount: '9.99',planId: '6',))),
                    DiamondUserPlanWidget(button: ()=>nextScreen(context, PlansCheckOut(amount: '29.99',planId: '7',))),
                    VipUserPlanWidget(button: ()=>nextScreen(context, PlansCheckOut(amount: '49.99',planId: '8',))),
                  ], options: CarouselOptions(
                    height: 400.0,aspectRatio: 16/9,
                    viewportFraction: 1.0,onPageChanged: (i,v){
                  setState(() {
                    currentIndex = i;
                  });
                },pauseAutoPlayOnTouch: true),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,size: currentIndex == 0 ? 15 : 10,color: currentIndex == 0 ? Colors.black : Colors.grey,),
                    SizedBox(width: 5,),
                    Icon(Icons.circle,size: currentIndex == 1 ? 15 : 10,color: currentIndex == 1 ? Colors.black :Colors.grey,),
                    SizedBox(width: 5,),
                    Icon(Icons.circle,size: currentIndex == 2 ? 15 : 10,color: currentIndex == 2 ? Colors.black :Colors.grey,),
                    SizedBox(width: 5,),
                    Icon(Icons.circle,size: currentIndex == 3 ? 15 : 10,color: currentIndex == 3 ? Colors.black :Colors.grey,),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
