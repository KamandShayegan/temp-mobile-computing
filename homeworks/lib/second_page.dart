import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homework_one/data.dart';

class SecondPage extends StatefulWidget {
  final int idx;
  const SecondPage({Key? key, required this.idx}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("More info about container ${widget.idx}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Use Navigator to pop the current page off the stack
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(child: Text(data[widget.idx])),
    );
  }
}
