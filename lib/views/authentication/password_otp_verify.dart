import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../../views/authentication/sign_up_check.dart';
import 'package:line_icons/line_icons.dart';

import 'create_new_password.dart';
class ForgotPasswordOTP extends StatefulWidget {
  const ForgotPasswordOTP({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOTP> createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String otpCode = "";
  bool isCorrectOTP = true;
  TextEditingController controller = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit,RegisterState>(
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              leading: const BackButton(color: Colors.black,),
              backgroundColor: const Color(0xffEEF1F8),
              title: const Text(
                "OTP Verification",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text("An 4 digit code has been sent to\n${state.email}",textAlign: TextAlign.center,),
                      )
                  ),
                  DraggableScrollableSheet(
                    minChildSize: 0.5,
                    initialChildSize: 0.5,
                    maxChildSize: 0.6,
                    // snap: true,
                    // expand: true,
                    builder: (context, scrollController) => Card(
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          elevation: 3,
                          child: Container(
                            decoration: kContainerDecoration,
                            padding: const EdgeInsets.all(25),
                            child: Form(
                              key: globalKey,
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_upward_sharp)),
                                    Text(state.errorMessage,style: TextStyle(color: Colors.red),),
                                    const SizedBox(
                                      height: 20,
                                    ),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(onPressed: (){
                                      // bloc.verifyEmail(context);
                                    }, child: Text("Resend Code")),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text(error,style: TextStyle(color: Colors.red),),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    state.loadingState ? const Center(child: CircularProgressIndicator(),)
                                        :MaterialButton(
                                      minWidth: 140,
                                      shape: const StadiumBorder(),
                                      onPressed: () {
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
                                          nextScreen(context, CreateNewPassword());
                                        }else{

                                        }
                                      },
                                      color: kSecendoryColor,
                                      child: const Text(
                                        "Verify OTP",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
