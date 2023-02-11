import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import 'package:happiverse/views/profile/create_profile.dart';
import 'package:line_icons/line_icons.dart';
import '../../utils/constants.dart';

class ChooseProfileImage extends StatefulWidget {
  const ChooseProfileImage({Key? key}) : super(key: key);

  @override
  State<ChooseProfileImage> createState() => _ChooseProfileImageState();
}

class _ChooseProfileImageState extends State<ChooseProfileImage> {
  String erro = '';
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  state.coverImage == null ? Container(
                    height: getHeight(context) / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: ()=> bloc.getCoverImage(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add Cover Image"),
                            Icon(Icons.camera_alt)
                          ],
                        ),
                      ),
                    ),
                  ):Container(
                    height: getHeight(context) / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                        image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(state.coverImage!))
                        )
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: ()=> bloc.getCoverImage(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Change Cover Image"),
                            Icon(Icons.camera_alt)
                          ],
                        ),
                      ),
                    ),
                  ),
                  state.profileImagePath == null ? Align(
                    alignment: const Alignment(0.0,-0.3),
                    child: Container(
                      height: getWidth(context) / 3,
                      width: getWidth(context) / 4,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                          border: Border.all(color: kScaffoldBgColor,width: 3),
                          // image: const DecorationImage(
                          //     fit: BoxFit.fill,
                          //     image: AssetImage(
                          //         AssetConfig.kLogo
                          //     )
                          // )
                      ),
                    ),
                  ):
                  Align(
                    alignment: const Alignment(0.0,-0.3),
                    child: Container(
                      height: getWidth(context) / 3,
                      width: getWidth(context) / 4,
                      decoration: BoxDecoration(
                          color: kUniversalColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white,width: 3),
                          image:  DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(state.profileImagePath!))
                          )
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0,-0.0),
                    child: Text(state.fullName ??"",style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: getHeight(context),
                    width: getWidth(context),
                    child: Align(
                      alignment: const Alignment(0.4,-0.2),
                      child: IconButton(onPressed: ()=>bloc.getImage(false), icon: Icon(LineIcons.camera,size: 30,color: Colors.black,)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:80.0),
                      child: Text(erro,style: TextStyle(color: Colors.red),),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SecendoryButton(text: "Next",onPressed: (){
                      if(state.profileImagePath == null){
                        setState(() {
                          erro = "Please Select Profile Image";
                        });
                      }else if(state.coverImage == null){
                        setState(() {
                          erro = "Please Select Cover Image";
                        });
                      }else{
                        nextScreen(context, CreateProfile());
                      }
                    },),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
