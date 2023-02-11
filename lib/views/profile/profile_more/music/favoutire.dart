import 'package:flutter/material.dart';
import '../../../../views/components/universal_card.dart';
class FavouriteMusic extends StatefulWidget {
  @override
  _FavouriteMusicState createState() => _FavouriteMusicState();
}

class _FavouriteMusicState extends State<FavouriteMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
      ),
      body: UniversalCard(
        widget: Center(
          child: Text("No Favourite"),
        ),
      ),
    );
  }
}
