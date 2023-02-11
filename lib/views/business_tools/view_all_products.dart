import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/business_tools/product_details.dart';
import '../../views/components/universal_card.dart';

class ViewAllOtherProducts extends StatefulWidget {
  const ViewAllOtherProducts({Key? key}) : super(key: key);

  @override
  _ViewAllOtherProductsState createState() => _ViewAllOtherProductsState();
}

class _ViewAllOtherProductsState extends State<ViewAllOtherProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: UniversalCard(
        widget: ListView.separated(
          separatorBuilder: (ctx,i){
            return Divider(color: Colors.black,);
          },
          itemCount: state.otherProductWithCollection!.length,
          itemBuilder: (context,index){
            var d = state.otherProductWithCollection![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d.collectionName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                d.products!.isEmpty ? Center(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("No Products In This Collection"),
                ),):ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: d.products!.length,
                  itemBuilder: (ctx,i){
                    var it = d.products![i];
                    return InkWell(
                      onTap: (){
                        nextScreen(context, OtherProductDetails(index: i,isFromCollection: true,collecIndex: index,));
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
                                          image: NetworkImage("${Utils.baseImageUrl}${it.images![0].imageUrl!}")
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
                                  Row(
                                    children: [
                                      Expanded(child: Text(it.productdescription!,style: TextStyle(fontSize: 12,color: Colors.grey),)),
                                    ],
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
            );
          },
        )
      ),
    );
  },
);
  }
}
class ProductCollections{
  String collectionName;
  List<ProductModel> productItems;

  ProductCollections({required this.collectionName,required this.productItems});
}
class ProductModel{
  String productName;
  String productPrice;
  String productImage;
  String productDesc;

  ProductModel({required this.productPrice,required this.productName, required this.productDesc, required this.productImage});
}