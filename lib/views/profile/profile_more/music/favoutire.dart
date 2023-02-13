import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import '../../../../views/components/universal_card.dart';
class FavouriteMusic extends StatefulWidget {
  @override
  _FavouriteMusicState createState() => _FavouriteMusicState();
}

class _FavouriteMusicState extends State<FavouriteMusic> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final auth = context.read<RegisterCubit>();
    bloc.fetchFavMusic(auth.userID!, auth.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: UniversalCard(
        widget: Center(
          child: Text("No Favorite"),
        ),
      ),
    );
  }
}
