import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/utils/config/assets_config.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../views/business_tools/product_discount/add_discount_product.dart';
import '../../../views/components/universal_card.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class ProductDiscount extends StatefulWidget {
  const ProductDiscount({Key? key}) : super(key: key);

  @override
  _ProductDiscountState createState() => _ProductDiscountState();
}

class _ProductDiscountState extends State<ProductDiscount> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchDiscountedProducts(authB.userID!, authB.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Products Discount"),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Discounted Products",style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  state.discountedProducts == null ? Center( child: CupertinoActivityIndicator(),):state.discountedProducts!.isEmpty ?  Center(
                    child: Text("No Discounted Products")
                  ):
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.discountedProducts!.length,
                      itemBuilder: (ctx,i){
                        var product = state.discountedProducts?[i];
                        return ListTile(
                          leading: Container(
                            height:80,
                            width:80,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(product!.images == null || product.images!.isEmpty ? AssetConfig.noImage:"${Utils.baseImageUrl}${product!.images?[0].imageUrl}")
                                )
                            ),
                          ),
                          title: Text(product.productName!),
                          subtitle: Row(
                            children: [
                              Text("\$${product.productPrice}",style: TextStyle(decoration: TextDecoration.lineThrough),),
                              SizedBox(width: 10,),
                              Text("\$${product.discouintedPrice}"),
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: (){
                              nextScreen(context,AddDiscountProducts(
                                image: product!.images == null || product.images!.isEmpty ? AssetConfig.noImage:"${Utils.baseImageUrl}${product.images?[0].imageUrl}",
                                name: product.productName!,
                                price: product.productPrice!,
                                des: product.productdescription!,
                                productId: product.productId!,
                                discountedPrice: product.discouintedPrice!,
                                isEdit: true,
                              ));
                            },
                            child: Text("Edit"),
                          ),
                        );
                      }
                  ),
                  const Text("Add Discounts",style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  state.productsWithoutCollections == null ? Center( child: CupertinoActivityIndicator(),):state.productsWithoutCollections!.isEmpty ?  Center(
                    child: Column(
                      children: [
                        Text("Field to load products"),
                        MaterialButton(
                          onPressed: (){
                            // bloc.fetchProductsWithoutCollections(authB.accesToken!, authB.userID!);
                          },
                          child: Text("Try Again"),
                        )
                      ],
                    ),
                  ):
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.productsWithoutCollections!.length,
                      itemBuilder: (ctx,i){
                        var product = state.productsWithoutCollections?[i];
                        if(product!.isDiscountActive == "0"){
                        return ListTile(
                          leading: Container(
                            height:80,
                            width:80,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(product.images == null || product.images!.isEmpty ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${product.images?[0].imageUrl}")
                                )
                            ),
                          ),
                          title: Text(product.productName!),
                          subtitle: ExpandableText(
                            product.productdescription!,
                            expandText: 'show more',
                            collapseText: 'show less',
                            maxLines: 3,
                            linkColor: Colors.blue,
                          ),
                          trailing: TextButton(
                            onPressed: (){
                              nextScreen(context,AddDiscountProducts(
                                image: product.images == null || product.images!.isEmpty ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${product.images?[0].imageUrl}",
                                name: product.productName!,
                                price: product.productPrice!,
                                des: product.productdescription!,
                                productId: product.productId!,
                                discountedPrice: '',
                                isEdit: false,
                              ));
                            },
                            child: Text("Add"),
                          ),
                        );
                        }else{
                          return Container();
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
