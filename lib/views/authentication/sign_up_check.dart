import 'package:flutter/material.dart';
import '../../views/authentication/enter_email.dart';
import '../../views/authentication/refer_code.dart';
import '../../views/places.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
class SignUpCheck extends StatefulWidget {
  @override
  _SignUpCheckState createState() => _SignUpCheckState();
}

class _SignUpCheckState extends State<SignUpCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Choose sign up method",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            // MaterialButton(onPressed: ()=> nextScreen(context, Placesss()),child: Text("Teest Call"),),
            InkWell(
              onTap: ()=> nextScreen(context, EnterEmail()),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(LineIcons.userShield),
                        ),
                      ),
                      ListTile(
                        title: Text("Premium Sign up"),
                        subtitle: Text("Sign up with premium plan's Account"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: ()=> nextScreen(context, ReferCode()),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(LineIcons.userTag),
                        ),
                      ),
                      ListTile(
                        title: Text("Refer Code"),
                        subtitle: Text("Enter refer code you got from business for sign up"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
