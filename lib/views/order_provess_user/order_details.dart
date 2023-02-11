import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/profile/components/clip_path.dart';

import '../../utils/utils.dart';
import '../profile/profile_more/order_help.dart';

class UserOrderDetails extends StatefulWidget {
  final int index;

  const UserOrderDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<UserOrderDetails> createState() => _UserOrderDetailsState();
}

class _UserOrderDetailsState extends State<UserOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var d = state.userOrder![widget.index];
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: ProfileClipPath(),
                child: Container(
                  height: getHeight(context) / 3,
                  width: getWidth(context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image: NetworkImage(d.images == null || d.images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${d.images![0].imageUrl}")
                      )
                  ),
                  child: Stack(
                    children: [
                      SafeArea(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.arrow_back,color: Colors.black,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                nextScreen(context, OrderHelp(index: widget.index,),);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.info,color: Colors.black,),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    d.orderStatus == "3"? Container(
                        child: Text("This order is cancelled",style: TextStyle(color: Colors.red),),
                      color: Colors.yellow,
                      width: getWidth(context),
                      padding: EdgeInsets.all(8),
                    ):Container(),
                    Text(d.businessName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                    SizedBox(height: 20,),
                    Text("Order Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
                        Text("#${d.orderNo!}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
                        Text(d.orderStatus == "0" ? "pending" : d.orderStatus == "1" ? 'on the way':d.orderStatus == "2"?'shipped':d.orderStatus == "3"?"canceled":'unknown',style: TextStyle(color:d.orderStatus == "0" ||d.orderStatus == "1" ? Colors.orange : d.orderStatus == "2" ? Colors.green:Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Id",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
                        Text("#${d.orderId!}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order from",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
                        Text(d.businessName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Delivery Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),)),
                        Expanded(child: Text(d.shippingAddress!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(color: Colors.black,),
                    SizedBox(height: 10,),
                    ListTile(
                      leading: Text("x1"),
                      title: Text(d.productName!),
                      trailing: Text("\$${d.totalAmount}",style: TextStyle(fontFamily: ''),),
                    ),
                    SizedBox(height: 10,),
                    Divider(color: Colors.black,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),),
                        Text("\$${d.totalAmount!}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,fontFamily: ''),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping fee",style: TextStyle(),),
                        Text("\$${d.shippingCost!}",style: TextStyle(fontFamily: ''),),
                      ],
                    ),
                    d.shippingBy == null ? Container():Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping fee",style: TextStyle(),),
                        Text("\$${d.shippingBy!}",style: TextStyle(fontFamily: ''),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total (Incl.GST)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: ''),),
                    Text("\$${d.totalAmount}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: ''),),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
