import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../views/components/secondry_button.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';

class SignUpUser extends StatefulWidget {
  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text("Sign up"),
          ),
          body: UniversalCard(
            widget: Form(
              key: globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            bloc.assignName(val);
                          },
                          decoration: const InputDecoration(
                              labelText: "Full Name",
                              suffixIcon: Icon(LineIcons.user)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: TextEditingController(text: state.email),
                          cursorColor: kUniversalColor,
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
                          onChanged: (val) {
                            bloc.assignEmail(val);
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email Address",
                            suffixIcon: Icon(LineIcons.envelope),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: kUniversalColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Phone is required";
                            }  else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            bloc.assignPhoneNo(val);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Phone No",
                            hintText: "+x xxx xxx xxxx",
                            suffixIcon: Icon(LineIcons.phone),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val != state.password) {
                              return "Password is required";
                            } else if (val!.length < 6) {
                              return "Password Must be 6 character";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            bloc.assignPassword(val);
                          },
                          decoration: const InputDecoration(
                              labelText: "Password",
                              suffixIcon: Icon(LineIcons.lock)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: kUniversalColor,
                          decoration: const InputDecoration(
                            labelText: "Confirm Password",
                            suffixIcon: Icon(LineIcons.lock),
                          ),
                          validator: (val) {
                            if (val != state.password) {
                              return "Confirm Password Must Match";
                            } else if (val!.length < 6) {
                              return "Password Must be 6 character";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SecendoryButton(text: "Next", onPressed: (){
                          if (globalKey.currentState!.validate()) {
                            // context.read<RegisterCubit>().registerUser(context);
                            Navigator.pushNamed(context, catInterest);
                          }
                        })
                      ],
                    )
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
