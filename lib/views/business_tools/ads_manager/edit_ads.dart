import 'package:flutter/material.dart';
class EditAds extends StatefulWidget {
  const EditAds({Key? key}) : super(key: key);

  @override
  State<EditAds> createState() => _EditAdsState();
}

class _EditAdsState extends State<EditAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Ads"),
      ),
    );
  }
}
