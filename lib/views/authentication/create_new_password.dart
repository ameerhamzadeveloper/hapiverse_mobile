import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../../views/authentication/sign_up_check.dart';
import 'package:line_icons/line_icons.dart';
class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
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
                "Create New Password",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
              child: Stack(
                children: [
                 const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text("Your new password must be diffirent from a perviously used password",textAlign: TextAlign.center,),
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
                                      // obscureText: true,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return "Please Enter New Password";
                                        }else if(val.length < 6){
                                          return "Password must be 6 characters";
                                        }else{
                                          return null;
                                        }
                                      },
                                      onChanged: (val){
                                        context.read<RegisterCubit>().assignPassword(val);
                                      },
                                      cursorColor: kUniversalColor,
                                      decoration: const InputDecoration(
                                        labelText: "New Password",
                                        suffixIcon: Icon(LineIcons.lock),
                                      ),
                                    ),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      // obscureText: true,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return "Please Enter Repeat Password";
                                        }else if(val != state.password){
                                          return "Repeat Password must be match";
                                        }else{
                                          return null;
                                        }
                                      },
                                      onChanged: (val){
                                        // context.read<RegisterCubit>().assignPassword(val);
                                      },
                                      cursorColor: kUniversalColor,
                                      decoration: const InputDecoration(
                                        labelText: "Repeat Password",
                                        suffixIcon: Icon(LineIcons.lock),
                                      ),
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
                                          // context.read<RegisterCubit>().loginUser(context);
                                          print("called");
                                        }else{
                                          print("sdfsdf");
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
