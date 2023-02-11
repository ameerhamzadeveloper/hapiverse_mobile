import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SponsorAccount extends StatefulWidget {
  const SponsorAccount({Key? key}) : super(key: key);

  @override
  _SponsorAccountState createState() => _SponsorAccountState();
}

class _SponsorAccountState extends State<SponsorAccount> {
  bool isTextCoppied = false;
  bool isGenerate = true;
  String dropDownVal = "User Account";
  String planTypeValBuss = "Local Plan";
  String planTypeValUser = "Gold Plan";
  String randomCode = '';
  String planId = "5";
  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'BCDEFGxcbHIJKLsdfdMNOPhfQRSTUdfdfcvVWXYZ\$%#@!?&1234567890';
    randomCode = List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsor Accounts"),
      ),
      body: UniversalCard(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sponsoring Accounts to increase your sales",style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Text("User Accounts Remaining"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gold Accounts (12)",style: TextStyle(color: Colors.grey),),
                Text("Platinum Accounts (12)",style: TextStyle(color: Colors.grey),)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Diamond Accounts (12)",style: TextStyle(color: Colors.grey),),
                Text("VIP Accounts (12)",style: TextStyle(color: Colors.grey),)
              ],
            ),
            SizedBox(height: 10,),
            Text("Business Accounts"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Local Accounts (12)",style: TextStyle(color: Colors.grey),),
                Text("Regional Accounts (12)",style: TextStyle(color: Colors.grey),)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("National Accounts (12)",style: TextStyle(color: Colors.grey),),
                Text("Global Accounts (12)",style: TextStyle(color: Colors.grey),)
              ],
            ),
            SizedBox(height: 5,),
            Divider(color: Colors.black,),
            isGenerate ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Generate New Account Code"),
                SizedBox(height: 20,),
                Text("Select Account Type",style: TextStyle(color: Colors.grey),),
                DropdownButton<dynamic>(
                  items: [
                    DropdownMenuItem(child: Text("User Account"),value: "User Account",),
                    DropdownMenuItem(child: Text("Business Account"),value: "Business Account",),
                  ],
                  value: dropDownVal,
                  onChanged: (val){
                    setState(() {
                      dropDownVal = val.toString();
                    });
                  },
                  isExpanded: true,
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Plan Type",style: TextStyle(color: Colors.grey),),
                    dropDownVal == "User Account"? DropdownButton<dynamic>(
                      items: const [
                        DropdownMenuItem(child: Text("Gold Plan"),value: "Gold Plan",),
                        DropdownMenuItem(child: Text("Platinum Plan"),value: "Platinum Plan",),
                        DropdownMenuItem(child: Text("Diamond Plan"),value: "Diamond Plan",),
                        DropdownMenuItem(child: Text("VIP Plan"),value: "VIP Plan",),
                      ],
                      value: planTypeValUser,
                      onChanged: (val){
                        if(val.toString() == "Gold Plan"){
                          planId = "5";
                        }else if(val.toString() == "Platinum Plan"){
                          planId = "6";
                        }else if(val.toString() == "Diamond Plan"){
                          planId = "7";
                        }else if(val.toString() == "VIP Plan"){
                          planId = "8";
                        }
                        setState(() {
                          planTypeValUser = val.toString();
                        });
                      },
                      isExpanded: true,
                    ):DropdownButton<dynamic>(
                      items: const [
                        DropdownMenuItem(child: Text("Local Plan"),value: "Local Plan",),
                        DropdownMenuItem(child: Text("Regional Plan"),value: "Regional Plan",),
                        DropdownMenuItem(child: Text("National Plan"),value: "National Plan",),
                        DropdownMenuItem(child: Text("Global Plan"),value: "Global Plan",),
                      ],
                      value: planTypeValBuss,
                      onChanged: (val){
                        if(val.toString() == "Local Plan"){
                          planId = "1";
                        }else if(val.toString() == "Regional Plan"){
                          planId = "2";
                        }else if(val.toString() == "National Plan"){
                          planId = "3";
                        }else if(val.toString() == "Global Plan"){
                          planId = "4";
                        }
                        setState(() {
                          planTypeValBuss = val.toString();
                        });
                      },
                      isExpanded: true,
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
                SizedBox(height: 10,),
                SecendoryButton(text: "Generate", onPressed: (){
                  generateRandomString(12);
                  setState(() {
                    isGenerate = false;
                  });
                  bloc.generateRefferalCode(authB.accesToken!, authB.userID!, dropDownVal == "User Account" ? "1":"2", planId, randomCode);
                })
              ],
            ):Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Share this code with others to create account"),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: randomCode,
                      version: QrVersions.auto,
                      size: 200,
                      // gapless: false,
                      // embeddedImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(80, 80),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(randomCode,style: TextStyle(fontSize: 30,color: Colors.blue),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: randomCode));
                        // setState(() {
                        //   isTextCoppied = true;
                        // });
                        Fluttertoast.showToast(msg: "Coppied To Clipboard");
                      },
                      child: Container(
                        width: getWidth(context) / 4,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.only(top:10,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(isTextCoppied ? "Coppied":"Copy"),
                            Icon(isTextCoppied ? LineIcons.check:LineIcons.copy,size: 20,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: ()=> Share.share(randomCode),
                      child: Container(
                        width: getWidth(context) / 4,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.only(top:10,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Share"),
                            Icon(LineIcons.share,size: 20,)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
