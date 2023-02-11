import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/order_provess_user/check_out_page.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../utils/constants.dart';
import '../../views/business_tools/view_all_products.dart';
import '../../views/business_tools/view_other_product_images_slider.dart';
import '../../views/components/secondry_button.dart';
import '../../views/profile/components/clip_path.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/utils.dart';
class OtherProductDetails extends StatefulWidget {
  final int index;
  final bool isFromCollection;
  final int? collecIndex;
  const OtherProductDetails({Key? key,required this.index,required this.isFromCollection,this.collecIndex}) : super(key: key);
  @override
  _OtherProductDetailsState createState() => _OtherProductDetailsState();
}

class _OtherProductDetailsState extends State<OtherProductDetails> {
  
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: kScaffoldBgColor,
        title: Text("Details",style: TextStyle(color: Colors.black),),
        // actions: [
        //   IconButton(
        //     onPressed: (){},
        //     icon: Badge(
        //       badgeColor: Colors.blue,
        //       badgeContent: Text("2",style: TextStyle(fontFamily: "",color: Colors.white,fontSize: 9),),
        //       showBadge: true,
        //       alignment: Alignment.topLeft,
        //       child: Icon(LineIcons.shoppingCartArrowDown,color: Colors.blue,)),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ClipPath(
            //   clipper: ProfileClipPath(),
            //   child: Container(
            //     height: getHeight(context) / 3,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: NetworkImage(products[widget.index].productItems[widget.productIndex].productImage)
            //       )
            //     ),
            //   ),
            // ),
            widget.isFromCollection ? CarouselSlider(items: state.otherProductWithCollection![widget.collecIndex!].products![widget.index].images!.map((e){
              return InkWell(
                onTap: (){
                  nextScreen(context, ViewOtherProductImages(isFromCollection: widget.isFromCollection,index: widget.index,collecIndex: widget.collecIndex,));
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
                viewportFraction: 1.0,height: getHeight(context) / 3)):
            CarouselSlider(items: state.otherProductsWithoutCollections![widget.index].images!.map((e){
              return InkWell(
                onTap: (){
                  nextScreen(context, ViewOtherProductImages(isFromCollection: widget.isFromCollection,index: widget.index,collecIndex: widget.collecIndex,));
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
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.isFromCollection ? state.otherProductWithCollection![widget.collecIndex!].products![widget.index].productName! : state.otherProductsWithoutCollections![widget.index].productName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text(widget.isFromCollection ? "\$${state.otherProductWithCollection![widget.collecIndex!].products![widget.index].productPrice!}" : "\$${state.otherProductsWithoutCollections![widget.index].productPrice!}"),
                    SizedBox(height: 10,),
                    Text(widget.isFromCollection ? state.otherProductWithCollection![widget.collecIndex!].products![widget.index].productName! : state.otherProductsWithoutCollections![widget.index].productdescription!,style: TextStyle(color: Colors.grey,),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            // Container(
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [],
            //         ),
            //         Text("About this business"),
            //         Text("About thibout this businessbout this businessbout this businessbout this businessbout this businesss business",style: TextStyle(color: Colors.grey),)
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: authB.isBusinessShared! ? Text(""):MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          color: Colors.grey[300],
          onPressed: (){
            if(widget.isFromCollection){
              nextScreen(context, CheckOutPage(productName: state.otherProductWithCollection![widget.collecIndex!].products![widget.index].productName!,productId: state.otherProductWithCollection![widget.collecIndex!].products![widget.index].productId!,productImage: "${Utils.baseImageUrl}${state.otherProductWithCollection![widget.collecIndex!].products![widget.index].images![0].imageUrl!}",productPrice: state.otherProductWithCollection![widget.collecIndex!].products![widget.index].productPrice!,businessId: state.otherProductWithCollection![widget.collecIndex!].products![widget.index].businessId!,));
            }else{
              nextScreen(context, CheckOutPage(productName: state.otherProductsWithoutCollections![widget.index].productName!,productId: state.otherProductsWithoutCollections![widget.index].productId!,productImage:state.otherProductsWithoutCollections![widget.index].images == null || state.otherProductsWithoutCollections![widget.index].images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg": "${Utils.baseImageUrl}${state.otherProductsWithoutCollections![widget.index].images![0].imageUrl!}",productPrice: state.otherProductsWithoutCollections![widget.index].productPrice!,businessId:state.otherProductsWithoutCollections![widget.index].businessId!!,));
            }
          },
          child: Text("Buy Now"),
        ),
      ),
    );
  },
);
  }
}
