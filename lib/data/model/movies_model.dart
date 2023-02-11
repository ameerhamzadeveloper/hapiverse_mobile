import 'package:flutter/material.dart';

enum MovieStyle { card, page }

class Movie {
  const Movie({
    required this.thumbnail,
    required this.title,
    required this.category,
    this.isFavorite = false,
  });

  final String thumbnail, title, category;
  final bool isFavorite;
}

class Serie extends Movie {
  const Serie({
    required this.source,
    required String thumbnail,
    required String title,
    required String category,
    bool isFavorite = false,
  }) : super(
    thumbnail: thumbnail,
    title: title,
    category: category,
    isFavorite: isFavorite,
  );

  final Map<String, SerieSource> source;
}

class SerieSource {
  const SerieSource({
    required this.thumbnail,
    required this.source,
  });

  final Map<String, String> source;
  final String thumbnail;
}
// class CustomVideoViewerStyle extends VideoViewerStyle {
//   CustomVideoViewerStyle({required Movie movie, required BuildContext context})
//       : super(
//     textStyle: TextStyle(fontSize: 19),
//     playAndPauseStyle:
//     PlayAndPauseWidgetStyle(background: kSecendoryColor),
//     progressBarStyle: ProgressBarStyle(
//       bar: BarStyle.progress(color: kSecendoryColor),
//     ),
//     header: Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(kPadding),
//       child: Text(
//         movie.title,
//         style: TextStyle(color: kSecendoryColor),
//       ),
//     ),
//     thumbnail: Stack(children: [
//       Positioned.fill(child: MovieImage(movie)),
//       Positioned.fill(
//         child: Image.network(movie.thumbnail, fit: BoxFit.cover),
//       ),
//     ]),
//   );
// }