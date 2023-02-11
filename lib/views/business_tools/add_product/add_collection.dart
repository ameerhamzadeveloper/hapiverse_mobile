import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/components/universal_card.dart';

class AddBusinessCollection extends StatefulWidget {
  const AddBusinessCollection({Key? key}) : super(key: key);
  @override
  _AddBusinessCollectionState createState() => _AddBusinessCollectionState();
}

class _AddBusinessCollectionState extends State<AddBusinessCollection> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchProductsWithoutCollections(authB.accesToken!, authB.userID!);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Collection"),
        actions: [
          TextButton(onPressed: state.isDoneAvail  && state.collName != null && state.collName!.isNotEmpty ?(){
            bloc.addCollection(authB.userID!, authB.accesToken!, context);
          }:null, child: Text("Save",style: TextStyle(color: state.isDoneAvail  && state.collName != null && state.collName!.isNotEmpty ? kSecendoryColor :Colors.grey),))
        ],
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Optimize your products for better sales",style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Text("Create Collection to make your products easier to find and your products more interesting to browse",style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              TextField(
                onChanged: (val){
                  bloc.assignCollName(val);
                },
                decoration: InputDecoration(
                  hintText: "Collection Name"
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Choose Product"),
                  TextButton(onPressed: (){
                    state.isSelectedAll ? bloc.selectDeselectAllProductForCollection(1) : bloc.selectDeselectAllProductForCollection(0);
                  }, child: Text( state.isSelectedAll ? "Deselect All":"Select all"))
                ],
              ),
              const SizedBox(height: 10,),
              state.productsWithoutCollections == null ? Center( child: CupertinoActivityIndicator(),):state.productsWithoutCollections!.isEmpty ?  Center(
                child: Column(
                  children: [
                    Text("Field to load products"),
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
                      onTap: ()=> bloc.checkProductForCollection(i),
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
      ),
    );
  },
);
  }
}
