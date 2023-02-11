import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../utils/config/assets_config.dart';
import '../../../views/components/universal_card.dart';

class SeeAllFavourite extends StatefulWidget {
  const SeeAllFavourite({Key? key}) : super(key: key);

  @override
  _SeeAllFavouriteState createState() => _SeeAllFavouriteState();
}

class _SeeAllFavouriteState extends State<SeeAllFavourite> {
  List<String> imgUrl = [
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage,
    AssetConfig.demoNetworkImage
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: UniversalCard(
        widget: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: const [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => Image.network(AssetConfig.demoNetworkImage,fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
}
