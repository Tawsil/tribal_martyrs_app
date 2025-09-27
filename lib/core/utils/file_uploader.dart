import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FileUploader {
  static Future<String> uploadFile(String category, String docId, File file) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(category)
        .child(docId)
        .child('document');

    final task = ref.putFile(file);
    await task;

    return await ref.getDownloadURL();
  }
}