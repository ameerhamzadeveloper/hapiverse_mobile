import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/authentication/password_otp_verify.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../../views/authentication/sign_up_check.dart';
import 'package:line_icons/line_icons.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
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
                "Forgot Password",
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
                      child: Text("Enter your registerd email address to receive password reset OTP code",textAlign: TextAlign.center,),
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
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val){
                                        context.read<RegisterCubit>().assignEmail(val);
                                      },
                                      validator: (val){
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
                                      decoration: const InputDecoration(
                                          labelText: 'Email Address',
                                          // hintText: "Email Address",
                                          suffixIcon: Icon(LineIcons.envelope)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    state.loadingState ? const Center(child: CircularProgressIndicator(),)
                                        :MaterialButton(
                                      minWidth: 140,
                                      shape: const StadiumBorder(),
                                      onPressed: () {
                                        if(globalKey.currentState!.validate()){
                                          nextScreen(context, ForgotPasswordOTP());
                                        }
                                      },
                                      color: kSecendoryColor,
                                      child: const Text(
                                        "Reset Password",
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
