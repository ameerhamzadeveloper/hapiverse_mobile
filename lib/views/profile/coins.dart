import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
class CoinsPAge extends StatefulWidget {
  const CoinsPAge({Key? key}) : super(key: key);

  @override
  State<CoinsPAge> createState() => _CoinsPAgeState();
}

class _CoinsPAgeState extends State<CoinsPAge> {

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchCoins(authBloc.userID!, authBloc.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hapiverse Coins"),
      ),
      body: Column(
        children: [
          Container(
            width: getWidth(context),
            height: getHeight(context) / 4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://image.slidesdocs.com/responsive-images/background/technology-blue-vector-wire-abstract-business-powerpoint-background_d684e71ddc__960_540.jpg")
              )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LineIcons.coins,color: Colors.white,size: 40,),
                  SizedBox(height: 10,),
                  Text(NumberFormat.compact().format(int.parse(state.usersCoins == null ? "0":state.usersCoins!.totalCoin.coin)),style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold,fontFamily: ''),),
                  SizedBox(height: 10,),
                  Text("Total coins",style: TextStyle(color: Colors.white,fontSize: 25),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Coins History"),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (c,i){
                    var d = state.usersCoins!.data[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:NetworkImage("${Utils.baseImageUrl}${d.logoImageUrl}"),
                        ),
                        title: Text("${NumberFormat.compact().format(int.parse(d.coin))} Coins from ${d.businessName}"),
                        subtitle: Text("${d.businessName} sent coins"),
                        trailing: const Icon(LineIcons.coins),
                      );
                    },
                    separatorBuilder: (c,i){
                      return const Divider();
                    },
                    itemCount: state.usersCoins == null ? 0:state.usersCoins!.data.length,
                ),
              ],
            ),
          )
        ],
      ),
    );
  },
);
  }
}
