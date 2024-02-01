import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homework_one/extra_page.dart';
import 'package:homework_one/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _controller = TextEditingController();
  String _name = "Default Name";
  String _imgPath = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _loadData() async {
    final SharedPreferences prefs = await _prefs;
    final String imgPath = prefs.getString(Utility.IMG_PATH) ?? "";
    final String name = prefs.getString(Utility.NAME_KEY) ?? "Default Name";
    setState(() {
      _name = name;
      _imgPath = imgPath;
    });
  }

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        _name = prefs.getString(Utility.NAME_KEY) ?? "Default Name";
        _imgPath = prefs.getString(Utility.IMG_PATH) ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _imgPath != ""
                ? Image.file(File(_imgPath))
                : const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=s0aTdmT5aU6b8ot7VKm11DeID6NctRCpB755rA1BIP0='),
                  ),
            SizedBox(height: 30),
            OutlinedButton(
              onPressed: () async {
                await Utility().pickAndSaveImage();

                SharedPreferences prefs = await _prefs;
                setState(() {
                  _name = prefs.getString(Utility.NAME_KEY) ?? "Default Name";
                  _imgPath = prefs.getString(Utility.IMG_PATH) ?? "";
                });
              },
              child: Text("Select Image"),
            ),
            Text(_name),
            SizedBox(height: 50),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: "Type your name"),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () {
                Utility.saveName(_controller.text);
                setState(() {
                  _name = _controller.text;
                  _controller.clear();
                });
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurple,
            ),
            SizedBox(
              height: 24,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ExtraPage()));
                },
                child: Text("Another view to show your data")),
          ]),
        ),
      ),
    );
  }
}