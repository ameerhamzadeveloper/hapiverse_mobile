import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/profile/settings/ads_settings.dart';
import 'package:intl/intl.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/business_tools/ads_manager/choose_ads_type.dart';
import '../../../views/business_tools/ads_manager/create_ads.dart';
import '../../../views/business_tools/ads_manager/view_ad.dart';
import 'package:line_icons/line_icons.dart';
class AdsManager extends StatefulWidget {
  const AdsManager({Key? key}) : super(key: key);

  @override
  _AdsManagerState createState() => _AdsManagerState();
}

class _AdsManagerState extends State<AdsManager> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = context.read<BusinessProductCubit>();
    final prof = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchmyAds(authB.userID!,authB.accesToken!);
    prof.fetchPaymentCard(authB.userID!,authB.accesToken!);
    print(authB.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Ads Manager"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                   Text('My Campaigns',style: TextStyle(fontSize: 25),),
                ],
              ),
              SizedBox(height: 20,),
              state.businessAds == null ? const Center(child: CupertinoActivityIndicator(),):
                  state.businessAds!.isEmpty ? const Center(child: Text("No Ads Running"),):
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.businessAds!.length,
                        itemBuilder: (c,i){
                          var data = state.businessAds![i];
                          return InkWell(
                            onTap: ()=> nextScreen(context, ViewAd()),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Card(
                                elevation: 4,  // Change this
                                shadowColor: Colors.black12,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Text(data.status == 1 ? "Active" : "Paused",style: TextStyle(color: Colors.green),),
                                              ),
                                              Text(" Ad Type: ${data.adType}")
                                            ],
                                          ),
                                          PopupMenuButton<String>(
                                            icon: Icon(Icons.more_vert),
                                            onSelected: (v){
                                              if(v == AdsStatus.Active){
                                                print(data.status == 1 ? "0":"1");
                                                bloc.updateAdsStatus(authB.userID!, authB.accesToken!, data.adId.toString(),data.status == 1 ? "2":"1");
                                              }else if(v == AdsStatus.Delete){
                                                showDialog(context: context, builder: (c){
                                                  return AlertDialog(
                                                    title: Text("Do you want to delete this campagin?"),
                                                    actions: [
                                                      MaterialButton(onPressed: (){},child: Text("Cancel"),),
                                                      MaterialButton(onPressed: (){
                                                        bloc.deleteAds(authB.userID!, authB.accesToken!, data.adId.toString());
                                                        Navigator.pop(context);
                                                      },child: Text("Delete"),),
                                                    ],
                                                  );
                                                });
                                              }
                                            },
                                            itemBuilder: (BuildContext context) {
                                              return AdsStatus.adsStatuses.map((String choice) {
                                                return PopupMenuItem<String>(
                                                  value: choice,
                                                  child: Text(choice),
                                                );
                                              }).toList();
                                            },
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                      SizedBox(height: 10,),
                                      ListTile(
                                        title: Text(data.adTitle!),
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      data.image!
                                                  )
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Clicks"),
                                              Text(data.totalClicks!,style: TextStyle(fontSize: 32,fontFamily: "",fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Cost"),
                                              Row(
                                                children: [
                                                  Text(NumberFormat.compact().format(double.parse(data.totalBudget!)),style: TextStyle(fontSize: 32,fontFamily: "",fontWeight: FontWeight.bold),),
                                                  SizedBox(width: 5,),
                                                  Text("USD")
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Spent"),
                                              Row(
                                                children: [
                                                  Text(NumberFormat.compact().format(double.parse(data.spent!)),style: TextStyle(fontSize: 32,fontFamily: "",fontWeight: FontWeight.bold),),
                                                  SizedBox(width: 5,),
                                                  Text("USD")
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> nextScreen(context, ChooseAdsType()),
        child: Icon(Icons.add),
      ),
    );
  },
);
  }
}
class AdsStatus {
  static const String Active = 'Active/Pause';
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';

  static const List<String> adsStatuses = <String>[
    Active,
    Edit,
    Delete
  ];
}