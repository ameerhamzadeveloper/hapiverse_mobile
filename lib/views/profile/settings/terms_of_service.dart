import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../components/universal_card.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(Utils.termsConditions));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UniversalCard(
        widget: WebViewWidget(
          controller: controller,
        )
      ),
    );
  }
}