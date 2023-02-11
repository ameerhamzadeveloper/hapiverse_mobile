import 'package:flutter/material.dart';
class NotsComments extends StatefulWidget {
  const NotsComments({Key? key}) : super(key: key);

  @override
  State<NotsComments> createState() => _NotsCommentsState();
}

class _NotsCommentsState extends State<NotsComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Comments"),
      ),
    );
  }
}
