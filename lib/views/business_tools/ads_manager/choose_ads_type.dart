import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/views/business_tools/ads_manager/choose_products.dart';
import '../../../utils/constants.dart';
import '../../../views/business_tools/ads_manager/choose_title.dart';
import 'package:line_icons/line_icons.dart';
class ChooseAdsType extends StatefulWidget {
  const ChooseAdsType({Key? key}) : super(key: key);

  @override
  _ChooseAdsTypeState createState() => _ChooseAdsTypeState();
}

class _ChooseAdsTypeState extends State<ChooseAdsType> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Ad Type"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              nextScreen(context, ChooseAdsProducts());
              bloc.setAdType(1);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:12.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(LineIcons.shoppingBag),
                      ),
                    ),
                    ListTile(
                      title: Text("Product Ads"),
                      subtitle: Text("Advertise your products through ads Campagin"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){
              nextScreen(context, ChooseTitle(isProduct: false,));
              bloc.setAdType(2);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:12.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(LineIcons.globe),
                      ),
                    ),
                    ListTile(
                      title: Text("Website Ads"),
                      subtitle: Text("Advertise your Site through ads Campagin"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          // InkWell(
          //   onTap: (){
          //     nextScreen(context, ChooseTitle(isProduct: false,));
          //     bloc.setAdType(3);
          //   },
          //   child: Card(
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(left:12.0),
          //             child: CircleAvatar(
          //               backgroundColor: Colors.grey[300],
          //               child: Icon(LineIcons.fileAlt),
          //             ),
          //           ),
          //           ListTile(
          //             title: Text("Post Ads"),
          //             subtitle: Text("Advertise your Posts through ads Campagin"),
          //             trailing: Icon(Icons.arrow_forward_ios_rounded),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
