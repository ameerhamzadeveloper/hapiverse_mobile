import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/utils/config/assets_config.dart';
import 'package:happiverse/views/components/secondry_button.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class ViewMyBusinessProduct extends StatefulWidget {
  final int index;
  final bool isWithoutCollection;
  final int? collIndex;
  const ViewMyBusinessProduct({Key? key,required this.index,required this.isWithoutCollection,this.collIndex}) : super(key: key);

  @override
  State<ViewMyBusinessProduct> createState() => _ViewMyBusinessProductState();
}

class _ViewMyBusinessProductState extends State<ViewMyBusinessProduct> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        var d = state.productsWithoutCollections![widget.index];
        var data =widget.isWithoutCollection ? null : state.productWithCollection![widget.index].products![widget.collIndex!];
        return Scaffold(
          appBar: AppBar(
            title: Text("Product Detail"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                widget.isWithoutCollection ? d.images == null || d.images!.isEmpty ? Container(
                  height: getHeight(context) / 3,
                  width: double.infinity,
                  child: Image.network(AssetConfig.noImage),
                ):CarouselSlider(items: d.images!.map((e){
                  return InkWell(
                    onTap: (){
                      // nextScreen(context, ViewOtherProductImages(isFromCollection: widget.isFromCollection,index: widget.index,collecIndex: widget.collecIndex,));
                    },
                    child: Container(
                      height: getHeight(context) / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(d.images == null || d.images!.isEmpty ? AssetConfig.noImage:"${Utils.baseImageUrl}${e.imageUrl}")
                          )
                      ),
                    ),
                  );
                }).toList() , options: CarouselOptions(
                    autoPlay: false,enableInfiniteScroll: false,
                    viewportFraction: 1.0,height: getHeight(context) / 3),
                ):
                data!.images == null || data.images!.isEmpty ? Container(
                  height: getHeight(context) / 3,
                  width: double.infinity,
                  child: Image.network(AssetConfig.noImage),
                ):CarouselSlider(items: data.images!.map((e){
                  return InkWell(
                    onTap: (){
                      // nextScreen(context, ViewOtherProductImages(isFromCollection: widget.isFromCollection,index: widget.index,collecIndex: widget.collecIndex,));
                    },
                    child: Container(
                      height: getHeight(context) / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data.images == null || data.images!.isEmpty ? AssetConfig.noImage:"${Utils.baseImageUrl}${e.imageUrl}")
                          )
                      ),
                    ),
                  );
                }).toList() , options: CarouselOptions(
                    autoPlay: false,enableInfiniteScroll: false,
                    viewportFraction: 1.0,height: getHeight(context) / 3),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: widget.isWithoutCollection ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.productName ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: ''),),
                      SizedBox(height: 10,),
                      Text(d.productdescription ?? "",style: TextStyle(fontFamily: ''),),
                      // Spacer(),
                      SizedBox(height: 50,),
                      SecendoryButton(text: "Edit Product", onPressed: (){}),
                      MaterialButton(child: Text("Delete Product",style: TextStyle(color: Colors.white),), onPressed: (){},color: Colors.red,minWidth: getWidth(context),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                    ],
                  ):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data!.productName ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: ''),),
                      SizedBox(height: 10,),
                      Text(data.productdescription ?? "",style: TextStyle(fontFamily: ''),),
                      // Spacer(),
                      SizedBox(height: 50,),
                      // SecendoryButton(text: "Edit Product", onPressed: (){}),
                      MaterialButton(child: Text("Delete Product",style: TextStyle(color: Colors.white),), onPressed: (){
                        showDialog(context: context, builder: (ctx){
                          return  CupertinoAlertDialog(
                            title: Text("Do you want to Delete this product?"),
                            content: Text("Deleting product will be permanent remove"),
                            actions: [
                              CupertinoDialogAction(child: Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                              CupertinoDialogAction(child: Text("Delete",style: TextStyle(color: Colors.red),),onPressed: (){
                                bloc.deletProducts(widget.isWithoutCollection ? d.productId! : data.productId!,authB.userID!,authB.accesToken!);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },),
                            ],
                          );
                        });
                      },color: Colors.red,minWidth: getWidth(context),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                    ],
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
