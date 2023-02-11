import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import '../../components/universal_card.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutHapiverse extends StatefulWidget {
  const AboutHapiverse({Key? key}) : super(key: key);

  @override
  State<AboutHapiverse> createState() => _AboutHapiverseState();
}

class _AboutHapiverseState extends State<AboutHapiverse> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(Utils.aboutHapiverse));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hapiverse About"),
      ),
      body: UniversalCard(
        widget: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
