import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/authentication/otp_verification.dart';
import '../../views/components/secondry_button.dart';
class EnterEmail extends StatefulWidget {
  @override
  _EnterEmailState createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))
                    ],
                  ),
                  Image.network("https://i.gifer.com/QHTn.gif"),
                  SizedBox(height: 30,),
                  Text("Enter Your Email",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Text("We will send OTP verification code you will enter below",style: TextStyle(color: Colors.grey),),
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
                        onChanged: (v){
                          bloc.assignEmail(v);
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Email is required";
                          } else if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(val)) {
                            return 'Please enter a valid email Address';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  Text(state.errorMessage,style: TextStyle(color: Colors.red),),
                  SizedBox(height: 10,),
                  state.loadingState ? Center(child: CircularProgressIndicator()):SecendoryButton(text: "Next", onPressed: (){
                    if(globalKey.currentState!.validate()){
                      bloc.verifyEmail(context);
                      // nextScreen(context, const OTPVerification());
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
