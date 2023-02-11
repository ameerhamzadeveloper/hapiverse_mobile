import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/order_provess_user/check_out_page.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../utils/constants.dart';
import '../../views/business_tools/view_other_product_images_slider.dart';
import '../../utils/utils.dart';

class ProductDetailsHapimart extends StatefulWidget {
  final int index;
  const ProductDetailsHapimart({Key? key,required this.index}) : super(key: key);
  @override
  _ProductDetailsHapimartState createState() => _ProductDetailsHapimartState();
}

class _ProductDetailsHapimartState extends State<ProductDetailsHapimart> {

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
                CarouselSlider(items: state.hapimartProduct![widget.index].images.map((e){
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
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.hapimartProduct![widget.index].productName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("\$${state.hapimartProduct![widget.index].productPrice}"),
                        SizedBox(height: 10,),
                        Text(state.hapimartProduct![widget.index].productdescription,style: TextStyle(color: Colors.grey,),),
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
            child: authB.isBusinessShared! ? Text("") : MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              color: Colors.grey[300],
              onPressed: (){
                  nextScreen(context, CheckOutPage(productName: state.hapimartProduct![widget.index].productName,productId: state.hapimartProduct![widget.index].productId,productImage:state.hapimartProduct![widget.index].images == null || state.hapimartProduct![widget.index].images.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg": "${Utils.baseImageUrl}${state.hapimartProduct![widget.index].images[0].imageUrl}",productPrice: state.hapimartProduct![widget.index].productPrice,businessId:state.hapimartProduct![widget.index].businessId,));
              },
              child: Text("Buy Now"),
            ),
          ),
        );
      },
    );
  }
}
