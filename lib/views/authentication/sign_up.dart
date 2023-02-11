import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().getCountryCityName();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text("Sign Up"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: kContainerDecoration,
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=>bloc.isBusinessClicked(false),
                          child: Row(
                            children: [
                              Icon(state.isBusiness == false ? LineIcons.dotCircle : LineIcons.circle),
                              Text("Individual")
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: ()=>bloc.isBusinessClicked(true),
                          child: Row(
                            children: [
                              Icon(state.isBusiness ? LineIcons.dotCircle : LineIcons.circle),
                              Text("Business")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(state.errorMessage,style: const TextStyle(color: Colors.red),),
                    const SizedBox(
                      height: 20,
                    ),

                    // user side UI
                    state.isBusiness == false ? Column(
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
                          validator: (val) {
                            if (val != state.password) {
                              return "Password is required";
                            }else if(val!.length < 6){
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
                            }else if(val!.length < 6){
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
                    ):
                    // business side UI

                    Column(
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
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                          decoration: const InputDecoration(
                            labelText: "Business Email",
                            suffixIcon: Icon(LineIcons.envelope),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
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
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return "Business Name is required";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          onChanged: (val) {
                            bloc.assignVat(val);
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: "Vat Number",
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
                            }else if(val!.length < 6){
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
                            }else if(val!.length < 6){
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
                    state.loadingState ? const Center(child: CircularProgressIndicator(),)
                        :MaterialButton(
                      minWidth: 140,
                      shape: const StadiumBorder(),
                      onPressed: () {
                        print(state.password);
                        if (globalKey.currentState!.validate()) {
                          // context.read<RegisterCubit>().registerUser(context);
                          Navigator.pushNamed(context, catInterest);
                        }
                      },
                      color: kSecendoryColor,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              primary: kUniversalColor,
                            ),
                            onPressed: () => Navigator.pushNamed(context, signin),
                            child: const Text("Sign in"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
