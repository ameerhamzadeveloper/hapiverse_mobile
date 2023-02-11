import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/business_tools/orders/ship_order.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../feeds/other_profile/other_profile_page.dart';
class OrderDetails extends StatefulWidget {
  final int type;
  final int index;

  const OrderDetails({Key? key,required this.type,required this.index}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    var d = state.businessOrders![widget.index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.type.toString() == d.orderStatus ? Text("Order ID #${d.orderNo}",style: TextStyle(color: Colors.blue,fontSize: 18),):Container(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(LineIcons.mapMarker,color: Colors.blue,),
                      Text("Address",style: TextStyle(color: Colors.blue),),
                    ],
                  ),
                  // TextButton(onPressed: (){}, child: Text("View on Map"))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child:widget.type.toString() == d.orderStatus ? Text(d.shippingAddress!,style: TextStyle(color: Colors.grey),):Container(),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(LineIcons.userCircle,color: Colors.blue,),
                      Text("Customer Details",style: TextStyle(color: Colors.blue),),
                    ],
                  ),
                  TextButton(onPressed: (){
                    profileBloc.fetchOtherProfile(d.userId!, authB.accesToken!,authB.userID!);
                    profileBloc.fetchOtherAllPost(d.userId!, authB.accesToken!,authB.userID!);
                    profileBloc.getOtherFriends(authB.userID!, authB.accesToken!,d.userId!);
                    nextScreen(context, OtherProfilePage(userId: d.userId!));
                  }, child: Text("View Profile"))
                ],
              ),
              widget.type.toString() == d.orderStatus ? Text("Name: ${d.customerName}",style: TextStyle(color: Colors.grey),):Container(),
              Text("Phone: +933057359640",style: TextStyle(color: Colors.grey),),
              SizedBox(height: 20,),
              Text("Order Items",style: TextStyle(color: Colors.blue),),
              d.orderStatus == widget.type.toString() ? ListTile(
                leading: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              d.images ==null || d.images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${d.images![0].imageUrl}"
                          )
                      )
                  ),
                ),
                title: Text(d.productName!),
                trailing: Text("\$${d.productPrice}"),
                subtitle: Text("Quantity (1)"),
              ): Container(),
              Divider(
                color: Colors.black,
              ),
              Text("Order Summery",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal"),
                  Text("\$${d.productPrice}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Price"),
                  Text("\$${d.shippingCost}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping By"),
                  Text("${d.shippingBy ?? ""}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Method"),
                  Text("Cash on delivery")
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: TextStyle(fontSize: 18),),
                  Text("\$${d.shippingCost != null ? (double.parse(d.productPrice!) + double.parse(d.shippingCost!)) : d.productPrice}",style: TextStyle(fontSize: 18),)
                ],
              ),
              SizedBox(height: 20,),
              widget.type == 2 ? Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(LineIcons.checkCircle,color: Colors.white),
                      SizedBox(width: 10,),
                      Text("Order Delivered",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ):
              SecendoryButton(text: "Shipped", onPressed: (){
                if(widget.type == 1){
                  showCupertinoDialog(context: context, builder: (v){
                    return CupertinoAlertDialog(
                      title: Text("Is this order is Delivered?"),
                      actions: [
                        CupertinoDialogAction(child: Text("No"),onPressed: ()=> Navigator.pop(context),),
                        CupertinoDialogAction(child: Text("Deliver"),onPressed: (){
                          bloc.changeOrderStatus(d.orderId!, '2', authB.userID!, authB.accesToken!);
                          Navigator.pop(context);
                        },),
                      ],
                    );
                  });
                }
                else{
                  nextScreen(context, ShipOrder(orderId: d.orderId!,orderNo: d.orderNo!,));
                }
              }),
              widget.type == 0 ? SizedBox(
                  width: getWidth(context),
                  child: OutlinedButton(onPressed: (){
                    showCupertinoDialog(context: context, builder: (v){
                      return CupertinoAlertDialog(
                        title: Text("Do you want to cancel this order?"),
                        actions: [
                          CupertinoDialogAction(child: Text("No"),onPressed: ()=> Navigator.pop(context),),
                          CupertinoDialogAction(child: Text("Cancel",style: TextStyle(color: Colors.red),),onPressed: (){
                            bloc.changeOrderStatus(d.orderId!, '3', authB.userID!, authB.accesToken!);
                            Navigator.pop(context);
                          },),
                        ],
                      );
                    });
                  }, child: Text("Cancel Order",style: TextStyle(color: Colors.red),))):Container()
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
