import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';

import '../../../logic/business_product/business_product_cubit.dart';
class AddBullitinBoard extends StatefulWidget {
  const AddBullitinBoard({Key? key}) : super(key: key);

  @override
  State<AddBullitinBoard> createState() => _AddBullitinBoardState();
}

class _AddBullitinBoardState extends State<AddBullitinBoard> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String name = '';
  @override
  Widget build(BuildContext context) {
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bulletin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: form,
          child: Column(
            children: [
              Text("Fill the fields to add bulletin board "),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Board Name"
                ),
                validator: (v){
                  if(v!.isEmpty){
                    return "Board Name is required";
                  }
                },
                onChanged: (v){
                  name = v;
                },
              ),
              SizedBox(height: 20,),
              SecendoryButton(text: "Create Board", onPressed: (){
                if(form.currentState!.validate()){
                  pro.addBulletin(authB.userID!, authB.accesToken!, name);
                  Navigator.pop(context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
