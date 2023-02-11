import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../views/profile/see_other_business_events.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../business_tools/product_details.dart';
import '../business_tools/product_page.dart';
import '../business_tools/view_all_products.dart';
import '../components/business_profile_about_info.dart';
import '../components/profile_Images_widget.dart';
import '../components/profile_data_Widget.dart';
import '../components/profile_friends_list.dart';
import '../components/universal_card.dart';

class OtherBusinessProfile extends StatefulWidget {
  final String businessId;
  const OtherBusinessProfile({Key? key,required this.businessId}) : super(key: key);

  @override
  _OtherBusinessProfileState createState() => _OtherBusinessProfileState();
}

class _OtherBusinessProfileState extends State<OtherBusinessProfile> {

  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  DateFormat timeFormat = DateFormat('hh:mm a');

  @override
  void initState() {
    super.initState();
    final bussBloc = context.read<BusinessProductCubit>();
    final authBloc = context.read<RegisterCubit>();
    bussBloc.fetchOtherProductsWithoutCollections(authBloc.accesToken!, authBloc.userID!, widget.businessId);
    bussBloc.fetchOtherProductWithCollection( authBloc.userID!, authBloc.accesToken!,widget.businessId);
    bussBloc.fetchOtherBusinessEvent(authBloc.userID!,authBloc.accesToken!, widget.businessId);
  }
  @override
  Widget build(BuildContext context) {
    final bussBloc = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state.otherBusinessProfile == null) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: UniversalCard(
                      widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getWidth(context),
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey[200],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          color: Colors.grey[200],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.grey[200],
                        )
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
        );
      } else {
        // var json = jsonDecode(state.otherProfileInfoResponse!.body);
        // var d = json['data'];
        // print(d);
        // print(d);
        return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, bussState) {
    return Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              title: const Text("Business Profile",style: TextStyle(color: Colors.black),),
            ),
            body: SafeArea(
                child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileDataWidet(
                              isMyProfile: false,
                              data: {
                                'name':
                                    state.otherBusinessProfile!.businessName!,
                                'hobbi': "Rating",
                                'profile_url':
                                    "${Utils.baseImageUrl}${state.otherBusinessProfile!.logoImageUrl}",
                                'follower':
                                    state.otherBusinessProfile!.totalFollowers,
                                'following':
                                    state.otherBusinessProfile!.totalFollowing,
                                'post': state.otherBusinessProfile!.totalPosts,
                                'IsFriend': state.otherBusinessProfile!.isFriend,
                              },
                              userId: state.otherBusinessProfile!.businessId!,
                            isBusiness: true,),
                          bussState.otherBusinessEvent == null ? Center(child: CupertinoActivityIndicator(),):
                          bussState.otherBusinessEvent!.isEmpty ? Container(): Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Events",style: TextStyle(fontSize: 18),),
                                      Row(
                                        children: [
                                          TextButton(onPressed: (){
                                            nextScreen(context,SeeOtherBusinessEvents());
                                          }, child: Text("See All")),
                                          Icon(Icons.arrow_forward_ios_rounded,size: 14,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: getHeight(context) / 6,
                                  width: getWidth(context),
                                  padding: const EdgeInsets.all(8.0),
                                  child: CarouselSlider(
                                    options: CarouselOptions(height: 400.0,autoPlay: true,aspectRatio: 16/9,
                                      viewportFraction: 1.0,),
                                    items: bussState.otherBusinessEvent!.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return InkWell(
                                            onTap: (){
                                              nextScreen(context,SeeOtherBusinessEvents());
                                            },
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                elevation: 5.0,
                                                // width: MediaQuery.of(context).size.width,
                                                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                                // decoration: BoxDecoration(
                                                //     color: Colors.amber
                                                // ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:8.0),
                                                          child: Container(
                                                            height:100,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                image: DecorationImage(
                                                                    fit: BoxFit.cover,
                                                                    image: NetworkImage(
                                                                      "${Utils.baseImageUrl}${i.images![0].imageUrl}",
                                                                    )
                                                                )
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("${dateFormat.format(i.eventDate!)} at ${i.eventTime}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
                                                        Text(i.eventName!.length > 25 ? i.eventName!.substring(0,25) : i.eventName.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                        Container(
                                                          width: getWidth(context)/ 1.8,
                                                          child: ListTile(
                                                            contentPadding: const EdgeInsets.all(0),
                                                            subtitle: Text(i.eventDescription!,style: TextStyle(fontSize: 14,color: Colors.grey),),
                                                          ),
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     OutlinedButton(onPressed: (){}, child: Text("Edit Event")),
                                                        //     IconButton(onPressed: (){}, icon: Icon(LineIcons.trash,color: Colors.red,)),
                                                        //   ],
                                                        // )
                                                      ],
                                                    )
                                                  ],
                                                )
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bussState.otherProductsWithoutCollections == null ? Center( child: CupertinoActivityIndicator(),):bussState.otherProductsWithoutCollections!.isEmpty ? Container():bussState.otherProductsWithoutCollections!.isEmpty ?  Center(
                            child: Column(
                              children: [
                                Text("Field to load products"),
                                MaterialButton(
                                  onPressed: (){
                                    bussBloc.fetchOtherProductsWithoutCollections(authB.accesToken!, authB.userID!,widget.businessId);
                                  },
                                  child: Text("Try Again"),
                                )
                              ],
                            ),
                          ):
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Products",style: TextStyle(fontSize: 18),),
                                      Row(
                                        children: [
                                          TextButton(onPressed: (){
                                            nextScreen(context,ViewAllOtherProducts());
                                          }, child: Text("See All")),
                                          Icon(Icons.arrow_forward_ios_rounded,size: 14,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 100,
                                      childAspectRatio: 1/1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: bussState.otherProductsWithoutCollections!.length > 8 ? 8: bussState.otherProductsWithoutCollections!.length,
                                    itemBuilder: (ctx,i){
                                      var product = bussState.otherProductsWithoutCollections?[i];
                                      return InkWell(
                                        onTap: (){
                                          nextScreen(context, OtherProductDetails(index: i,isFromCollection: false,));
                                        },
                                        // onTap: ()=> bloc2.checkProductForCollection(i),
                                        child: Container(
                                          height:80,
                                          width:100,
                                          decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.black),
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage( product!.images == null || product!.images!.isEmpty ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${product!.images?[0].imageUrl}")
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BusinessProfileAboutInfo(
                              isMyProfie: false,
                              userId: state.otherBusinessProfile!.businessId!,
                              data: {
                                'category':
                                    state.otherBusinessProfile!.businessType,
                                'Contact':
                                    state.otherBusinessProfile!.businessContact,
                                'Hours': 'Monday 12:00AM - 8:0sds0PM',
                                'Location': state.otherBusinessProfile!.address,
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ProfileFriendsList(
                              isMYProfile: false,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ProfileImagesWidget(
                              isMyProfile: false,
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ])));
  },
);
      }
    });
  }
}
