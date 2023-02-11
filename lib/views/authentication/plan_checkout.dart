import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../logic/register/register_cubit.dart';
class PlanCheckout extends StatefulWidget {
  final Map<String,dynamic> data;
  const PlanCheckout({Key? key,required this.data}) : super(key: key);

  @override
  State<PlanCheckout> createState() => _PlanCheckoutState();
}

class _PlanCheckoutState extends State<PlanCheckout> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Checkout",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("Complete your pro membership",style: TextStyle(color: Colors.grey),),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("\$",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(width: 5,),
                      Text("${widget.data['amount']}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                      SizedBox(width: 10,),
                      Text("USD",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.black,)
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(state.errorMessage,style: TextStyle(color: Colors.red),),
            ),
            InkWell(
              onTap: (){
                bloc.stripePaymentSignUp(widget.data['amount'], widget.data['isBusiness'],context,{
                  'card_no':widget.data['card_no'],
                  'expiry_month':widget.data['expiry_month'],
                  'expiry_year': widget.data['expiry_year'],
                  'cvv':widget.data['cvv'],
                  'planId':widget.data['planId']
                });
              },
              child: Center(
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0,-0.2),
                        blurRadius: 3,
                        spreadRadius: 3,
                        color: Colors.black.withOpacity(0.1)
                      )
                    ]
                  ),
                  margin: EdgeInsets.all(20),
                  duration: Duration(milliseconds: 500),
                  height: 50,
                  width: state.loadingState ? 50: getWidth(context),
                  child: Center(child: state.loadingState ? CircularProgressIndicator(color: Colors.white,):Text('Pay now', style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
