import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../components/universal_card.dart';
class AddPlaces extends StatefulWidget {
  const AddPlaces({Key? key}) : super(key: key);

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  String name = '';
  String address = '';
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Place"),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  state.addPlaceImagesWidget == null || state.addPlaceImagesWidget!.isEmpty ? InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){
                                        bloc.pickEventsImages(1);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.camera),
                                          SizedBox(width: 10,),
                                          Text("Camera")
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    MaterialButton(
                                      onPressed: () {
                                        bloc.pickEventsImages(2);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.image),
                                          SizedBox(width: 10,),
                                          Text("Gallery")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      height: getHeight(context) / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200]
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(LineIcons.camera),
                            SizedBox(width: 5,),
                            Text("Add Images"),
                          ],
                        ),
                      ),
                    ),
                  ):
                  CarouselSlider(
                      options: CarouselOptions(height: getHeight(context) / 4,aspectRatio: 16/9,
                        viewportFraction: 0.9,enableInfiniteScroll: false,),
                      items: List.generate(state.addPlaceImagesWidget!.length, (index){
                        return InkWell(
                          onTap: (){
                            if(index != state.addPlaceImages!.length){
                              // nextScreen(context, PreviewEventImage(index: index));
                            }else{
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        height: 120,
                                        child: Column(
                                          children: [
                                            MaterialButton(
                                              onPressed: (){
                                                bloc.pickEventsImages(1);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(LineIcons.camera),
                                                  SizedBox(width: 10,),
                                                  Text("Camera")
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            MaterialButton(
                                              onPressed: () {
                                                bloc.pickEventsImages(2);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(LineIcons.image),
                                                  SizedBox(width: 10,),
                                                  Text("Gallery")
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state.addPlaceImagesWidget![index]),
                        );
                      })
                  ),
                  const Divider(),
                  const SizedBox(height: 10,),
                  TextField(
                    onChanged: (val){
                      name = val;
                      // bloc.assignEventValue(1,val);
                    },
                    decoration: const InputDecoration(
                        hintText: "Place Name"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    maxLines: 1,
                    onChanged: (val){
                      address = val;
                      // bloc.assignEventValue(2,val);
                    },
                    decoration: const InputDecoration(
                        hintText: "Address"
                    ),
                  ),
                  const SizedBox(height: 40,),
                  SecendoryButton(text: "Add Place", onPressed: (){
                    bloc.addPlace(authB.userID!, authB.accesToken!, name, address);
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
