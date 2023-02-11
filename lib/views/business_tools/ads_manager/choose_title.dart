import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/utils.dart';
import '../../../views/business_tools/ads_manager/create_ads.dart';
import '../../../views/components/secondry_button.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';
class ChooseTitle extends StatefulWidget {
  final bool isProduct;

  const ChooseTitle({Key? key,required this.isProduct}) : super(key: key);
  @override
  _ChooseTitleState createState() => _ChooseTitleState();
}

class _ChooseTitleState extends State<ChooseTitle> {
  String title = 'Title Goes here';
  String siteUrl = 'site.abc';
  String description = 'Description goes here';
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ads Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, busState) {
    return Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.businessProfile!.logoImageUrl!}"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(state.businessProfile!.businessName ?? "Business Name",style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("🌎",style: TextStyle(fontSize: 12),),
                                        SizedBox(width: 5,),
                                        Text(
                                          "Suponsored",
                                          style: TextStyle(color: kSecendoryColor,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_sharp))
                          ],
                        ),
                        Text(busState.adsDescription,style: TextStyle(color: Colors.black87,fontFamily: ''),),
                        // SizedBox(height: 5,),
                        Divider(),
                        widget.isProduct ?
                        CarouselSlider(items: busState.productsWithoutCollections![busState.productAdsIndex!].images!.map((e){
                          return InkWell(
                            onTap: (){
                              // nextScreen(context, ViewOtherProductImages(isFromCollection: widget.isFromCollection,index: widget.index,collecIndex: widget.collecIndex,));
                            },
                            child: Container(
                              height: getHeight(context) / 3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${Utils.baseImageUrl}${e.imageUrl}")
                                  )
                              ),
                            ),
                          );
                        }).toList() , options: CarouselOptions(
                            autoPlay: false,enableInfiniteScroll: false,
                            viewportFraction: 1.0,height: getHeight(context) / 3)):
                        Image.asset("assets/image_loading.jpeg",width:
                          double.infinity,fit: BoxFit.cover,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey[300],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.isProduct ? Container():Text(busState.adsSiteUrl),
                              Row(
                                children: [
                                  Expanded(child: Text(widget.isProduct ? busState.productsWithoutCollections![busState.productAdsIndex!].productName!:busState.adsTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                                  OutlinedButton(onPressed: (){}, child: Text(widget.isProduct ? "ORDER NOW" : "LEARN MORE"))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){},
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(
                                      LineIcons.thumbsUpAlt,
                                      color: 1 == 1 ? kUniversalColor : Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  NumberFormat.compact().format(int.parse("232344")),
                                  style: TextStyle(color:1 == 2 ? kUniversalColor : Colors.grey),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(postId: "postId",userId: 'userId',)));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(
                                      LineIcons.facebookMessenger,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  NumberFormat.compact().format(int.parse("2332")),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: (){
                                // Share.share("https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  LineIcons.share,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
  },
),
              SizedBox(height: 20,),
              widget.isProduct ? Container():TextField(
                onChanged: (va){
                  bloc.assignAdsVal(2, va);
                },
                decoration: InputDecoration(
                    hintText: "Ads Title"
                ),
              ),
              TextField(
                maxLines: 4,
                // maxLength: 46,
                onChanged: (va){
                  bloc.assignAdsVal(3, va);
                },
                decoration: InputDecoration(
                    hintText: "Ads Description"
                ),
              ),
              widget.isProduct ? Container():TextField(
                maxLength: 38,
                onChanged: (v){
                  bloc.assignAdsVal(1, v);
                },
                decoration: InputDecoration(
                    hintText: "Site URL"
                ),
              ),
              SizedBox(height: 20,),
              SecendoryButton(text: "Next", onPressed: ()=> nextScreen(context, CreateAds(isProduct: widget.isProduct,)))
            ],
          );
  },
),
        ),
      ),
    );
  },
);
  }
}
