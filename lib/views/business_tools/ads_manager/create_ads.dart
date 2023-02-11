import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/views/business_tools/ads_manager/choose_age.dart';
import 'package:happiverse/views/business_tools/ads_manager/currency_impressions.dart';
import 'package:happiverse/views/business_tools/ads_manager/product_widget_ads.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/feeds/components/book_now_ads_widget.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import 'add_card.dart';

class CreateAds extends StatefulWidget {
  final bool isProduct;
  const CreateAds({Key? key,required this.isProduct}) : super(key: key);
  @override
  _CreateAdsState createState() => _CreateAdsState();
}

class _CreateAdsState extends State<CreateAds> {
  // DateTime d = DateTime.now();
  @override
  void initState() {
    super.initState();
    final bloc = context.read<BusinessProductCubit>();
    bloc.setInitialAdsLcoations();
  }
  DateFormat dF = DateFormat('dd MMM yyyy');
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  DateTime d = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    final profB = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profi) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Ads"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ad Preview"),
                  // TextButton(
                  //   onPressed: (){},
                  //   child: const Text("Edit"),
                  // )
                ],
              ),
              BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, busState) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey)
                  ),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
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
                                          backgroundImage: NetworkImage("${Utils.baseImageUrl}${profi.businessProfile!.logoImageUrl!}"),
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
                                                Text(profi.businessProfile!.businessName ?? "Business Name",style: TextStyle(
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
                                widget.isProduct ? CarouselSlider(items: busState.productsWithoutCollections![busState.productAdsIndex!].images!.map((e){
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
                                AnyLinkPreview(
                                  removeElevation: true,
                                  borderRadius: 0,
                                  link: busState.adsSiteUrl,
                                  displayDirection: UIDirection.uiDirectionVertical,
                                  // showMultimedia: false,
                                  // bodyMaxLines: 5,
                                  bodyTextOverflow: TextOverflow.ellipsis,
                                  errorBody: 'Error While Preview',
                                  errorTitle: 'Error While Preview',
                                  errorWidget: Container(
                                    color: Colors.grey[300],
                                    child: Text('Oops!'),
                                  ),
                                  titleStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  errorImage: _errorImage,
                                  bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                ),

                                // Image.asset("assets/image_loading.jpeg",width:
                                // double.infinity,fit: BoxFit.cover,),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],

                                  ),
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
                ),
              );
  },
),

              // latter stuffs ===============>

              // const Divider(),
              // ListTile(
              //   title: Text("Goal"),
              //   subtitle: Text("What result would you like from this ad?"),
              //   trailing: IconButton(
              //     onPressed: (){},
              //     icon: Icon(LineIcons.infoCircle),
              //   ),
              // ),
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundColor: Colors.grey[300],
              //     child: Icon(LineIcons.shoppingBag),
              //   ),
              //   title: Text("Get more orders"),
              //   subtitle: Text("Show your ad to people who are likely to order your product"),
              //   trailing: Radio(
              //     groupValue: 1,
              //     value: 0,
              //     onChanged: (v){},
              //   ),
              // ),
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundColor: Colors.grey[300],
              //     child: Icon(LineIcons.handPointingUp),
              //   ),
              //   title: Text("Get more website visitors"),
              //   subtitle: Text("Show your ad to people who are likely to click on URL in it"),
              //   trailing: Radio(
              //     groupValue: 1,
              //     value: 0,
              //     onChanged: (v){},
              //   ),
              // ),
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundColor: Colors.grey[300],
              //     child: Icon(LineIcons.history),
              //   ),
              //   title: Text("Get more order from story"),
              //   subtitle: Text("Show your ad to people who are likely to order from story"),
              //   trailing: Radio(
              //     groupValue: 1,
              //     value: 0,
              //     onChanged: (v){},
              //   ),
              // ),
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundColor: Colors.grey[300],
              //     child: Icon(LineIcons.eye),
              //   ),
              //   title: Text("Get more views"),
              //   subtitle: Text("Show your ad to people who are likely to see your post"),
              //   trailing: Radio(
              //     groupValue: 1,
              //     value: 0,
              //     onChanged: (v){},
              //   ),
              // ),
              const Divider(),
              ListTile(
                title: const Text("Audience"),
                trailing: IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                        ),
                        context: context, builder: (c){
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.white,)),
                                Text("Audience",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear))
                              ],
                            ),
                            Divider(),
                            Text("Choose age group which will be apply on age terms")
                          ],
                        ),
                      );
                    });
                  },
                  icon: const Icon(LineIcons.infoCircle),
                ),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left:12.0),
                    child: Text("People you choose through targeting"),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                color: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Locations : ",style: TextStyle(fontSize: 16,color: Colors.blue),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Wrap(
                        children: state.locations!.map((e){
                          return Text("$e , ",style: TextStyle(fontSize: 16),);
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        // title: Text("Location: United States, Pakistan"),
                        title: Text("Age: ${state.audianceAge}"),
                        trailing: TextButton(
                          onPressed: (){
                            nextScreen(context, ChoseAdsAge());
                          },
                          child: Text("Edit"),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Total Budget"),
                trailing: IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                        ),
                        context: context, builder: (c){
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.white,)),
                                Text("Total Budget",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear))
                              ],
                            ),
                            Divider(),
                            Text("Add you budget and impressions")
                          ],
                        ),
                      );
                    });
                  },
                  icon: Icon(LineIcons.infoCircle),
                ),
              ),
              ListTile(
                title: Text(state.adsCurency!),
                subtitle: Text(state.adsCurrencylocation!),
                trailing: TextButton(
                  onPressed: (){
                    nextScreen(context, CurrencyImpressions());
                  },
                  child: Text("Edit"),
                ),
              ),
              ListTile(
                title: Text("${state.adsCurency!} ${state.adsAmount}"),
                subtitle: Text("${NumberFormat.compact().format(int.parse(state.adsImpressions!))} - ${NumberFormat.compact().format(int.parse(state.adsImpressions!) + 1000)} impressions"),
                trailing: TextButton(
                  child: Text("Edit"),
                  onPressed: (){
                    nextScreen(context, CurrencyImpressions());
                  },
                )
              ),
              Divider(),
              ListTile(
                title: Text("Schedule"),
                trailing: IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                        ),
                        context: context, builder: (c){
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.white,)),
                                Text("Schedule",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear))
                              ],
                            ),
                            Divider(),
                            Text("Choose how long to run this ad for. you can pause it at any time")
                          ],
                        ),
                      );
                    });
                  },
                  icon: Icon(LineIcons.infoCircle),
                ),
              ),
              ListTile(
                leading: Icon(LineIcons.calendar),
                title: Text(state.adsStartDate == null ? "${dF.format(d)} - ${dF.format(DateTime(d.year,d.month + 1,d.day))}" : "${dF.format(state.adsStartDate!)} - ${dF.format(state.adsEndDate!)}"),
                trailing: TextButton(
                  onPressed: ()async{
                    DateTimeRange? result = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(), // the earliest allowable
                      lastDate: DateTime(2030, 12, 31), // the latest allowable
                      currentDate: DateTime.now(),
                      saveText: 'Done',
                    );
                    if(result != null){
                      bloc.setAdsDate(result.start, result.end);
                    }

                  },
                  child: Text("Edit"),
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Payment Account"),
                trailing: IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                        ),
                        context: context, builder: (c){
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.white,)),
                                Text("Payment Account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear))
                              ],
                            ),
                            Divider(),
                            Text("You will be charge from the current payment method you choosed")
                          ],
                        ),
                      );
                    });
                  },
                  icon: Icon(LineIcons.infoCircle),
                ),
              ),
              profi.paymentCards == null ? Center(child: CircularProgressIndicator(),):
              profi.paymentCards!.isEmpty ? Center(child: const ListTile(
                leading: Icon(LineIcons.creditCard),
                title: Text("No Payment Account"),
              ),):SizedBox(
                height: 200,
                width: getWidth(context),
                child: ListView.builder(
                  shrinkWrap:true,
                  itemBuilder: (c,i){
                    var card = profi.paymentCards![i];
                    return ListTile(
                      title: Text("**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4,card.cardNumber.length)}"),
                      subtitle: Text(card.cardHolderName),
                      leading: const Icon(Icons.credit_card),
                      trailing: Radio<bool>(
                        groupValue: true,
                        value: card.isSelected,
                        onChanged: (v){
                          print(i);
                          profB.selectPaymenCard(i);
                        },
                      ),
                    );
                  },
                  itemCount: profi.paymentCards!.length,
                ),
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: (){
                  nextScreen(context, AddCardBusiness());
                },
                color: Colors.grey[300],
                child: Text("Add Payment Account",),
              ),
              Divider(),
              ListTile(
                title: Text("Ad Summary"),
                trailing: IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )
                      ),
                        context: context, builder: (c){
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.white,)),
                                Text("Ad Summary",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear))
                              ],
                            ),
                            Divider(),
                            Text("Total Calculations of ad after choosing impressions count")
                          ],
                        ),
                      );
                    });
                  },
                  icon: const Icon(LineIcons.infoCircle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Budget"),
                    Text("${state.adsCurency!} ${state.adsAmount}",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Impressions"),
                    Text("${NumberFormat.compact().format(int.parse(state.adsImpressions!))} - ${NumberFormat.compact().format(int.parse(state.adsImpressions!) + 1000)}",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SecendoryButton(text: "Create Ad", onPressed: (){
                if(profi.paymentCards == null || profi.paymentCards!.isEmpty){
                  showDialog(context: context,
                      // barrierDismissible: false,
                      builder: (ctx){
                        return  AlertDialog(
                          title: Text("Please Select Payment Method"),
                          actions: [
                            CupertinoDialogAction(child: Text("Done"),onPressed: (){},)
                          ],
                        );
                      });
                }else{
                  for(var i in profi.paymentCards!){
                    if(i.isSelected){
                      bloc.stripePaymentSignUp(state.adsAmount!, context, {
                        'card_no': i.cardNumber,
                        'expiry_month':i.expiryMonth,
                        'expiry_year': i.expiryYear,
                        'cvv': i.cvc,
                        'name': i.cardHolderName,
                      },
                          authBloc.userID!, authBloc.accesToken!);
                    }
                  }

                }
              })
            ],
          ),
        ),
      ),
    );
  },
);
  },
);
  }
}
