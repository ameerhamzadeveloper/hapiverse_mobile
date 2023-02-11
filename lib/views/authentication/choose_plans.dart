import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/data/model/business_profile_model.dart';
import 'package:happiverse/views/authentication/business_profile.dart';
import 'package:happiverse/views/authentication/payment.dart';
import 'package:happiverse/views/profile/create_profile.dart';
import '../../logic/register/register_cubit.dart';
import '../../views/authentication/sign_up_business.dart';
import '../../views/authentication/sign_up_user.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import '../plans/business_components/global_plan_widget.dart';
import '../plans/business_components/local_plan_widget.dart';
import '../plans/business_components/national_plan_widget.dart';
import '../plans/business_components/regional_plan_widget.dart';
import '../plans/plans_checkout.dart';
import '../plans/user_components/diamond_plan_widget.dart';
import '../plans/user_components/gold_plan_widget.dart';
import '../plans/user_components/platinum_plan_widget.dart';
import '../plans/user_components/vip_plan_widget.dart';
class ChoosePlans extends StatefulWidget {
  @override
  _ChoosePlansState createState() => _ChoosePlansState();
}

class _ChoosePlansState extends State<ChoosePlans> {
  bool isBusiness = false;
  int currentIndex = 0;
  isBusinessClicked(){
    setState(() {
      isBusiness = !isBusiness;
    });
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Choose Plan"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=>isBusinessClicked(),
                  child: Row(
                    children: [
                      Icon(isBusiness == false ? LineIcons.dotCircle : LineIcons.circle),
                      const Text("Individual")
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                InkWell(
                  onTap: ()=>isBusinessClicked(),
                  child: Row(
                    children: [
                      Icon(isBusiness ? LineIcons.dotCircle : LineIcons.circle),
                      const Text("Business")
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Choose your subscription plan",style: TextStyle(fontSize: 20),),
            const SizedBox(height: 20,),
            isBusiness ? Column(
              children: [
                CarouselSlider(
                  items: [
                    LocalBusinessPlanWidget(button: (){
                      bloc.isBusinessClicked(true);
                      nextScreen(context,SignUpPayment(amount: '500',isBusiness: true,planID: '1',));
                    }),
                    RegionalBusinessPlanWidget(button: () {
                      // SignUpPayment(amount: '200000',isBusiness: true,);
                      bloc.isBusinessClicked(true);
                      // bloc.addUserPlanSignUp("2");
                      // nextScreen(context, SignUpBusiness());
                      nextScreen(context,SignUpPayment(amount: '2000',isBusiness: true,planID: '2',));
                    }),
                    NationalBusinessPlanWidget(button: () {
                      bloc.isBusinessClicked(true);
                      // bloc.addUserPlanSignUp("3");
                      // nextScreen(context, SignUpBusiness());
                      nextScreen(context,SignUpPayment(amount: '10000',isBusiness: true,planID: '3',));
                    }),
                    GlobalBusinessPlanWidget(button: () {
                      bloc.isBusinessClicked(true);
                      // bloc.addUserPlanSignUp("4");
                      // nextScreen(context, SignUpBusiness());
                      nextScreen(context,SignUpPayment(amount: '30000',isBusiness: true,planID: '4',));
                    }),
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
            ):
            Column(
              children: [
                CarouselSlider(
                  items: [
                    // GoldUserPlanWidget(button: ()=>nextScreen(context, PlansCheckOut())),
                    PlatinumPlanWidget(button: (){
                      bloc.isBusinessClicked(false);
                      // bloc.addUserPlanSignUp("6");
                      // nextScreen(context, SignUpUser());
                      nextScreen(context, SignUpPayment(amount: '9.99',isBusiness: false,planID: '6',));
                      // nextScreen(context, SignUpUser());
                    }),
                    DiamondUserPlanWidget(button: () {
                      bloc.isBusinessClicked(false);
                      // bloc.addUserPlanSignUp("29.99");
                      nextScreen(context,SignUpPayment(amount: '29.99',isBusiness: false,planID: '7',));
                    }),
                    VipUserPlanWidget(button: () {
                      bloc.isBusinessClicked(false);
                      // bloc.addUserPlanSignUp("79.99");
                      nextScreen(context,SignUpPayment(amount: '49.99',isBusiness: false,planID: '8',));
                    }),
                  ], options: CarouselOptions(
                    autoPlay: true,
                    height: 500.0,aspectRatio: 16/9,
                    viewportFraction: 1.0,onPageChanged: (i,v){
                  setState(() {
                    currentIndex = i;
                  });
                },pauseAutoPlayOnTouch: true),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,size: currentIndex == 0 ? 15 : 10,color: currentIndex == 0 ? Colors.black : Colors.grey,),
                    const SizedBox(width: 5,),
                    Icon(Icons.circle,size: currentIndex == 1 ? 15 : 10,color: currentIndex == 1 ? Colors.black :Colors.grey,),
                    const SizedBox(width: 5,),
                    Icon(Icons.circle,size: currentIndex == 2 ? 15 : 10,color: currentIndex == 2 ? Colors.black :Colors.grey,),
                    // SizedBox(width: 5,),
                    // Icon(Icons.circle,size: currentIndex == 3 ? 15 : 10,color: currentIndex == 3 ? Colors.black :Colors.grey,),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
