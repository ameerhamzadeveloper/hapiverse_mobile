import 'package:flutter/material.dart';
import '../../views/feeds/components/book_now_ads_widget.dart';
import '../../views/feeds/components/image_ads_widget.dart';

class AddsExampPage extends StatefulWidget {
  const AddsExampPage({Key? key}) : super(key: key);

  @override
  _AddsExampPageState createState() => _AddsExampPageState();
}

class _AddsExampPageState extends State<AddsExampPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ads Preview Example"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // BookNowAdsWidget(isBookNow: true,),
            // BookNowAdsWidget(isBookNow: false,),
            ImageAdsWidget()
          ],
        ),
      ),
    );
  }
}
