import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<String> uploadPic(String refPath, String imagePath) async {
    try {
      final id = const Uuid().v4();
      File imageFile = File(imagePath);

      final storageRef = FirebaseStorage.instance.ref().child("$refPath/$id");
      final downloadUrl = await storageRef.putFile(imageFile);
      final url = await downloadUrl.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint('Error: $e');
      return '';
    }
  }
}
