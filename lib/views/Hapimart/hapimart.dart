import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/Hapimart/product_details.dart';
class Hapimart extends StatefulWidget {
  const Hapimart({Key? key}) : super(key: key);

  @override
  State<Hapimart> createState() => _HapimartState();
}

class _HapimartState extends State<Hapimart> {
  int startFrom = 20;
  int max = 20;

  late ScrollController scrollController;

  void _addListner(){
    print("Listeneer");
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent - 1){
      startFrom = startFrom + 20;
      print(startFrom);
    }
  }

  void getMoreProducts(){
    final bloc = context.read<BusinessProductCubit>();
    bloc.getHapimartProducts(startFrom.toString(), max.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_addListner);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
    builder: (context, state) {
     return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        title: Text("Hapimart",style: TextStyle(color: Colors.black,fontSize: 25),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Business Products for you",style: TextStyle(fontFamily: "",color: Colors.blue),),
              ],
            ),
            SizedBox(height: 10,),
            state.hapimartProduct == null ? Center(child: CupertinoActivityIndicator(),) :
            state.hapimartProduct!.isEmpty ? Center(child: Text("No Products Found"),):GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2),
              ),
              itemCount: state.hapimartProduct!.length,
              itemBuilder: (ctx,i){
                var prod = state.hapimartProduct![i];
                return InkWell(
                  onTap: (){
                    nextScreen(context, ProductDetailsHapimart(index: i,));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 160,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${Utils.baseImageUrl}${prod.images[0].imageUrl}")
                                )
                              ),
                            ),
                            // SizedBox(height: 5,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("\$${prod.productPrice} - ${prod.productName}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),maxLines: 1,),
                            ))
                          ],
                        )
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  },
);
  }
}
