import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/components/preview_profile_avatar.dart';
import 'package:happiverse/views/profile/edit_profile/edit_business_profile.dart';
import 'package:happiverse/views/profile/see_followers.dart';
import '../../logic/business_product/business_product_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/config/assets_config.dart';
import '../../views/chat/conservation.dart';
import '../../views/components/secondry_button.dart';
import '../../views/profile/components/clip_path.dart';
import '../../views/profile/other_profile_more.dart';
import '../../views/profile/photo_album/images_albumbs.dart';
import '../../views/profile/see_profile_image.dart';
import '../../views/profile/sharing_location.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../logic/feeds/feeds_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../profile/add_examp_page.dart';
import '../profile/profile_more/business_profile_more.dart';
import '../profile/profile_more/profile_more.dart';

class ProfileDataWidet extends StatelessWidget {
  final bool isMyProfile;
  Map<String, dynamic> data;
  String userId;
  bool isBusiness;
  ProfileDataWidet({Key? key,required this.userId,required this.isMyProfile,required this.data,required this.isBusiness}) : super(key: key);

   getColors(int i){
    switch(i){
      case 1:
        return Colors.blue;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.deepOrangeAccent;
      case 4:
        return Colors.green;
      case 5:
        return Colors.yellowAccent;
    }
  }

   getBadges(int i){
     print(i);
     switch(i){
       case 1:
         return "assets/plans/Gold.png";
       case 2:
         return "assets/plans/Platinum.png";
       case 3:
         return "assets/plans/Diamond.png";
       case 4:
         return "assets/plans/Vip.png";
       case 5:
         return "assets/plans/Gold.png";
       case 6:
         return "assets/plans/Gold.png";
       case 7:
         return "assets/plans/Gold.png";
       case 8:
         return "assets/plans/Gold.png";
       default:
         return "assets/plans/Gold.png";
     }
  }
  @override
  Widget build(BuildContext context) {
    DateFormat dateFomat=DateFormat('dd MMM yyyy');
    String rating = '2.5';
    bool isFollowed = false;
    String commnet = "";
    final feedBloc = context.read<FeedsCubit>();
    final authBloc = context.read<RegisterCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final businessToolBloc = context.read<BusinessProductCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Container(
      width: getWidth(context),
      height: isBusiness ? getHeight(context) / 2.5 :getHeight(context) / 4.0,
      child: Stack(
        children: [
         isBusiness ? state.businessProfile == null ? Container(): ClipPath(
            clipper: ProfileClipPath(),
            child: InkWell(
              onTap: (){
                nextScreen(context, SeeProfileImage(imageUrl:state.businessProfile!.featureImageUrl == '' ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${Utils.baseImageUrl}${state.businessProfile!.featureImageUrl!}",title: "Business Cover",));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: kUniversalColor,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(state.businessProfile!.featureImageUrl == '' ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg":"${data['featureImage']}")
                  )
                ),
              ),
            ),
          ):Container(),
          Positioned(
            left: 20,
            top: isBusiness ? 120:0,
            right: 20,
            child: Card(
              elevation: isBusiness ? 3.0 : 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        if(!isBusiness) {
                          nextScreen(context, PreviewProfileAvatar(
                              flatColor: data['flatColor'] ?? "0",
                              avatarType: data['avatarType'],
                              text: data['profileImageText'],
                              gredient1: data['firstgredientcolor'],
                              gredient2: data['secondgredientcolor'],
                              profileUrl: data['profile_url']));
                        }// nextScreen(context, SeeProfileImage(imageUrl: data['profile_url'],title: data['name'],));
                      },
                      child:isBusiness ? CircleAvatar(radius: 35,backgroundImage: NetworkImage(data['profile_url']),): data['avatarType']  == "0"? CircleAvatar(radius: 35,backgroundImage: NetworkImage(data['profile_url']),):
                      data['avatarType']  == "1" ? InkWell(
                        onTap: (){
                          nextScreen(context, PreviewProfileAvatar(flatColor: data['flatColor'], avatarType: data['avatarType'], text: data['profileImageText'], gredient1: data['firstgredientcolor'], gredient2: data['secondgredientcolor'], profileUrl: data['profile_url']));
                        },
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              Center(
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 8,
                                              color: getColors(int.parse(data['flatColor'])).withOpacity(0.8)
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(data['profile_url'])
                                          )
                                      ),
                                    ),
                                  )
                              ),
                               data['profileImageText'] == null ? Container():Center(
                                child: CircularText(
                                  children: [
                                    TextItem(
                                      text: Text(
                                        data['profileImageText'].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      space: 10,
                                      startAngle: 90,
                                      startAngleAlignment: StartAngleAlignment.center,
                                      direction: CircularTextDirection.anticlockwise,
                                    ),
                                  ],
                                  radius: 35,
                                  position: CircularTextPosition.inside,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ): InkWell(
                        onTap: (){
                          nextScreen(context, PreviewProfileAvatar(flatColor: data['flatColor'], avatarType: data['avatarType'], text: data['profileImageText'], gredient1: data['firstgredientcolor'], gredient2: data['secondgredientcolor'], profileUrl: data['profile_url']));
                        },
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              Center(
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: [
                                                getColors(int.parse(data['firstgredientcolor'])),
                                                getColors(int.parse(data['secondgredientcolor'])),
                                              ]
                                          )
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(data['profile_url'])
                                            )
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                              Center(
                                child: CircularText(
                                  children: [
                                    TextItem(
                                      text: Text(
                                        data['profileImageText'] == null ?"": data['profileImageText'].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      space: 10,
                                      startAngle: 90,
                                      startAngleAlignment: StartAngleAlignment.center,
                                      direction: CircularTextDirection.anticlockwise,
                                    ),
                                  ],
                                  radius: 35,
                                  position: CircularTextPosition.inside,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ) ,
                    const SizedBox(height: 25,),
                    Row(
                      children: [
                        Text(data['name'],style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                        SizedBox(width: 5,),
                        data['hasVerified']  == '1'? Image.asset(AssetConfig.verified,height: 22,):Container()
                      ],
                    ),
                    SizedBox(height: 3,),
                    isBusiness ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                RatingBarIndicator(
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                     itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  rating: state.businessRating == null ? 0 :state.businessRating!.avergeRating ?? 0,
                                  itemCount: 5,
                                ),
                                SizedBox(width: 5,),
                                Text(state.businessRating == null ? '0' : state.businessRating!.avergeRating.toString().length > 3 ? state.businessRating!.avergeRating.toString().substring(0,3) : state.businessRating!.avergeRating.toString(),style: TextStyle(fontSize: 18,fontFamily: ''),),
                                SizedBox(width: 3,),
                                Text("(${state.businessRating == null ? '0' :state.businessRating!.totalRating.toString()})",style: TextStyle(fontSize: 18,color: Colors.grey,fontFamily: ''),),
                              ],
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    context: context, builder: (context){
                                  return StatefulBuilder(
                                      builder: (context,stat) {
                                        return Container(
                                          height: getHeight(context),
                                          padding: const EdgeInsets.all(8),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text("Rating Overview",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                                                SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(state.businessRating!.avergeRating.toString().length > 3 ? state.businessRating!.avergeRating.toString().substring(0,3) : state.businessRating!.avergeRating.toString(),style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: '')),
                                                    Text('/5',style: TextStyle(fontFamily: ''),)
                                                  ],
                                                ),
                                                RatingBarIndicator(
                                                  rating: double.parse(state.businessRating!.avergeRating.toString()),
                                                  itemBuilder: (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 50.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                Text("${state.businessRating!.totalRating} Total Reviews"),
                                                const SizedBox(height: 20),
                                                ListView.separated(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: state.businessRating!.reviews!.length,
                                                  separatorBuilder: (ctx,i){
                                                    return const Divider(color: Colors.black,);
                                                  },
                                                  itemBuilder: (ctx,i){
                                                    return Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                state.businessRating!.reviews![i].profileImageUrl ?? "",
                                                              ),
                                                              // radius: 20,
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(state.businessRating!.reviews![i].userName!,style: TextStyle(fontSize: 16),),
                                                            RatingBarIndicator(
                                                              rating: double.parse(state.businessRating!.reviews![i].rating!),
                                                              itemBuilder: (context, index) => Icon(
                                                                Icons.star,
                                                                color: Colors.amber,
                                                              ),
                                                              itemCount: 5,
                                                              itemSize: 20.0,
                                                              direction: Axis.horizontal,
                                                            ),
                                                            // SizedBox(height: 5,),
                                                            SizedBox(
                                                              width:getWidth(context) - 100,
                                                              child: ListTile(
                                                                title: Text(state.businessRating!.reviews![i].comment!,style: TextStyle(fontSize: 12,color: Colors.grey,fontStyle: FontStyle.italic),maxLines: 5,),
                                                                subtitle: Text(dateFomat.format(state.businessRating!.reviews![i].addDate!).toString(),style: TextStyle(fontSize: 12,color: Colors.grey),),
                                                                contentPadding: EdgeInsets.zero,
                                                                minVerticalPadding: 0,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                });
                              },
                              child: Text("See All",style: TextStyle(color: Colors.grey),)),
                          ],
                        ),
                        SizedBox(height: 5,),
                        isMyProfile ? Container(): Row(
                          children: [
                            InkWell(
                              onTap:(){
                                showModalBottomSheet(
                                  enableDrag: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    isScrollControlled:true,
                                    context: context, builder: (context){
                                      return StatefulBuilder(
                                        builder: (context,stat) {
                                          return Container(
                                            height: getHeight(context)/1.2,
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text("How was your overall experience?",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Text("It will help us to serve you better"),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                            Text(rating,style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: '')),
                                            RatingBar.builder(
                                              initialRating: state.businessRatingValue,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (ratingg) {
                                                print(rating);
                                                profileBloc.updateRating(ratingg);
                                                stat((){
                                                  rating = ratingg.toString();
                                                });
                                              },
                                            ),
                                                Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Wrap(
                                                    children: [
                                                      TextField(

                                                        onChanged: (v){
                                                          commnet = v;
                                                        },
                                                        keyboardType: TextInputType.text,
                                                        maxLines: 4,
                                                        decoration: InputDecoration(
                                                            hintText: "Write Feedback"
                                                        ),
                                                        autofocus: true,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SecendoryButton(text: "Submit", onPressed: (){
                                                  businessToolBloc.addBusinessRating(authBloc.userID!, authBloc.accesToken!, userId, state.businessRatingValue.toString(), commnet,context);
                                                  Future.delayed(Duration(seconds: 1),(){
                                                    profileBloc.fetchBusinessRating(authBloc.userID!, authBloc.accesToken!,userId);
                                                  });
                                                })
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                });
                              },
                              child: Text("Write a Review",style: TextStyle(color: Colors.blue),)),
                          ],
                        )
                      ],
                    ):Text(data['hobbi']),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: isBusiness ? 100: -15.0 ,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                // width: getWidth(context) / 2.2,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: getWidth(context) / 2.4,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(data['post'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text(getTranslated(context, 'POST')!,style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            onTap: (){
                              nextScreen(context, SeeFollowers(index: 0, isMyProfile: isMyProfile,userName: isMyProfile ? isBusiness ? state.businessProfile!.businessName : state.profileName:data['name'],));
                            },
                            child: Column(
                              children: [
                                Text(NumberFormat.compact().format(int.parse(data['follower'])),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                Text(getTranslated(context, 'FOLLOWERS')!,style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            onTap: (){
                              nextScreen(context, SeeFollowers(index: 0, isMyProfile: isMyProfile,userName: isMyProfile ? isBusiness ? state.businessProfile!.businessName : state.profileName:data['name'],));
                            },
                            child: Column(
                              children: [
                                Text(NumberFormat.compact().format(int.parse(data['following'])),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                Text(getTranslated(context, 'FOLLOWING')!,style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          // isMyProfile ? Image.asset(getBadges(authBloc.planID ?? 1),height: 45,):Container()
                        ],
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isMyProfile ? Row(
                          children: [
                            MaterialButton(
                              height: 25,
                              shape: const StadiumBorder(),
                              color: kSecendoryColor,
                              onPressed: (){
                                if(isBusiness){
                                  nextScreen(context, const EditBusinessProfile());
                                }else{
                                  Navigator.pushNamed(context, editProfile);
                                }
                              },
                              child: Text(getTranslated(context, 'EDIT_PROFILE')!,style: const TextStyle(color: Colors.white),),
                            ),
                            isBusiness && isMyProfile ? InkWell(
                              onTap: (){
                                nextScreen(context, const BusinessProfileMore());
                              },
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: Icon(Icons.keyboard_arrow_down_sharp)),
                              ),
                            ):Container(),
                            isBusiness ? Container() : Row(
                              children: [
                                authBloc.planID == null || authBloc.planID == 5 ? Container(): InkWell(
                                  onTap: (){
                                    nextScreen(context, const SharingLocation());
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                        child: const Icon(Icons.location_on)),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    nextScreen(context, const ProfileMore());
                                  },
                                  child:
                                  SizedBox(
                                    height: 40,
                                    width: 80,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                        child: Center(child: Text("More Info",style: TextStyle(fontSize: 11),))
                                        // Icon(Icons.keyboard_arrow_down_sharp),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ):
                        Row(
                          children: [
                            MaterialButton(
                              height: 25,
                              shape: const StadiumBorder(),
                              color: kSecendoryColor,
                              // onPressed: (){},
                              onPressed: (){
                                profileBloc.addFollow(authBloc.userID!,userId, authBloc.accesToken!,context,authBloc.isBusinessShared! ? true:false);
                              },
                              child: Text(data['IsFriend'],style: const TextStyle(color: Colors.white),),
                            ),
                            const SizedBox(width: 5,),
                            MaterialButton(
                              height: 25,
                              shape: const StadiumBorder(),
                              color: kSecendoryColor,
                              onPressed: (){
                                nextScreen(context, ConservationPage(profileImage: data['profile_url'], recieverPhone: userId, recieverName: data['name']));
                                // profileBloc.getFriendList(authBloc.userId, authBloc.token);
                              },
                              child: const Text("Message",style: TextStyle(color: Colors.white),),
                            ),
                            isMyProfile || isBusiness ? Container():
                            InkWell(
                              onTap: (){
                                nextScreen(context, OtherProfileMore(userId: userId,));
                              },
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: Icon(Icons.keyboard_arrow_down_sharp)),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
