import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework_one/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraPage extends StatefulWidget {
  const ExtraPage({super.key});

  @override
  State<ExtraPage> createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  String _name = "";
  String _imgPath = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    //test
    final SharedPreferences prefs = await _prefs;
    final String imgPath = prefs.getString(Utility.IMG_PATH) ?? "";
    final String name = prefs.getString(Utility.NAME_KEY) ?? "Default Name";
    setState(() {
      _name = name;
      _imgPath = imgPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Your Data:\n"),
          Text(_name),
          SizedBox(height: 50),
          _imgPath != ""
              ? Image.file(File(_imgPath))
              : Image.network(
                  'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=s0aTdmT5aU6b8ot7VKm11DeID6NctRCpB755rA1BIP0=',
                  height: 90,
                )
        ]),
      ),
    );
  }
}