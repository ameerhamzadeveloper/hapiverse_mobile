import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../views/components/secondry_button.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';

class SignUpBusiness extends StatefulWidget {
  @override
  _SignUpBusinessState createState() => _SignUpBusinessState();
}

class _SignUpBusinessState extends State<SignUpBusiness> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text("Business Sign up"),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Business Name is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            bloc.assignName(val);
                          },
                          decoration: const InputDecoration(
                              labelText: "Business Name",
                              suffixIcon: Icon(LineIcons.user)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // TextFormField(
                        //   keyboardType: TextInputType.emailAddress,
                        //   cursorColor: kUniversalColor,
                        //   validator: (val) {
                        //     if (val!.isEmpty) {
                        //       return "Email is required";
                        //     } else if (!RegExp(
                        //         r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        //         .hasMatch(val)) {
                        //       return 'Please enter a valid email Address';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   onChanged: (val) {
                        //     bloc.assignEmail(val);
                        //   },
                        //   decoration: const InputDecoration(
                        //     labelText: "Business Email",
                        //     suffixIcon: Icon(LineIcons.envelope),
                        //   ),
                        // ),

                        // const SizedBox(
                        //   height: 20,
                        // ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Owner Name is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            bloc.assignOwnerName(val);
                          },
                          decoration: const InputDecoration(
                              labelText: "Owner Name",
                              suffixIcon: Icon(LineIcons.user)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Vat is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            bloc.assignVat(val);
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Vat Number (Optional)",
                            // suffixIcon: Icon(LineIcons.user),
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
                      ],
                    ),
                  ),
                  SecendoryButton(text: "Next", onPressed: (){
                    if (globalKey.currentState!.validate()) {
                      // context.read<RegisterCubit>().registerUser(context);
                      Navigator.pushNamed(context, catInterest);
                    }
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
