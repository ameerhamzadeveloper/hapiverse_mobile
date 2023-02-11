import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/business_tools/orders/order_details.dart';
import 'package:happiverse/views/order_provess_user/order_details.dart';
import 'package:intl/intl.dart';

class MyOrdersUser extends StatefulWidget {
  const MyOrdersUser({Key? key}) : super(key: key);

  @override
  State<MyOrdersUser> createState() => _MyOrdersUserState();
}

class _MyOrdersUserState extends State<MyOrdersUser> {

  DateFormat dateF = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    print(authB.userID!);
    print(authB.accesToken!);
    bloc.fetchMyOrderUser(authB.userID!, authB.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Orders"),
          ),
          body: state.userOrder == null ? Center(child: CircularProgressIndicator(),):state.userOrder!.isEmpty ? Center(child: Text("No Orders"),):
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (c,i){
                var d = state.userOrder![i];
                return InkWell(
                  onTap: (){
                    nextScreen(context, UserOrderDetails(index: i,));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      // borderRadius: BorderRadius.circular(20)
                    ),
                    // elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(d.images == null || d.images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${d.images![0].imageUrl}")
                                          )
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(dateF.format(d.addDate!).toString())
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: ListTile(
                                    title: Text(d.productName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    subtitle: ExpandableText(
                                      d.productdescription ?? "",
                                      expandText: 'show more',
                                      collapseText: 'show less',
                                      maxLines: 3,
                                      linkColor: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\$${d.totalAmount!}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text(d.orderStatus == "0" ? "pending" : d.orderStatus == "1" ? 'on the way':d.orderStatus == "2"?'shipped':d.orderStatus == "3"?"canceled":'unknown',style: TextStyle(color:d.orderStatus == "0" ||d.orderStatus == "1" ? Colors.orange : d.orderStatus == "2" ? Colors.green:Colors.red),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.userOrder!.length,
            ),
          ),
        );
      },
    );
  }
}
