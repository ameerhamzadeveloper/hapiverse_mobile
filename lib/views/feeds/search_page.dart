import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/feeds/feeds_cubit.dart';
import '../../logic/post_cubit/post_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/utils.dart';
import '../../views/feeds/voice_to_text.dart';
import '../../views/profile/other_business_profile.dart';
import 'package:line_icons/line_icons.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import 'components/search_dialouge.dart';
import 'other_profile/other_profile_page.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    context.read<FeedsCubit>().assignSearchNull();
  }
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<FeedsCubit>().assignSearchNull();
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: getWidth(context) - 70,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                    // border: Border.all()
                  ),
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: state.searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (val){
                      print(_tabController.index);
                      if(_tabController.index == 0){
                      // bloc.assignSearchText(val);
                      bloc.searchUser(authB.userID!, authB.accesToken!);
                      }else if(_tabController.index == 1){
                        // bloc.assignSearchText(val);
                        bloc.searchBusiness(authB.userID!,authB.accesToken!);
                      }
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search,size: 20,),
                        onPressed: (){},
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceToTextPage())),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.mic),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                showDialog(context: context, builder: (v){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: SizedBox(
                          width: double.infinity,
                          // height: getHeight(context) / 2,
                          child: SearchDialogue()),
                    ),
                  );
                });
              },
              child: Row(
                children: [
                  Text("filter",style: TextStyle(fontSize: 16),),
                  Icon(LineIcons.filter,color: Colors.blue,size: 20,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 35,
              // decoration: BoxDecoration(
              //   color: Colors.grey[300],
              //   borderRadius: BorderRadius.circular(
              //     25.0,
              //   ),
              // ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(
                  //   25.0,
                  // ),
                  border: Border(bottom: BorderSide(color: kUniversalColor)),
                  // color: kUniversalColor,
                ),
                labelColor: kUniversalColor,
                unselectedLabelColor: Colors.black,
                onTap: (i) {
                  setState(() {
                    _tabController.index = i;
                  });
                  if(i == 1){
                    bloc.searchBusiness(authB.userID!,authB.accesToken!);
                  }else if(i == 0){
                    bloc.searchUser(authB.userID!,authB.accesToken!);
                  }
                },
                tabs: const [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Peoples',
                  ),
                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Business',
                  ),
                ],
              ),
            ),
                _tabController.index == 0 ? Expanded(
                  child: state.isSearching ? Center(child: CupertinoActivityIndicator(),):ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx,i){
                      var d = state.searchedUsersList![i];
                      return ListTile(
                        onTap: (){
                          profileBloc.fetchOtherProfile(d.userId!, authB.accesToken!,authB.userID!);
                          profileBloc.fetchOtherAllPost(d.userId!, authB.accesToken!,authB.userID!);
                          profileBloc.getOtherFriends(authB.userID!, authB.accesToken!,d.userId!);
                          nextScreen(context, OtherProfilePage(userId: d.userId!));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.searchedUsersList![i].profileImageUrl}"),
                        ),
                        title: Text(state.searchedUsersList![i].userName!),
                        subtitle: Text(d.country ?? ""),
                        trailing: TextButton(
                          onPressed: (){
                            context.read<ProfileCubit>().addFollow(d.userId!, authB.userID!, authB.accesToken!,context,authB.isBusinessShared! ? true:false);
                            context.read<FeedsCubit>().searchUser(authB.userID!, authB.accesToken!);
                            print(d.isFriend);
                          },
                          child: Text(d.martialStatus!),
                        ),
                      );
                    },
                    itemCount: state.searchedUsersList == null ? 0:state.searchedUsersList!.length,
                  ),
                ):Expanded(
                  child: state.isSearching || state.searchedBusiness == null ? Center(child: CupertinoActivityIndicator(),):state.searchedBusiness!.isEmpty ? Center(child: Text("No Result Found"),):ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx,i){
                      print(state.searchedBusiness);
                      var d = state.searchedBusiness![i];
                      return InkWell(
                        onTap: (){
                          profileBloc.fetchOtherBusinessProfile(authB.userID!, authB.accesToken!,d.businessId!);
                          profileBloc.fetchOtherAllPost(d.businessId!, authB.accesToken!,authB.userID!);
                          profileBloc.getOtherFriends(authB.userID!, authB.accesToken!,d.businessId!);
                          profileBloc.fetchBusinessRating(authB.userID!, authB.accesToken!,d.businessId!);
                          nextScreen(context, OtherBusinessProfile(businessId: d.businessId!,));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                            )
                          ),
                          elevation: 5.0,
                          child: Column(
                            children: [
                              ListTile(
                                // leading: CircleAvatar(
                                //   backgroundColor: Colors.grey[200],
                                //   backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.logoImageUrl}"),
                                // ),
                                title: Text(d.businessName!),
                                subtitle: Text(d.businessType ?? "Unknown"),
                                trailing: TextButton(
                                  onPressed: (){
                                    // context.read<ProfileCubit>().addFollow(d.businessId!, authB.userID!, authB.accesToken!,context);
                                    // context.read<FeedsCubit>().searchUser(authB.userID!, authB.accesToken!);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(d.city ?? ""),
                                      Text(d.country ?? ""),
                                    ],
                                  ),
                                ),
                              ),
                              Image.network("${Utils.baseImageUrl}${d.logoImageUrl}",height: 100,width: getWidth(context),fit: BoxFit.cover,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(d.address!,style: TextStyle(color: Colors.grey),),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const Text("View Business",style: TextStyle(color: Colors.grey),),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.searchedBusiness == null ? 0:state.searchedBusiness!.length,
                  ),
                )
          ],
        ),
      ),
    );
  },
);
  }
}
