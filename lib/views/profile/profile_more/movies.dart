import 'package:flutter/material.dart';
import 'package:happiverse/utils/movie_style.dart' as Style;
import 'movie_widget/best_movies.dart';
import 'movie_widget/genres.dart';
import 'movie_widget/now_playing.dart';
import 'movie_widget/persons.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: const Text("Discover"),
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          BestMovies(),
        ],
      ),
    );
  }
}
