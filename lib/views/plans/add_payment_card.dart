import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/authentication/plan_checkout.dart';

import '../components/secondry_button.dart';
class AddCardUpgradePlan extends StatefulWidget {
  final String amount;
  final String planID;
  const AddCardUpgradePlan({Key? key,required this.amount,required this.planID}) : super(key: key);

  @override
  State<AddCardUpgradePlan> createState() => _AddCardUpgradePlanState();
}

class _AddCardUpgradePlanState extends State<AddCardUpgradePlan> {
  String cardName = '';
  String cardNo = '';
  String date = '';
  String cvc = '';
  bool isCvcFocus = false;
  String error = '';
  String expiryDate = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Add Credit/Debit Card"),
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: cardNo,
                expiryDate: date,
                cardHolderName: cardName,
                cvvCode: cvc,
                showBackView: isCvcFocus,
                onCreditCardWidgetChange: (v){
                },
                isChipVisible: true,
                labelCardHolder: "XXXX XXXXXXX",
                glassmorphismConfig: Glassmorphism(
                  blurX: 10.0,
                  blurY: 10.0,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.grey.withAlpha(20),
                      Colors.white.withAlpha(20),
                    ],
                    stops: const <double>[
                      0.3,
                      0,
                    ],
                  ),
                ),
              ),
              CreditCardForm(
                cursorColor: Colors.white,
                textColor: Colors.white,
                cardHolderName: cardName,
                cardNumber: cardNo,
                cvvCode: cvc,
                expiryDate: date,
                formKey: formkey, // Required
                onCreditCardModelChange: (CreditCardModel data) {
                  print(data.cardHolderName);
                  setState(() {
                    cardName = data.cardHolderName;
                    cardNo = data.cardNumber;
                    cvc = data.cvvCode;
                    date = data.expiryDate;
                    isCvcFocus = data.isCvvFocused;
                    expiryDate = data.expiryDate;
                  });
                  print(cardName);
                }, // Required
                themeColor: Colors.red,
                obscureCvv: true,
                obscureNumber: false,
                // isHolderNameVisible: false,
                // isCardNumberVisible: false,
                // isExpiryDateVisible: false,
                cardNumberDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                onFormComplete: (CreditCardModel data){
                  print(data.cardHolderName);
                  setState(() {
                    cardName = data.cardHolderName;
                    cardNo = data.cardNumber;
                    cvc = data.cvvCode;
                    date = data.expiryDate;
                    isCvcFocus = data.isCvvFocused;
                    expiryDate = data.expiryDate;
                  });
                  print(cardName);
                },
                expiryDateDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                    hintText: "XXXX XXXXXXX"
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(error,style: TextStyle(color: Colors.red),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SecendoryButton(text: "Pay", onPressed: (){
                  setState(() {
                    error = "";
                  });
                  print(expiryDate);
                  print(cardNo);
                  print(cardName);
                  print(cvc);
                  if(cardName == '' || cardNo == '' || date == '' || cvc == '' || expiryDate == ''){
                    setState(() {
                      error = "Please fill informations";
                    });
                  }else{
                    print("mont ${expiryDate.substring(0,2)}");
                    print("year ${expiryDate.substring(3,5)}");
                    print(cardNo);
                    print(cardName);
                    print(cvc);
                    nextScreen(context, PlanCheckout(data: {
                      'card_no':cardNo,
                      'expiry_month':expiryDate.substring(0,2),
                      'expiry_year': expiryDate.substring(3,5),
                      'cvv':cvc,
                      'amount':widget.amount,
                      'planId':widget.planID
                    }));
                    // bloc.stripePaymentSignUp(widget.amount, widget.isBusiness,context,{
                    //   'card_no':cardNo,
                    //   'expiry_month':expiryDate.substring(0,2),
                    //   'expiry_year': expiryDate.substring(3,5),
                    //   'cvv':cvc,
                    // });
                  }

                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
