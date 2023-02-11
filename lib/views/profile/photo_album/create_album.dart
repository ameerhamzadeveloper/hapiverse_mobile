import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';

import '../../../logic/business_product/business_product_cubit.dart';
import '../../components/secondry_button.dart';
class CreateAlbum extends StatefulWidget {
  const CreateAlbum({Key? key}) : super(key: key);

  @override
  State<CreateAlbum> createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String name = '';
  @override
  Widget build(BuildContext context) {
    final pro = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Album"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("To create album type album name"),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Album Name"
                ),
                validator: (v){
                  if(v!.isEmpty){
                    return "Album Name is required";
                  }
                },
                onChanged: (v){
                  name = v;
                },
              ),
              SizedBox(height: 20,),
              SecendoryButton(text: "Create Album", onPressed: (){
                if(form.currentState!.validate()){
                  pro.createAlbum(authB.userID!, authB.accesToken!, name,context);
                  Navigator.pop(context);
                  // pro.addBulletinNotes(authB.userID!, authB.accesToken!, name,widget.i);
                  // Navigator.pop(context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
