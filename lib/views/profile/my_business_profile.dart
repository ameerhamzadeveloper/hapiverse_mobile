import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happiverse/views/business_tools/events/events.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/config/assets_config.dart';
import '../../views/business_tools/add_product/add_product.dart';
import '../../views/business_tools/product_page.dart';
import '../../views/business_tools/view_all_products.dart';
import '../../views/components/business_profile_about_info.dart';
import '../../views/components/profile_friends_list.dart';
import '../../views/profile/settings/settings.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../components/profile_Images_widget.dart';
import '../components/profile_data_Widget.dart';
import '../components/universal_card.dart';

class MyBusinessProfile extends StatefulWidget {
  const MyBusinessProfile({Key? key}) : super(key: key);

  @override
  _MyBusinessProfileState createState() => _MyBusinessProfileState();
}

class _MyBusinessProfileState extends State<MyBusinessProfile> {
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  DateFormat timeFormat = DateFormat('hh:mm a');
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchMyBusinessProfile(authBloc.userID!, authBloc.accesToken!);
    final bloc2 = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    bloc2.fetchProductsWithoutCollections(authB.accesToken!,authB.userID!, );
    print("Fetecehd");
  }
  @override

  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    final bloc2 = context.read<BusinessProductCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, businessToolState) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: const Text("Business Profile"),
            actions: [
               IconButton(
                 onPressed: () => nextScreen(context, ProfileSettings(isBusiness: true)),
                 icon: const Icon(
                   LineIcons.cog,
                   color: Colors.white,
                 ),
               ),
            ],
          ),
          body: state.businessProfile == null ? UniversalCard(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: ()async{
                    return bloc.fetchMyBusinessProfile(authBloc.userID!, authBloc.accesToken!);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: getWidth(context),),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[200],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey[200],
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.grey[200],
                      )
                    ],
                  ),
                ),
              )):BlocBuilder<BusinessProductCubit, BusinessProductState>(
  builder: (context, prodState) {
    return SingleChildScrollView(
                child: Column( 
                  children: [
                    SizedBox(height: 20,),
                    Card(
            shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      )
            ),
                      child: SingleChildScrollView(
            child: Column(
                      children: [
                        ProfileDataWidet(isMyProfile: true,data: {
                          'name':state.businessProfile!.businessName!,
                          'hobbi':"",
                          'profile_url': "${Utils.baseImageUrl}${state.businessProfile!.logoImageUrl}",
                          'featureImage': "${Utils.baseImageUrl}${state.businessProfile!.featureImageUrl}",
                          'follower': state.businessProfile!.totalFollowers,
                          'following':state.businessProfile!.totalFollowing,
                          'post':state.businessProfile!.totalPosts,
                          'IsFriend':'default',
                        },userId:state.businessProfile!.businessId!,isBusiness: true,),
                        businessToolState.businessEvent == null ? Center(child: CupertinoActivityIndicator(),):
                        businessToolState.businessEvent!.isEmpty ? Container(): Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                          child: Container(
                            height: getHeight(context) / 5.8,
                            width: getWidth(context),
                            padding: const EdgeInsets.all(8.0),
                            child: CarouselSlider(
                              options: CarouselOptions(height: 400.0,autoPlay: true,aspectRatio: 16/9,
                                viewportFraction: 1.0,),
                              items: businessToolState.businessEvent!.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: (){
                                        nextScreen(context, BusinessEvents());
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
                                                          image: NetworkImage(i.images == null || i.images!.isEmpty ? "" :
                                                              "${Utils.baseImageUrl}${i.images![0].imageUrl}",
                                                          )
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 10,),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 200,
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${dateFormat.format(i.eventDate!)} at ${i.eventTime}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
                                                      SizedBox(height: 5,),
                                                      Text("${i.eventName == null ? ''
                                                          : i.eventName!.length > 20 ? '${i.eventName!.substring(0,20)}...':i.eventName!}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                      // SizedBox(height: 10,),
                                                      Text("${i.eventDescription == null ? ''
                                                          : i.eventDescription!.length > 20 ? '${i.eventDescription!.substring(0,20)}...':i.eventDescription!}",style: TextStyle(fontSize: 14,color: Colors.grey),),
                                                      SizedBox(height: 10,),
                                                      Expanded(
                                                        child: OutlinedButton(onPressed: (){
                                                          nextScreen(context, BusinessEvents());
                                                        }, child: Text("See Event")),
                                                      )
                                                    ],
                                                  ),
                                                ),
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
                        ),
                        prodState.productsWithoutCollections == null ? Center( child: CupertinoActivityIndicator(),):prodState.productsWithoutCollections!.isEmpty ? Container():prodState.productsWithoutCollections!.isEmpty ?  Center(
                          child: Column(
                            children: [
                              Text("Field to load products"),
                              MaterialButton(
                                onPressed: (){
                                  bloc2.fetchProductsWithoutCollections(authBloc.accesToken!, authBloc.userID!);
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
                                          nextScreen(context,ProductsPage());
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
                                  itemCount: prodState.productsWithoutCollections!.length > 8 ? 8: prodState.productsWithoutCollections!.length,
                                  itemBuilder: (ctx,i){
                                    var product = prodState.productsWithoutCollections?[i];
                                    return InkWell(
                                      // onTap: ()=> bloc2.checkProductForCollection(i),
                                      child: Container(
                                        height:80,
                                        width:100,
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:product!.images == null || product.images!.isEmpty ?  NetworkImage("https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"):NetworkImage("${Utils.baseImageUrl}${product!.images?[0].imageUrl}")
                                            )
                                        ),
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
                              isMyProfie: true, userId: state.businessProfile!.businessId!,
                              data: {
                                'category': state.businessProfile!.businessType,
                                'Contact': state.businessProfile!.businessContact,
                                'Hours': 'Monday 12:00AM - 8:00PM',
                                'Location': state.businessProfile!.address,
                              },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileFriendsList(isMYProfile: true,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileImagesWidget(isMyProfile: true,),
                        )
                      ],
            ),
          ),
                    ),
                  ],
                ),
              );
  },
),
        );
      },
    );
  },
);
  }
}
