import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/business_product/business_product_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
class ViewEventImages extends StatefulWidget {
  final int index;

  const ViewEventImages({Key? key,required this.index}) : super(key: key);
  @override
  _ViewEventImagesState createState() => _ViewEventImagesState();
}

class _ViewEventImagesState extends State<ViewEventImages> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CarouselSlider(items: state.otherBusinessEvent![widget.index].images!.map((e){
                    return InkWell(
                      onTap: (){
                        // nextScreen(context, ViewOtherProductImages(isFromCollection: widget.isFromCollection,index: widget.index,collecIndex: widget.collecIndex,));
                      },
                      child: Container(
                        height: getHeight(context) / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${Utils.baseImageUrl}${e.imageUrl}")
                            )
                        ),
                      ),
                    );
                  }).toList() , options: CarouselOptions(
                      autoPlay: false,enableInfiniteScroll: false,
                      viewportFraction: 1.0,height: getHeight(context) / 3)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.clear,color: Colors.black,),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
