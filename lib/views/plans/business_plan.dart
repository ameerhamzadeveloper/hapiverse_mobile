import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/plans/pay_credit_card.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/constants.dart';
import '../../views/components/universal_card.dart';
import '../../views/plans/business_components/global_plan_widget.dart';
import '../../views/plans/business_components/local_plan_widget.dart';
import '../../views/plans/business_components/national_plan_widget.dart';
import '../../views/plans/business_components/regional_plan_widget.dart';
import '../../views/plans/plans_checkout.dart';

import '../../utils/utils.dart';

class BusinessPlans extends StatefulWidget {
  const BusinessPlans({Key? key}) : super(key: key);

  @override
  _BusinessPlansState createState() => _BusinessPlansState();
}

class _BusinessPlansState extends State<BusinessPlans> {
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
                        backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.businessProfile!.logoImageUrl}"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text("Choose your subscription plan",style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                CarouselSlider(
                  items: [
                    LocalBusinessPlanWidget(button: ()=>nextScreen(context, PayCreditCard(planId: '1',amount: '500',))),
                    RegionalBusinessPlanWidget(button: ()=>nextScreen(context, PayCreditCard(planId: '2',amount: '2000',))),
                    NationalBusinessPlanWidget(button: ()=>nextScreen(context, PayCreditCard(planId: '3',amount: '10000',))),
                    GlobalBusinessPlanWidget(button: ()=>nextScreen(context, PayCreditCard(planId: '4',amount: '30000',))),
                ], options: CarouselOptions(
                  height: 400.0,autoPlay: true,aspectRatio: 16/9,
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
