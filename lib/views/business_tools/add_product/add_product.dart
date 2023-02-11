import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/business_tools/add_product/preview_product_image.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Product"),
            actions: [
              TextButton(onPressed: state.addProductImages == null || state.productName == null || state.productName!.isEmpty || state.productPrice == null || state.productPrice!.isEmpty ||state.productDescription == null || state.productDescription!.isEmpty ? null :() {
                bloc.addProducts(authB.userID!, authB.accesToken!,context);
                print("sfdfdf");
              },
                  child: Text(
                    "Save", style: TextStyle(color:state.addProductImages == null || state.productName == null || state.productName!.isEmpty || state.productPrice == null || state.productPrice!.isEmpty ||state.productDescription == null || state.productDescription!.isEmpty ?  Colors.grey:kSecendoryColor),))
            ],
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  state.addProductImagesWidget == null || state.addProductImagesWidget!.isEmpty ? InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){
                                        bloc.pickProductImage(1);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.camera),
                                          SizedBox(width: 10,),
                                          Text("Camera")
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    MaterialButton(
                                      onPressed: () {
                                        bloc.pickProductImage(2);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(LineIcons.image),
                                          SizedBox(width: 10,),
                                          Text("Gallary")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      height: getHeight(context) / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200]
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LineIcons.camera),
                            SizedBox(width: 5,),
                            Text("Add Images"),
                          ],
                        ),
                      ),
                    ),
                  ):
            CarouselSlider(
            options: CarouselOptions(height: getHeight(context) / 4,aspectRatio: 16/9,
            viewportFraction: 0.9,enableInfiniteScroll: false,),
          items: List.generate(state.addProductImagesWidget!.length, (index){
            return InkWell(
              onTap: (){
                if(index != state.addProductImages!.length){
                  nextScreen(context, PreviewProductAddImage(index: index));
                }else{
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: (){
                                    bloc.pickProductImage(1);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(LineIcons.camera),
                                      SizedBox(width: 10,),
                                      Text("Camera")
                                    ],
                                  ),
                                ),
                                Divider(),
                                MaterialButton(
                                  onPressed: () {
                                    bloc.pickProductImage(2);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(LineIcons.image),
                                      SizedBox(width: 10,),
                                      Text("Gallary")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }

              },
              child: Padding(
                  padding:EdgeInsets.all(8.0),
                  child: state.addProductImagesWidget![index]),
            );
          })
        ),
                  Divider(),
                  SizedBox(height: 10,),
                  TextField(
                    onChanged: (v){
                      bloc.assignProductVal(1, v);
                    },
                    decoration: InputDecoration(
                        hintText: "Product Name"
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (v){
                      bloc.assignProductVal(2, v);
                    },
                    decoration: InputDecoration(
                        hintText: "Product Price",
                        // prefixIcon: Icon(LineIcons.dollarSign),
                        prefix: Text("\$")
                    ),
                  ),
                  TextField(
                    maxLines: 4,
                    onChanged: (v){
                      bloc.assignProductVal(3, v);
                    },
                    decoration: InputDecoration(
                        hintText: "Product Description"
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
