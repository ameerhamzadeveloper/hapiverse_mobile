import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../views/authentication/enter_email.dart';

import '../../utils/constants.dart';
import '../components/secondry_button.dart';
import 'otp_verification.dart';
class ReferCode extends StatefulWidget {
  @override
  _ReferCodeState createState() => _ReferCodeState();
}

class _ReferCodeState extends State<ReferCode> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String erro = "";
  bool isButtonPressed = false;
  String code = "";
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
                SizedBox(height: 30,),
                Text("Enter Referal Code",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text("Paste or enter referal code you got from business for sign up",style: TextStyle(color: Colors.grey),),
                SizedBox(height: 40,),
                Container(
                  // height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: TextFormField(
                      onChanged: (va){
                        code = va;
                      },
                      keyboardType: TextInputType.streetAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Refer Code is required";
                        } else{
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Referal Code",
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Text(state.verifyEmailError ?? "",style: TextStyle(color: Colors.red),),
                Padding(
                  padding: const EdgeInsets.only(left:4.0),
                  child: Text(erro,style: TextStyle(color: Colors.red),),
                ),
                SizedBox(height: 20,),
                isButtonPressed ? Center(child: CircularProgressIndicator(),):SecendoryButton(text: "Next", onPressed: (){
                  if(globalKey.currentState!.validate()){
                    bloc.checkRefferalCode(code, context);
                    // nextScreen(context, EnterEmail());
                    // setState(() {
                    //   isButtonPressed = true;
                    // });
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
