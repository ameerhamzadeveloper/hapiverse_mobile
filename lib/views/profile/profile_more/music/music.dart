import 'package:flutter/material.dart';
import '../../../../views/profile/profile_more/music/favoutire.dart';
import '../../../../views/profile/profile_more/music/music_page.dart';
import 'package:line_icons/line_icons.dart';
class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MusicListPage(),
          FavouriteMusic()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
        currentIndex: _currentIndex,
        onTap: (va){
          setState(() {
            _currentIndex = va;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(LineIcons.music),label: "Music"),
          BottomNavigationBarItem(icon: Icon(LineIcons.heart),label: "Favorites"),
        ],
      ),
    );
  }
}
