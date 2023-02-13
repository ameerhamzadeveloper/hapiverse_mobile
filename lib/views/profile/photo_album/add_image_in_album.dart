import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/constants.dart';
class AddImageInAlbum extends StatefulWidget {
  final String id;
  final String file;
  const AddImageInAlbum({Key? key,required this.id,required this.file}) : super(key: key);

  @override
  State<AddImageInAlbum> createState() => _AddImageInAlbumState();
}

class _AddImageInAlbumState extends State<AddImageInAlbum> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.file(File(widget.file)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  minWidth: double.infinity,
                  shape: StadiumBorder(),
                  color: Colors.red,
                  onPressed: (){},
                  child: Text("Cancel"),
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  shape: StadiumBorder(),
                  color: kSecendoryColor,
                  onPressed: (){
                    bloc.addImageToAlbum(authB.userID!, authB.accesToken!, widget.file, widget.id,context);
                  },
                  child: Text("Upload Image"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
