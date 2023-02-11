import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/constants.dart';
enum OrderCancelReason { changeMind, duplicateOrder, orderPlacedByMistake,quantityIsWrong}
class CancelOrderPage extends StatefulWidget {
  final int index;
  const CancelOrderPage({Key? key,required this.index}) : super(key: key);

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  OrderCancelReason? orderCancelReason = OrderCancelReason.changeMind;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    var d = state.userOrder![widget.index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            const Text("Tell us your reason for cancellation by choosing one of the options below."),
            SizedBox(height: 10,),
            const Text("You can cancel an order anytime before it is shipped"),
            SizedBox(height: 10,),
            const Text("Why do you want to cancel your order?",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            ListTile(
              title: const Text('Change Mind'),
              leading: Radio<OrderCancelReason>(
                value: OrderCancelReason.changeMind,
                groupValue: orderCancelReason,
                onChanged: (OrderCancelReason? value) {
                  setState(() {
                    orderCancelReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Duplicate Order'),
              leading: Radio<OrderCancelReason>(
                value: OrderCancelReason.duplicateOrder,
                groupValue: orderCancelReason,
                onChanged: (OrderCancelReason? value) {
                  setState(() {
                    orderCancelReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Order Placed by Mistake'),
              leading: Radio<OrderCancelReason>(
                value: OrderCancelReason.orderPlacedByMistake,
                groupValue: orderCancelReason,
                onChanged: (OrderCancelReason? value) {
                  setState(() {
                    orderCancelReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Quantity is wrong'),
              leading: Radio<OrderCancelReason>(
                value: OrderCancelReason.quantityIsWrong,
                groupValue: orderCancelReason,
                onChanged: (OrderCancelReason? value) {
                  setState(() {
                    orderCancelReason = value;
                  });
                },
              ),
            ),
            Row(
              children: [
                Text(state.error ?? "",style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 30,),
            state.isLoading ? Center(child: CupertinoActivityIndicator(),):SizedBox(
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Cancel order",style: TextStyle(color: Colors.white),), onPressed: (){
                  bloc.cancelUserOrder(authB.userID!, authB.accesToken!, d.orderId!,context);
              },color: Colors.red,
                minWidth: getWidth(context),
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
