import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/components/secondry_button.dart';
import 'package:line_icons/line_icons.dart';
import '../../../utils/utils.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({Key? key}) : super(key: key);

  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  bool isLocalProfileEdited = false;
  bool isBorderEnabled = false;
  Color selectedflatColor = Colors.red;
  Color gredientColor1 = Colors.red;
  Color gredientColor2 = Colors.orange;
  Color? pickFlatTempcolor;
  Color? pickGredTemColor1;
  Color? pickGredTemColor2;
  bool isGredient = false;

  getColors(int i){
    switch(i){
      case 1:
        return Colors.blue;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.deepOrangeAccent;
      case 4:
        return Colors.green;
      case 5:
        return Colors.yellowAccent;
    }
  }

  List<ColorsPicModel> colorsList = [
    ColorsPicModel(color: Colors.blue, isSelected: false),
    ColorsPicModel(color: Colors.pink, isSelected: false),
    ColorsPicModel(color: Colors.red, isSelected: false),
    ColorsPicModel(color: Colors.green, isSelected: false),
    ColorsPicModel(color: Colors.yellow, isSelected: false),
  ];

  List<ColorsPicModel> gredientFirstList = [
    ColorsPicModel(color: Colors.blue, isSelected: false),
    ColorsPicModel(color: Colors.pink, isSelected: false),
    ColorsPicModel(color: Colors.red, isSelected: false),
    ColorsPicModel(color: Colors.green, isSelected: false),
    ColorsPicModel(color: Colors.yellow, isSelected: false),
  ];

  List<ColorsPicModel> gredientSecList = [
    ColorsPicModel(color: Colors.blue, isSelected: false),
    ColorsPicModel(color: Colors.pink, isSelected: false),
    ColorsPicModel(color: Colors.red, isSelected: false),
    ColorsPicModel(color: Colors.green, isSelected: false),
    ColorsPicModel(color: Colors.yellow, isSelected: false),
  ];

  bool isTextActive = false;
  String textValue = "";
  bool isTextOkButtonClic = false;

  showFlatColorDialouge(){
    showDialog(
        context: context, builder:(ctx){
      return StatefulBuilder(
        builder: (context,setStatee) {
          return AlertDialog(
            content: Container(
              height: getHeight(context) / 4,
              child: Column(
                children: [
                  Text("Chose Flat Color"),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Pick first Color",style: TextStyle(fontSize: 10,color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(colorsList.length, (i){
                          return InkWell(
                            onTap:(){
                              for(var ii =0;ii < colorsList.length;ii++){
                                setStatee((){
                                  colorsList[ii].isSelected = false;
                                  isGredient = false;
                                  // print(colorsList[ii].isSelected);
                                });
                                // print(colorsList[ii].isSelected);
                              }
                              colorsList[i].isSelected = true;
                              pickFlatTempcolor = colorsList[i].color;
                              print(colorsList[0].isSelected);
                              print(colorsList[1].isSelected);
                              print(colorsList[2].isSelected);
                              print(colorsList[3].isSelected);
                              print(colorsList[4].isSelected);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              color: colorsList[i].color,
                              child: colorsList[i].isSelected ? Icon(Icons.check):Container(),
                            ),
                          );
                        })
                    ),
                  ),
                  SizedBox(height: 30,),
                  MaterialButton(
                    minWidth: getWidth(context),
                    color: kSecendoryColor,
                    onPressed: (){
                      if(pickFlatTempcolor != null){
                        setState(() {
                          isGredient = false;
                          selectedflatColor = pickFlatTempcolor!;
                        });
                        Navigator.pop(context);
                      }else{
                        Fluttertoast.showToast(msg: "Please Pick Colors");
                      }
                    },
                    child: Text("Done"),
                  )
                ],
              ),
            ),
          );
        }
      );
    });
  }

  showGredientColorGialouge(){
    showDialog(
        context: context, builder:(ctx){
      return StatefulBuilder(
        builder: (context,setStatee) {
          return AlertDialog(
            content: Container(
              height: getHeight(context) / 3,
              child: Column(
                children: [
                  Text("Chose Gredient Color"),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Pick first Color",style: TextStyle(fontSize: 10,color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(gredientFirstList.length, (i){
                          return StatefulBuilder(
                              builder: (context,setState) {
                                return InkWell(
                                  onTap:(){
                                      for(var ii =0;ii< gredientFirstList.length;ii++){
                                        setStatee((){
                                          gredientFirstList[ii].isSelected = false;
                                          print(gredientFirstList[ii].isSelected);
                                        });
                                      }
                                      gredientFirstList[i].isSelected = !gredientFirstList[i].isSelected;
                                      pickGredTemColor1 = gredientFirstList[i].color;
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: gredientFirstList[i].color,
                                    child: gredientFirstList[i].isSelected ? Icon(Icons.check):Container(),
                                  ),
                                );
                              }
                          );
                        })
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Pick second Color",style: TextStyle(fontSize: 10,color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(gredientSecList.length, (i){
                          return InkWell(
                            onTap:(){
                              setStatee(() {
                                for(var ii =0;ii< gredientSecList.length;ii++){
                                  setState((){
                                    gredientSecList[ii].isSelected = false;
                                    print(gredientSecList[ii].isSelected);
                                  });
                                }
                                gredientSecList[i].isSelected = !gredientSecList[i].isSelected;
                                pickGredTemColor2 = gredientSecList[i].color;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              color: gredientSecList[i].color,
                              child: gredientSecList[i].isSelected ? Icon(Icons.check):Container(),
                            ),
                          );
                        })
                    ),
                  ),
                  SizedBox(height: 30,),
                  MaterialButton(
                    minWidth: getWidth(context),
                    color: kSecendoryColor,
                    onPressed: (){
                      if(pickGredTemColor1 != null && pickGredTemColor2 != null){
                        setState(() {
                          gredientColor1 = pickGredTemColor1!;
                          gredientColor2 = pickGredTemColor2!;
                          isGredient = true;
                        });
                        Navigator.pop(context);
                      }else{
                        Fluttertoast.showToast(msg: "Please Pick Colors");
                      }
                    },
                    child: Text("Done"),
                  )
                ],
              ),
            ),
          );
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final autBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile Image"),
          ),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: isTextActive ? getHeight(context) / 9:getHeight(context) / 6,
                ),
                if(isTextActive == false && isBorderEnabled && isGredient == false) ...[
                  state.profileUpdatedImage == null ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${Utils.baseImageUrl}${state.profileImage}",)
                        ),
                        shape: BoxShape.circle,
                      border: Border.all(color: selectedflatColor.withOpacity(0.8),width: 20)
                    ),
                    height: 200,
                    width: 200,
                  ):Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(state.profileUpdatedImage!)
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: selectedflatColor.withOpacity(0.8),width: 20)
                    ),
                    height: 200,
                    width: 200,
                  )
                ] else if(isTextActive == false && isBorderEnabled == true && isGredient == true) ... [
                  state.profileUpdatedImage == null ? Container(
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              gredientColor1,
                              gredientColor2,
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: NetworkImage("${Utils.baseImageUrl}${state.profileImage}")
                          ),
                        shape: BoxShape.circle
                      ),
                      height: 180,
                      width: 180,
                    ),

                  ):Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              gredientColor1,
                              gredientColor2,
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(state.profileUpdatedImage!)
                          ),
                          shape: BoxShape.circle
                      ),
                      height: 180,
                      width: 180,
                    ),
                  )
                ] else if(isTextActive == true && isBorderEnabled == true && isGredient == true)...[
                  state.profileUpdatedImage == null ? Stack(
                    children: [
                      Center(
                          child: CircleAvatar(
                            radius: 110,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: [
                                        gredientColor1,
                                        gredientColor2,
                                      ]
                                  )
                              ),
                              padding: const EdgeInsets.all(25.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${Utils.baseImageUrl}${state.profileImage}")
                                    )
                                ),
                              ),
                            ),
                          )
                      ),
                      Center(
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                textValue.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 10,
                              startAngle: 90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.anticlockwise,
                            ),
                          ],
                          radius: 110,
                          position: CircularTextPosition.inside,
                        ),
                      ),
                    ],
                  ):Stack(
                    children: [
                      Center(
                          child: CircleAvatar(
                            radius: 110,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: [
                                        gredientColor1,
                                        gredientColor2,
                                      ]
                                  )
                              ),
                              padding: const EdgeInsets.all(25.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(state.profileUpdatedImage!)
                                    )
                                ),
                              ),
                            ),
                          )
                      ),
                      Center(
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                textValue.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 10,
                              startAngle: 90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.anticlockwise,
                            ),
                          ],
                          radius: 110,
                          position: CircularTextPosition.inside,
                        ),
                      ),
                    ],
                  ),
                ] else if(isTextActive == true && isBorderEnabled == true && isGredient == false)...[
                  state.profileUpdatedImage == null ? Stack(
                    children: [
                      Center(
                          child: CircleAvatar(
                            radius: 110,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 25,
                                    color: selectedflatColor.withOpacity(0.8)
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${Utils.baseImageUrl}${state.profileImage}")
                                  )
                              ),
                            ),
                          )
                      ),
                      Center(
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                textValue.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 10,
                              startAngle: 90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.anticlockwise,
                            ),
                          ],
                          radius: 110,
                          position: CircularTextPosition.inside,
                        ),
                      ),
                    ],
                  ) : Stack(
                    children: [
                      Center(
                          child: CircleAvatar(
                            radius: 110,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 25,
                                      color: selectedflatColor.withOpacity(0.8)
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(state.profileUpdatedImage!)
                                  )
                              ),
                            ),
                          )
                      ),
                      Center(
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                textValue.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 10,
                              startAngle: 90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.anticlockwise,
                            ),
                          ],
                          radius: 110,
                          position: CircularTextPosition.inside,
                        ),
                      ),
                    ],
                  ),
                ]else ...[
                  state.profileUpdatedImage == null
                      ? Center(
                    child: CircleAvatar(
                      radius: 110,
                      backgroundImage: NetworkImage(
                          "${Utils.baseImageUrl}${state.profileImage}"),
                    ),
                  )
                      : Center(
                    child: CircleAvatar(
                      radius: 110,
                      backgroundImage: FileImage(
                          File(state.profileUpdatedImage!.path)),
                    ),
                  ),
                ],

                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => bloc.getImageGallery(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                          child: Column(
                            children: [Icon(LineIcons.image), Text("Gallery")],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => bloc.getImageCamera(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Center(
                            child: Column(
                              children: [Icon(LineIcons.camera), Text("Camera")],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                state.profileUpdatedImage == null ?
                Container():
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        bloc.cropImage();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Center(
                            child: Row(
                              children: [Icon(LineIcons.crop), Text("Crop")],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                autBloc.planID == 1 ? Container():Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Add Border",style: TextStyle(color: Colors.grey,fontSize: 10),),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              isBorderEnabled = !isBorderEnabled;
                            });
                            if(!isBorderEnabled){
                              setState(() {
                                isTextActive = false;
                                isTextOkButtonClic = false;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isBorderEnabled ? Colors.grey[300] :Colors.white),
                            child: Column(
                              children: [
                                Icon(LineIcons.borderStyle),
                                Text("Border"),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            showFlatColorDialouge();
                          },
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Container(
                                  height: 25,
                                  width: 120,
                                  color: selectedflatColor,
                                ),
                                Text("Flat")
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            showGredientColorGialouge();
                          },
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Container(
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            gredientColor1,
                                            gredientColor2
                                          ]
                                      )
                                  ),
                                ),
                                Text("Gredient")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Add Promotional Text",style: TextStyle(color: Colors.grey,fontSize: 10),),
                          Checkbox(value: isTextActive, onChanged: (o){
                            if(isBorderEnabled){
                              setState(() {
                                isTextActive = o!;
                              });
                            }else{
                              Fluttertoast.showToast(msg: "Please Enable Border First");
                            }

                          })
                        ],
                      ),
                    ),
                    isTextActive ? Padding(
                      padding: const EdgeInsets.only(left:15.0,right: 15.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Promotional text here"
                            ),
                            maxLength: 20,
                            onChanged: (val){
                              setState(() {
                                textValue = val;
                              });
                            },
                          ),
                          // SizedBox(height: 20,),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 3),
                          //   child: SecendoryButton(text: "Add Text", onPressed: (){
                          //     setState(() {
                          //       isTextOkButtonClic = true;
                          //     });
                          //   }),
                          // )
                        ],
                      ),
                    ):Container()
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12.0),
            child: state.isProfileUpdating ? const Center(child: CircularProgressIndicator()):SecendoryButton(
              onPressed: () =>bloc.updateUserProfileImage(autBloc.userID!, autBloc.accesToken!, context),
              text: "Save",
            ),
          ),
        );
      },
    );
  }
}
class ColorsPicModel{
  Color color;
  bool isSelected;
  ColorsPicModel({required this.color,required this.isSelected});
}