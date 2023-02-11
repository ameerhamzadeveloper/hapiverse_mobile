import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/components/secondry_button.dart';
class PayCreditCard extends StatefulWidget {
  String amount;
  String planId;

  PayCreditCard({Key? key,required this.amount,required this.planId}) : super(key: key);
  @override
  _PayCreditCardState createState() => _PayCreditCardState();
}

class _PayCreditCardState extends State<PayCreditCard> {
  String cardName = '';
  String cardNo = '';
  String date = '';
  String cvc = '';
  bool isCvcFocus = false;
  String error = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
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
                child: SecendoryButton(text: "Pay (\$${widget.amount})", onPressed: (){
                  setState(() {
                    error = "";
                  });
                  if(cardName == '' || cardNo == '' || date == '' || cvc == ''){
                    setState(() {
                      error = "Please fill informations";
                    });
                  }else{
                    print(widget.planId);
                    bloc.updatePlan(widget.planId,state.businessProfile!.email!,context);
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
