import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SeeProfileImage extends StatefulWidget {
  final String imageUrl;
  final String title;

  const SeeProfileImage({Key? key,required this.imageUrl,required this.title}) : super(key: key);

  @override
  _SeeProfileImageState createState() => _SeeProfileImageState();
}

class _SeeProfileImageState extends State<SeeProfileImage> {

   _fileFromImageUrl() async {
    print("called");
    final response = await http.get(Uri.parse(widget.imageUrl));

    final watermarkedImg = await ImageWatermark.addTextWatermark(
      imgBytes: response.bodyBytes,
      watermarkText: 'Hapiverse',
      color: kUniversalColor,
      dstX: 300,
      dstY: 400
    );
    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'hapiverseImage${DateTime.now()}.png'));
    file.writeAsBytesSync(watermarkedImg);
    print(file.path);
    GallerySaver.saveImage(file.path).then((value) {
      Fluttertoast.showToast(msg: "Image Saved to gallery",textColor: Colors.white,backgroundColor: Colors.black,toastLength: Toast.LENGTH_LONG);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: (){
              _fileFromImageUrl();
            },
            icon: const Icon(LineIcons.download,color: Colors.white,),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(imageProvider: NetworkImage(widget.imageUrl),maxScale: 1.0,minScale: 0.1,),
      ),
    );
  }
}
