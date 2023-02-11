import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import 'package:happiverse/views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
class ShipOrder extends StatefulWidget {
  final String orderId;
  final String orderNo;
  const ShipOrder({Key? key,required this.orderId,required this.orderNo}) : super(key: key);

  @override
  State<ShipOrder> createState() => _ShipOrderState();
}

class _ShipOrderState extends State<ShipOrder> {

  String shipfee = '';
  String shiperName = '';
  GlobalKey<FormState> key =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Ship your order"),
      ),
      body: UniversalCard(
        widget: Form(
          key: key,
          child: Column(
            children: [
              Text("Order No: ${widget.orderNo}",style: TextStyle(fontSize: 18),),
              SizedBox(height: 20,),
              TextFormField(
                validator: (v){
                  if(v!.isEmpty){
                    return "Required Field";
                  }else{
                    return null;
                  }
                },
                onChanged: (v){
                  shipfee = v;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Shipping Fee",
                  prefixIcon: Icon(LineIcons.dollarSign)
                ),
              ),
              TextFormField(
                validator: (v){
                  if(v!.isEmpty){
                    return "Required Field";
                  }else{
                    return null;
                  }
                },
                onChanged: (v){
                  shiperName = v;
                },
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Shipper Name",
                    // prefixIcon: Icon(LineIcons.dollarSign)
                ),
              ),
              const SizedBox(height: 30,),
              SecendoryButton(text: "Ship Order", onPressed: (){
                if(key.currentState!.validate()){

                  bloc.shipOrder(authB.userID!, authB.accesToken!, widget.orderId, shipfee, shiperName, context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
