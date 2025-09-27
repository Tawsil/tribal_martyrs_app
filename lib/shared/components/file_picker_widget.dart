import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // ← أُضيف هذا السطر

class FilePickerWidget extends StatefulWidget {
  final String category;
  final String docId;

  const FilePickerWidget({
    super.key,
    required this.category,
    required this.docId,
  });

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  String? _downloadUrl;

  Future<void> _pickAndUpload() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child(widget.category)
        .child(widget.docId)
        .child('document.jpg');

    final file = File(image.path); // ← تم إنشاء كائن File
    final task = ref.putFile(file); // ← تم التمرير كـ File
    await task;

    final url = await ref.getDownloadURL();
    setState(() {
      _downloadUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickAndUpload,
          child: const Text('رفع صورة/ملف'),
        ),
        if (_downloadUrl != null)
          Image.network(_downloadUrl!, height: 100),
      ],
    );
  }
}