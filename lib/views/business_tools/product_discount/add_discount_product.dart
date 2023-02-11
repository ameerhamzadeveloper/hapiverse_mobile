import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
class AddDiscountProducts extends StatefulWidget {
  final String name;
  final String image;
  final String des;
  final String price;
  final String productId;
  final bool isEdit;
  final String discountedPrice;
  const AddDiscountProducts({Key? key,required this.image,required this.des,required this.name,required this.price,required this.productId,required this.isEdit,required this.discountedPrice}) : super(key: key);

  @override
  _AddDiscountProductsState createState() => _AddDiscountProductsState();
}

class _AddDiscountProductsState extends State<AddDiscountProducts> {
  String dropDownVal = "0%";

  String afterDiscount = "";

  addDiscountPercentage(int discount){
    print(discount);
    var val = ((discount / int.parse(widget.price.substring(0, widget.price.indexOf('.')))) * 100);
    var total = int.parse(widget.price.substring(0, widget.price.indexOf('.'))) - val.round();
    setState(() {
      afterDiscount = total.toString();
    });
    print(int.parse(widget.price.substring(0, widget.price.indexOf('.'))));
    print(afterDiscount);
    print(val);
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      afterDiscount = widget.discountedPrice;
      if(widget.isEdit){
        dropDownVal = '10%';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black,),
        title: Text("Add Discount",style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(
            child: Text(widget.isEdit ? "Update":"Save",style: TextStyle(color: afterDiscount == '' || widget.isEdit == false?Colors.grey:Colors.blue),),
            onPressed: (){
              print(dropDownVal);
              bloc.addProductDiscount(authB.userID!, authB.accesToken!, widget.productId, dropDownVal == '0%'? '' : afterDiscount,context,dropDownVal == '0%'? "0":"1");
            },
          )
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(items: [
            Container(
              height: getHeight(context) / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.image)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle,color: Colors.white,size: 10,),
                      Icon(Icons.circle,color: Colors.white,size: 10,),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ], options: CarouselOptions(height: getHeight(context) / 4,aspectRatio: 16/9,
            viewportFraction: 1.0,enableInfiniteScroll: false,),),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Original Price"),
                      SizedBox(width: 5,),
                      afterDiscount == ''? Text(widget.price) :Row(
                        children: [
                          Text(widget.price,style: TextStyle(decoration: TextDecoration.lineThrough),),
                          SizedBox(width: 5,),
                          Text(afterDiscount)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Discount Price"),
                      const SizedBox(width: 5,),
                      DropdownButton<dynamic>(
                        items: const [
                          DropdownMenuItem(child: Text("0%"),value: "0%",),
                          DropdownMenuItem(child: Text("10%"),value: "10%",),
                          DropdownMenuItem(child: Text("20%"),value: "20%",),
                          DropdownMenuItem(child: Text("30%"),value: "30%",),
                          DropdownMenuItem(child: Text("50%"),value: "50%",),
                          DropdownMenuItem(child: Text("70%"),value: "70%",),
                          DropdownMenuItem(child: Text("90%"),value: "90%",),
                        ],
                        value: dropDownVal,
                        onChanged: (val){
                          setState(() {
                            dropDownVal = val.toString();
                            if(val != "0%"){
                              addDiscountPercentage(int.parse(val.toString().substring(0,2)));
                            }else{
                              setState(() {
                                afterDiscount = "";
                              });
                            }

                          });
                        },
                        // isExpanded: true,
                      ),
                      SizedBox(width: 5,),
                      Text("or"),
                      SizedBox(width: 5,),
                      Expanded(
                        child: TextField(
                          onChanged: (v){
                            addDiscountPercentage(int.parse(v));
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Add Custom",
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("After Discount"),
                  //     SizedBox(width: 5,),
                  //     Text(afterDiscount)
                  //   ],
                  // ),
                  SizedBox(height: 10,),
                  Text(widget.des,style: TextStyle(color: Colors.grey,),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
