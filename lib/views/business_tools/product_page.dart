import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/business_tools/add_product/view_product.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/utils.dart';
import '../../views/business_tools/add_product/add_product.dart';
import '../../views/business_tools/add_product/add_collection.dart';
import '../../views/business_tools/product_details.dart';
import '../../views/components/secondry_button.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import '../profile/components/clip_path.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchProductWithCollection(authB.userID!, authB.accesToken!);
    bloc.fetchProductsWithoutCollections( authB.accesToken!,authB.userID!,);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
          ),
          body: BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, prodState) {
    return UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: ProfileClipPath(),
                    child: Container(
                      height: getHeight(context) / 3,
                      decoration: BoxDecoration(
                          color: kUniversalColor,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.businessProfile!.featureImageUrl == null ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZP-JD9G84A1dA8es5pTzdV2eQ-06v2TWr9S0Kl58XJtI6UlzzjFmcCn4I5etZJyCkVRM&usqp=CAU":"${Utils.baseImageUrl}${state.businessProfile!.featureImageUrl}")
                          )
                      ),
                      child: Center(
                        child: Text(state.businessProfile!.businessName!,style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.8)),),
                      ),
                    ),
                  ),
                  Container(
                    // height: 100,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      onTap: (){
                        nextScreen(context, const AddProduct());
                      },
                      leading: Container(
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Icon(LineIcons.plusCircle),
                        ),
                      ),
                      title: Text("Add New Product"),
                      dense: true,
                    ),
                  ),
                  SizedBox(height: 10,),
                  prodState.productsWithoutCollections == null || prodState.productsWithoutCollections!.isEmpty ? Container():Container(
                    // height: 100,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: (){
                        nextScreen(context, AddBusinessCollection());
                      },
                      leading: Container(
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Icon(LineIcons.plusCircle),
                        ),
                      ),
                      title: Text("Add New Collection"),
                      dense: true,
                    ),
                  ),
                  SizedBox(height: 20,),
                  prodState.productWithCollection == null ? CupertinoActivityIndicator(): prodState.productWithCollection!.isEmpty ? Container():ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (ctx,i){
                      return Divider(color: Colors.black,);
                    },
                    itemCount: prodState.productWithCollection!.length,
                    itemBuilder: (context,index){
                      var coll = prodState.productWithCollection?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(coll!.collectionName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                  IconButton(onPressed: (){
                                    showDialog(context: context, builder: (ctx){
                                      return  CupertinoAlertDialog(
                                        title: Text("Do you want to Delete this Collection?"),
                                        content: Text("Deleting Collection will be permanent remove"),
                                        actions: [
                                          CupertinoDialogAction(child: Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                                          CupertinoDialogAction(child: Text("Delete",style: TextStyle(color: Colors.red),),onPressed: (){
                                            bloc.deletCollection(coll.collectionId!, authB.userID!, authB.accesToken!);
                                            Navigator.pop(context);
                                          },),
                                        ],
                                      );
                                    });
                                  }, icon: Icon(LineIcons.trash)),
                                ],
                              )
                            ],
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: coll.products!.length,
                            itemBuilder: (ctx,i){
                              var it = coll.products?[i];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      nextScreen(context, ViewMyBusinessProduct(index: index,isWithoutCollection: false,collIndex: i,));
                                      // nextScreen(context, OtherProductDetails(index: index,productIndex: i,));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height:80,
                                                width:100,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(it!.images == null || it.images!.isEmpty? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${it!.images?[0].imageUrl}")
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 5,),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(it.productName!),
                                                ExpandableText(
                                                  it.productdescription!,
                                                  expandText: 'show more',
                                                  collapseText: 'show less',
                                                  maxLines: 3,
                                                  linkColor: Colors.blue,
                                                ),
                                                // Text(it.productPrice),
                                                SizedBox(
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text("\$${it.productPrice!}"),
                                              TextButton(onPressed: (){}, child: Text("Remove"))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                  prodState.productsWithoutCollections == null ? CupertinoActivityIndicator():prodState.productsWithoutCollections!.isEmpty ? Container():Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("All Products",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: prodState.productsWithoutCollections!.length,
                        itemBuilder: (ctx,i){
                          var it = prodState.productsWithoutCollections?[i];
                          return InkWell(
                            onTap: (){
                              nextScreen(context, ViewMyBusinessProduct(index: i,isWithoutCollection: true,));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
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
                                                image: NetworkImage(it!.images == null || it!.images!.isEmpty ?"https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg": "${Utils.baseImageUrl}${it!.images?[0].imageUrl}")
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(it.productName!),
                                        // Row(
                                        //   children: [
                                        //     Expanded(child: Text(it.productdescription!,style: TextStyle(fontSize: 12,color: Colors.grey),)),
                                        //   ],
                                        // ),
                                        ExpandableText(
                                          it.productdescription!,
                                          expandText: 'show more',
                                          collapseText: 'show less',
                                          maxLines: 3,
                                          linkColor: Colors.blue,
                                        ),
                                        // Text(it.productPrice),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("\$${it.productPrice!}")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  },
),
        );
      },
    );
  }
}
