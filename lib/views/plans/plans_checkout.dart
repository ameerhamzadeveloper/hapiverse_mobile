import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/plans/upgrade_checkout.dart';
import '../../utils/constants.dart';
import '../../views/components/secondry_button.dart';

class PlansCheckOut extends StatefulWidget {
  final String planId;
  final String amount;
  const PlansCheckOut({Key? key,required this.planId,required this.amount}) : super(key: key);
  @override
  _PlansCheckOutState createState() => _PlansCheckOutState();
}

class _PlansCheckOutState extends State<PlansCheckOut> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBgColor,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text("Paymnet Methods",style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            state.card == null ? Center(child: Text("No Card")):
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c,i){
                var d = state.card!.data[i];
                return ListTile(
                  onTap: (){
                    nextScreen(context, PlanCheckoutUpgrade(
                        data: {
                          'card_no':d['cardNumber'],
                          'expiry_month':d['expiryMonth'],
                          'expiry_year': d['expiryYear']!.substring(2,4),
                          'cvv':d['cvc'],
                          'amount':widget.amount,
                          'planId':widget.planId
                        }
                    ));
                  },
                  leading: Icon(Icons.credit_card),
                  subtitle: Text(d['cardNumber'] ?? ""),
                  title: Text(d['cardHolderName'] ?? ""),
                  trailing: Radio(
                    groupValue: 1,
                    value: false,
                    onChanged: (v){

                    },
                  ),
                );
              },
              itemCount: state.card!.data.length,
            ),
            // Spacer(),
            // SecendoryButton(text: "Add New Card", onPressed: (){
            //   // if(_payMentMethod == PayMentMethod.creditCard){
            //   //   // nextScreen(context, PayCreditCard());
            //   // }
            // }),
            // SizedBox(height: 20,)
          ],
        ),
      ),
    );
  },
);
  }
}
