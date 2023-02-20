import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class MovieWebview extends StatefulWidget {
  const MovieWebview({Key? key}) : super(key: key);

  @override
  State<MovieWebview> createState() => _MovieWebviewState();
}

class _MovieWebviewState extends State<MovieWebview> {
  String url = "https://www.themoviedb.org/";

  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
