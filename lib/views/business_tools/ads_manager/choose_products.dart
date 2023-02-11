import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/views/business_tools/ads_manager/choose_title.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class ChooseAdsProducts extends StatefulWidget {
  const ChooseAdsProducts({Key? key}) : super(key: key);

  @override
  State<ChooseAdsProducts> createState() => _ChooseAdsProductsState();
}

class _ChooseAdsProductsState extends State<ChooseAdsProducts> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Choose Products"),
            actions: [
              state.isDoneAvail ? TextButton(onPressed: () {
                nextScreen(context, ChooseTitle(isProduct: true,));
              }, child: Text("Next", style: TextStyle(color: kSecendoryColor),)):Container()
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                state.productsWithoutCollections == null ? Center( child: CupertinoActivityIndicator(),):state.productsWithoutCollections!.isEmpty ?  Center(
                  child: Column(
                    children: [
                      Text("Field to load products, add products to select for ads"),
                      MaterialButton(
                        onPressed: (){
                          bloc.fetchProductsWithoutCollections(authB.accesToken!, authB.userID!);
                        },
                        child: Text("Try Again"),
                      )
                    ],
                  ),
                ):
                GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1/1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.productsWithoutCollections!.length,
                    itemBuilder: (ctx,i){
                      var product = state.productsWithoutCollections?[i];
                      return InkWell(
                        onTap: ()=> bloc.chooseProductForAds(i),
                        child: Container(
                          height:80,
                          width:100,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(product!.images == null || product.images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${product!.images?[0].imageUrl}")
                              )
                          ),
                          child: product.isSelected ? Center(
                              child:  Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Icon(Icons.check),
                              )
                          ):Container(),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
