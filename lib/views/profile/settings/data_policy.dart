import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../components/universal_card.dart';

class DataPolicy extends StatefulWidget {
  const DataPolicy({Key? key}) : super(key: key);
  @override
  _DataPolicyState createState() => _DataPolicyState();
}

class _DataPolicyState extends State<DataPolicy> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(Utils.dataPolicyUrl));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(getTranslated(context, 'DATA_POLICY')!),
      ),
      body: UniversalCard(
        widget: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}