import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/logic/feeds/feeds_cubit.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import '../../../views/components/universal_card.dart';

class CustomerRewards extends StatefulWidget {
  const CustomerRewards({Key? key}) : super(key: key);

  @override
  _CustomerRewardsState createState() => _CustomerRewardsState();
}

class _CustomerRewardsState extends State<CustomerRewards> {

  String coins = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = context.read<FeedsCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.addSearchText(" ");
    bloc.searchUser(authBloc.userID!, authBloc.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedsCubit>();
    final blocB = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Customer Rewards"),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Give rewards to your recent customers"),
                  SizedBox(height: 50,),
              state.searchedUsersList == null ? Center(child: CupertinoActivityIndicator(),):state.searchedUsersList!.isEmpty ? Center(child: Text("No Search Found"),):ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx,i){
                  var d = state.searchedUsersList![i];
                  return ListTile(
                    onTap: (){

                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.searchedUsersList![i].profileImageUrl}"),
                    ),
                    title: Text(state.searchedUsersList![i].userName!),
                    subtitle: Text(d.country ?? ""),
                    trailing: TextButton(
                      onPressed: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Add Coins"),
                            content: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Add Coins Amount"
                              ),
                              onChanged: (v){
                                coins = v;
                              },
                            ),
                            actions: [
                              MaterialButton(onPressed: (){
                                blocB.addReward(coins, state.searchedUsersList![i].userId!, authB.userID!, authB.accesToken!);
                                Navigator.pop(context);
                              },child: Text("Give Coins"),)
                            ],
                          );
                        });
                        // context.read<ProfileCubit>().addFollow(d.userId!, authB.userID!, authB.accesToken!,context,authB.isBusinessShared! ? true:false);
                        // context.read<FeedsCubit>().searchUser(authB.userID!, authB.accesToken!);
                        // print(d.isFriend);
                      },
                      child: Text("Give Coins"),
                    ),
                  );
                },
                itemCount: state.searchedUsersList == null ? 0:state.searchedUsersList!.length,
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
