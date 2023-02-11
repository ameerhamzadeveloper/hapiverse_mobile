import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../views/authentication/choose_plans.dart';
import '../../views/authentication/sign_up_business.dart';
import '../../views/authentication/sign_up_user.dart';
import '../../views/components/secondry_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({Key? key}) : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  String otpCode = "";
  bool isCorrectOTP = true;
  TextEditingController controller = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
                Image.network("https://otp.dev/static/why-image.png"),
                SizedBox(height: 30,),
                Text("Enter OTP",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Text("An 4 digit code has been sent to\n${state.email}",style: TextStyle(),),
                SizedBox(height: 40,),
                PinCodeTextField(
                  controller: controller,
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  hintCharacter: "#",
                  animationType: AnimationType.fade,
                  validator: (v) {

                  },
                  pinTheme: PinTheme(
                    inactiveColor: kUniversalColor,
                    inactiveFillColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: kUniversalColor,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    fieldOuterPadding: EdgeInsets.all(6)
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: TextStyle(fontSize: 20, height: 1.6),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                ),
                TextButton(onPressed: (){
                  bloc.verifyEmail(context);
                }, child: Text("Resend Code")),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(error,style: TextStyle(color: Colors.red),),
                ),
                SizedBox(height: 30,),
                SecendoryButton(text: "Next", onPressed: (){
                  setState(() {
                    error = "";
                  });
                  if(otpCode.length < 4){
                    setState(() {
                      error = "OTP is required";
                    });
                  }else if(state.verifyCode != otpCode){
                    setState(() {
                      error = "Incorrect OTP!";
                    });
                  }else{
                    print(state.supponsorAccountType);
                    if(state.supponsorAccountType == "1"){
                      nextScreen(context, SignUpUser());
                    }else if(state.supponsorAccountType == "2"){
                      nextScreen(context, SignUpBusiness());
                    }else{
                      nextScreen(context, ChoosePlans());
                    }
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
