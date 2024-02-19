import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static const String IMG_PATH = 'IMAGE_PATH';
  static const String NAME_KEY = 'NAME';

  static Future<bool> saveName(String name) async {
    final _shared = await SharedPreferences.getInstance();
    return _shared.setString(NAME_KEY, name);
  }

  //_____ for the image:
  Future<void> saveImagePath(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(IMG_PATH, imagePath);
  }

  Future<void> pickAndSaveImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      await saveImagePath(imagePath);
    } else {
      return;
    }
  }
}