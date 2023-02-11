// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:video_viewer/video_viewer.dart';
//
// import '../../data/model/movies_model.dart';
// import '../../utils/constants.dart';
// import 'dart:ui' as ui;
// class WatchMoviesPage extends StatefulWidget {
//   const WatchMoviesPage({Key? key}) : super(key: key);
//
//   @override
//   _WatchMoviesPageState createState() => _WatchMoviesPageState();
// }
//
// class _WatchMoviesPageState extends State<WatchMoviesPage> {
//   final VideoViewerController controller = VideoViewerController();
//   Map<String, VideoSource> source = {
//     "SubRip Text": VideoSource(
//       video: VideoPlayerController.network(
//           "https://www.speechpad.com/proxy/get/marketing/samples/standard-captions-example.mp4"),
//       subtitle: {
//         "English": VideoViewerSubtitle.network(
//           "https://felipemurguia.com/assets/txt/WEBVTT_English.txt",
//           type: SubtitleType.webvtt,
//         ),
//       },
//     )
//   };
//   @override
//   void initState() {
//     super.initState();
//     controller.initialize(source).then((value){
//       setState(() {
//         controller.play();
//       });
//       print(controller);
//     });
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     final List<dynamic> children = const [
//       SearchBar(),
//       SizedBox(height: kSectionPadding),
//       Text("Series",style: TextStyle(color: Color(0xFF324754),
//         fontSize: 20,
//         fontWeight: FontWeight.w500,),),
//       SizedBox(height: kPadding),
//       MovieCardSlider(kSeriesData),
//       SizedBox(height: kSectionPadding),
//       Text("Movies",style: TextStyle(color: Color(0xFF324754),
//         fontSize: 20,
//         fontWeight: FontWeight.w500,),),
//       SizedBox(height: kPadding),
//       MovieCardSlider(kMoviesData),
//     ]
//         .map((element) => element is MovieCardSlider
//         ? element
//         : Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kSectionPadding),
//       child: element,
//     ))
//         .toList();
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.symmetric(vertical: kPadding),
//           physics: const BouncingScrollPhysics(),
//           children: children,
//         ),
//       ),
//     );
//   }
// }
// class MoviePage extends StatelessWidget {
//   const MoviePage(this.movie, {Key? key}) : super(key: key);
//
//   final Movie movie;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(children: [
//             movie is Serie
//                 ? SerieVideoViewer(movie as Serie)
//                 : MovieVideoViewer(movie),
//             Padding(
//               padding: EdgeInsets.all(40),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(child: MovieTitle(movie, type: MovieStyle.page)),
//                   const SizedBox(width: kPadding),
//                   MovieFavoriteIcon(movie, type: MovieStyle.page)
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
// class MovieVideoViewer extends StatefulWidget {
//   const MovieVideoViewer(this.movie, {Key? key}) : super(key: key);
//
//   final Movie movie;
//
//   @override
//   _MovieVideoViewerState createState() => _MovieVideoViewerState();
// }
//
// class _MovieVideoViewerState extends State<MovieVideoViewer> {
//   final VideoViewerController _controller = VideoViewerController();
//
//   @override
//   Widget build(BuildContext context) {
//     return VideoViewerOrientation(
//       controller: _controller,
//       child: VideoViewer(
//         controller: _controller,
//         onFullscreenFixLandscape: false,
//         source: {
//           widget.movie.title: VideoSource(
//             video: VideoPlayerController.network(
//               "https://felipemurguia.com/assets/videos/mortal_machines_trailer.mp4",
//             ),
//             ads: [
//               VideoViewerAd(
//                 fractionToStart: 0,
//                 child: Container(
//                   color: Colors.black,
//                   child: Center(child: Text("AD ZERO",style: TextStyle(color: Colors.white,
//                     fontSize: 34,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.4,),)),
//                 ),
//                 durationToSkip: Duration.zero,
//               ),
//               VideoViewerAd(
//                 fractionToStart: 0.5,
//                 child: Container(
//                   color: Colors.black,
//                   child: Center(child: Text("AD HALF",style: TextStyle(color: Colors.white,
//                     fontSize: 34,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.4,),)),
//                 ),
//                 durationToSkip: Duration(seconds: 4),
//               ),
//             ],
//             range: Tween<Duration>(
//               begin: const Duration(seconds: 5),
//               end: const Duration(seconds: 25),
//             ),
//           ),
//         },
//         style: CustomVideoViewerStyle(movie: widget.movie, context: context),
//       ),
//     );
//   }
// }
//
// class SerieVideoViewer extends StatefulWidget {
//   const SerieVideoViewer(this.serie, {Key? key}) : super(key: key);
//
//   final Serie serie;
//
//   @override
//   _SerieVideoViewerState createState() => _SerieVideoViewerState();
// }
//
// class _SerieVideoViewerState extends State<SerieVideoViewer> {
//   final VideoViewerController controller = VideoViewerController();
//   String episode = "";
//   late MapEntry<String, SerieSource> initial;
//
//   @override
//   void initState() {
//     initial = widget.serie.source.entries.first;
//     episode = initial.key;
//     super.initState();
//   }
//
//   void onEpisodeThumbnailTap(MapEntry<String, SerieSource> entry) async {
//     final String episodeName = entry.key;
//     if (episode != episodeName) {
//       final SerieSource qualities = entry.value;
//       final String url = qualities.source.entries.first.value;
//
//       late Map<String, VideoSource> sources;
//
//       if (url.contains("m3u8")) {
//         sources = await VideoSource.fromM3u8PlaylistUrl(url);
//       } else {
//         sources = VideoSource.fromNetworkVideoSources(qualities.source);
//       }
//
//       final MapEntry<String, VideoSource> video = sources.entries.first;
//
//       controller.closeSettingsMenu();
//
//       await controller.changeSource(
//         inheritPosition: false, //RESET SPEED TO NORMAL AND POSITION TO ZERO
//         source: video.value,
//         name: video.key,
//       );
//
//       episode = episodeName;
//       controller.source = sources;
//       setState(() {});
//     } else {
//       controller.closeSettingsMenu();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return VideoViewerOrientation(
//       controller: controller,
//       child: VideoViewer(
//         controller: controller,
//         enableChat: true,
//         onFullscreenFixLandscape: false,
//         source: VideoSource.fromNetworkVideoSources(initial.value.source),
//         style: CustomVideoViewerStyle(movie: widget.serie, context: context)
//             .copyWith(
//           chatStyle: const VideoViewerChatStyle(chat: SerieChat()),
//           settingsStyle: SettingsMenuStyle(
//             paddingBetweenMainMenuItems: 10,
//             items: [
//               SettingsMenuItem(
//                 themed: SettingsMenuItemThemed(
//                   title: "Episodes",
//                   subtitle: episode,
//                   icon: Icon(
//                     Icons.view_module_outlined,
//                     color: Colors.white,
//                   ),
//                 ),
//                 secondaryMenuWidth: 300,
//                 secondaryMenu: Padding(
//                   padding: const EdgeInsets.only(top:5),
//                   child: Center(
//                     child: Container(
//                       child: Wrap(
//                         spacing: kPadding,
//                         runSpacing: kPadding,
//                         children: [
//                           for (var entry in widget.serie.source.entries)
//                             SerieEpisodeThumbnail(
//                               title: entry.key,
//                               url: entry.value.thumbnail,
//                               onTap: () => onEpisodeThumbnailTap(entry),
//                             )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // class VideoViewerOrientation extends StatefulWidget {
// //   const VideoViewerOrientation({
// //     Key? key,
// //     required this.child,
// //     required this.controller,
// //   }) : super(key: key);
// //
// //   final Widget child;
// //   final VideoViewerController controller;
// //
// //   @override
// //   _VideoViewerOrientationState createState() => _VideoViewerOrientationState();
// // }
// //
// // class _VideoViewerOrientationState extends State<VideoViewerOrientation> {
// //   late StreamSubscription _subscription;
// //
// //   @override
// //   void dispose() {
// //     _subscription.cancel();
// //     super.dispose();
// //   }
// //
// //   @override
// //   void initState() {
// //     _subscription = NativeDeviceOrientationCommunicator()
// //         .onOrientationChanged()
// //         .listen(_onOrientationChanged);
// //     super.initState();
// //   }
// //
// //   void _onOrientationChanged(NativeDeviceOrientation orientation) {
// //     final bool isFullScreen = widget.controller.isFullScreen;
// //     final bool isLandscape =
// //         orientation == NativeDeviceOrientation.landscapeLeft ||
// //             orientation == NativeDeviceOrientation.landscapeRight;
// //     if (!isFullScreen && isLandscape) {
// //       printGreen("OPEN FULLSCREEN");
// //       widget.controller.openFullScreen();
// //     } else if (isFullScreen && !isLandscape) {
// //       printRed("CLOSING FULLSCREEN");
// //       widget.controller.closeFullScreen();
// //       Misc.delayed(300, () {
// //         Misc.setSystemOverlay(SystemOverlay.values);
// //         Misc.setSystemOrientation(SystemOrientation.values);
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => widget.child;
// // }
//
// class SerieChat extends StatefulWidget {
//   const SerieChat({Key? key}) : super(key: key);
//
//   @override
//   _SerieChatState createState() => _SerieChatState();
// }
//
// class _SerieChatState extends State<SerieChat> {
//   late Timer timer;
//
//   final ScrollController _controller = ScrollController();
//   final List<String> _texts = [];
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     timer = Misc.periodic(500, () {
//       if (mounted) {
//         _texts.add("HELLO");
//         _controller.jumpTo(_controller.position.maxScrollExtent);
//         setState(() {});
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160,
//       color: Colors.black.withOpacity(0.8),
//       child: ListView.builder(
//         controller: _controller,
//         itemCount: _texts.length,
//         itemBuilder: (_, int index) {
//           return Text(
//             "x$index ${_texts[index]}",
//             style: TextStyle(color: Colors.white,
//               fontSize: 12,),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SerieEpisodeThumbnail extends StatelessWidget {
//   const SerieEpisodeThumbnail({
//     Key? key,
//     required this.title,
//     required this.url,
//     required this.onTap,
//   }) : super(key: key);
//
//   final VoidCallback onTap;
//   final String title;
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ClipRRect(
//       borderRadius: kAllBorderRadius,
//       child: SizedBox(
//         width: kSectionPadding * 2,
//         height: kSectionPadding * 2,
//         child: Stack(alignment: AlignmentDirectional.topEnd, children: [
//           Positioned.fill(child: Image.network(url, fit: BoxFit.cover)),
//           Padding(
//             padding: EdgeInsets.all(kPadding / 4),
//             child: ClipRRect(
//               borderRadius: kAllBorderRadius,
//               child: BackdropFilter(
//                 filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                 child: Container(
//                   padding: EdgeInsets.all(kPadding / 4),
//                   color: Color(0xFFd81e27),
//                   child: Text(title),
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: SplashTap(
//               onTap: onTap,
//               child: Container(color: Colors.transparent),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
//
// //------------//
// //CARD WIDGETS//
// //------------//
// class MovieCard extends StatelessWidget {
//   const MovieCard(this.movie, {Key? key}) : super(key: key);
//
//   final Movie movie;
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomContainer(
//       height: double.infinity,
//       child: ClipRRect(
//         borderRadius: kAllBorderRadius,
//         child: AspectRatio(
//           aspectRatio: kCardAspectRatio,
//           child: Stack(children: [
//             Positioned.fill(child: MovieImage(movie)),
//             SplashTap(
//               onTap: () => context.navigator.push(
//                 MaterialPageRoute(builder: (_) => MoviePage(movie)),
//               ),
//               child: Container(color: Colors.transparent),
//             ),
//             Padding(padding: kAllPadding, child: MovieTitle(movie)),
//             Padding(
//               padding: kAllPadding,
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: MovieFavoriteIcon(movie),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// class MovieCardSlider extends StatefulWidget {
//   const MovieCardSlider(this.movies, {Key? key}) : super(key: key);
//
//   final List<Movie> movies;
//
//   @override
//   _MovieCardSliderState createState() => _MovieCardSliderState();
// }
//
// class _MovieCardSliderState extends State<MovieCardSlider> {
//   Size lastSize = Size.zero;
//
//   late PageController _pageController = PageController();
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     Misc.onLayoutRendered(() => setState(_updateDimension));
//     super.initState();
//   }
//
//   void _updateDimension([Size? size]) {
//     final double width = size?.width ?? context.media.width;
//     _pageController = PageController(
//       viewportFraction: (width - kSectionPadding * 2) / width,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const Curve curve = Curves.ease;
//     const double minScale = 0.6;
//
//     return AspectRatio(
//       aspectRatio: kCardAspectRatio,
//       child: LayoutBuilder(builder: (_, constraints) {
//         final Size size = constraints.biggest;
//         if (lastSize != size) {
//           lastSize = size;
//           _updateDimension(size);
//         }
//         return PageView.builder(
//           itemCount: widget.movies.length,
//           clipBehavior: Clip.none,
//           scrollDirection: Axis.horizontal,
//           controller: _pageController,
//           physics: const BouncingScrollPhysics(),
//           itemBuilder: (_, int index) => AnimatedBuilder(
//             animation: _pageController,
//             builder: (_, child) {
//               double itemOffset = 0.0;
//               try {
//                 itemOffset = (_pageController.page ?? 0.0) - index;
//               } catch (_) {
//                 itemOffset = 0.0;
//               }
//               final double distortionValue = curve.transform(
//                 (1 - (itemOffset.abs() * (1 - minScale)))
//                     .clamp(0.0, 1.0)
//                     .toDouble(),
//               );
//               return Transform.scale(
//                 scale: distortionValue,
//                 child: Align(
//                   alignment: Alignment(
//                     curve.transform(itemOffset.abs().clamp(0.0, 1.0)),
//                     0.0,
//                   ),
//                   child: SizedBox(
//                     height: distortionValue * size.height,
//                     width: size.width,
//                     child: child,
//                   ),
//                 ),
//               );
//             },
//             child: MovieCard(widget.movies[index]),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class MovieImage extends StatelessWidget {
//   const MovieImage(this.movie, {Key? key}) : super(key: key);
//
//   final Movie movie;
//
//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: movie.title + "Thumbnail",
//       child: ClipRRect(
//         borderRadius: kAllBorderRadius,
//         child: Image.network(movie.thumbnail, fit: BoxFit.cover),
//       ),
//     );
//   }
// }
//
// class MovieFavoriteIcon extends StatelessWidget {
//   const MovieFavoriteIcon(
//       this.movie, {
//         Key? key,
//         this.type = MovieStyle.card,
//       }) : super(key: key);
//
//   final Movie movie;
//   final MovieStyle type;
//
//   @override
//   Widget build(BuildContext context) {
//     final BuildColor color = context.color;
//     final IconData iconData =
//     movie.isFavorite ? Icons.favorite : Icons.favorite_outline;
//
//     return Hero(
//       tag: movie.title + "Favorite",
//       child: type == MovieStyle.card
//           ? ClipRRect(
//         borderRadius: kAllBorderRadius,
//         child: BackdropFilter(
//           filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//           child: Container(
//             height: kButtonHeight,
//             width: kButtonHeight,
//             alignment: Alignment.center,
//             color: color.card.withOpacity(0.16),
//             child: Icon(iconData, color: color.card),
//           ),
//         ),
//       )
//           : CustomContainer(
//         width: kButtonHeight,
//         child: Icon(iconData, color: color.primary),
//       ),
//     );
//   }
// }
//
// class MovieTitle extends StatelessWidget {
//   const MovieTitle(
//       this.movie, {
//         Key? key,
//         this.type = MovieStyle.card,
//       }) : super(key: key);
//
//   final Movie movie;
//   final MovieStyle type;
//
//   @override
//   Widget build(BuildContext context) {
//     TextStyle? style;
//
//     if (type == MovieStyle.page) {
//       style = TextStyle(color: Color(0xFFfbfafe));
//     }
//
//     return Hero(
//       tag: movie.title + "Title",
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(movie.title, style: style),
//           Text(movie.category, style: style),
//         ],
//       ),
//     );
//   }
// }
//
// //------------//
// //MISC WIDGETS//
// //------------//
// class CustomContainer extends StatelessWidget {
//   const CustomContainer({
//     Key? key,
//     required this.child,
//     this.height = kButtonHeight,
//     this.width,
//   }) : super(key: key);
//
//   final Widget child;
//   final double height;
//   final double? width;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//         borderRadius: kAllBorderRadius,
//         color: Color(0xFFfbfafe),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF324754).withOpacity(0.24),
//             spreadRadius: 2,
//             blurRadius: 16,
//             offset: Offset(4, 8),
//           )
//         ],
//       ),
//       child: child,
//     );
//   }
// }
//
// class SearchBar extends StatelessWidget {
//   const SearchBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TextStyle? subtitle2 = TextStyle(color: Color(0xFF819ab1),
//       fontSize: 12,);
//     return CustomContainer(
//       child: Row(children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kPadding),
//           child: Icon(Icons.search, color: subtitle2?.color),
//         ),
//         Expanded(
//           child: TextField(
//             style: subtitle2,
//             decoration: InputDecoration(
//               hintText: "Search in catalog...",
//               hintStyle: subtitle2,
//               border: InputBorder.none,
//               errorBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               disabledBorder: InputBorder.none,
//               contentPadding: const EdgeInsets.all(0),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }