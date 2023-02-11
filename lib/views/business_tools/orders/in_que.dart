import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/business_tools/orders/ship_order.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants.dart';
import '../../../views/business_tools/orders/order_details.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
class InQueOrders extends StatefulWidget {
  @override
  _InQueOrdersState createState() => _InQueOrdersState();
}

class _InQueOrdersState extends State<InQueOrders> {
  DateFormat df = DateFormat('dd MMM yyyy, hh:mm a');
  @override
  void initState() {
    super.initState();
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchQueOrder(authB.userID!, authB.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      body: UniversalCard(
        widget: state.businessOrders == null ? Center(child: CupertinoActivityIndicator(),): state.businessOrders!.isEmpty ? Center(child: Text("No Products In Que"),):
        ListView.builder(
          itemCount: state.businessOrders!.length,
          itemBuilder: (c,i){
            var d = state.businessOrders![i];
           if(d.orderStatus == '0'){
             return Card(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           Text("Order ID #${d.orderNo}"),
                           Icon(LineIcons.questionCircle,color: Colors.red,),
                         ],
                       ),
                       Container(
                         decoration: BoxDecoration(
                             color: Colors.deepOrangeAccent,
                             borderRadius: BorderRadius.circular(10)
                         ),
                         padding: const EdgeInsets.all(5),
                         child: Text("In Que",style: TextStyle(color: Colors.white),),
                       )
                     ],
                   ),
                   ListTile(
                     leading: Container(
                       width: 50,
                       decoration: BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius: BorderRadius.circular(10),
                           image: DecorationImage(
                               fit: BoxFit.cover,
                               image: NetworkImage(
                                   d.images == null || d.images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${d.images![0].imageUrl}"
                               )
                           )
                       ),
                     ),
                     subtitle: Text("USD ${d.productPrice}",style: TextStyle(color: kSecendoryColor),),
                     title: Text(d.productName!),
                     trailing: Text("1 Items",style: TextStyle(color: kUniversalColor),),
                     tileColor: Colors.white,
                   ),
                   ListTile(
                     leading: CircleAvatar(),
                     title: Text(d.customerName!),
                     subtitle: Text(d.shippingAddress!),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal:8.0),
                     child: Text(df.format(d.addDate!),style: TextStyle(color: Colors.grey),),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: SizedBox(
                       width: double.infinity,
                       child: OutlinedButton(
                           onPressed: (){
                             nextScreen(context, OrderDetails(type: 0,index: i,));
                           }, child: Text("View Order")),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: SecendoryButton(onPressed: (){
                       nextScreen(context, ShipOrder(orderId: d.orderId!,orderNo: d.orderNo!,));
                     },text: "Ship",),
                   )
                 ],
               ),
             );
           }else{
             return Container();
           }

          },
        )
      ),
    );
  },
);
  }
}
