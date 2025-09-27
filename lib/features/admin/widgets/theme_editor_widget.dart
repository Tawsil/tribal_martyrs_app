import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ThemeEditorWidget extends StatefulWidget {
  const ThemeEditorWidget({super.key});

  @override
  State<ThemeEditorWidget> createState() => _ThemeEditorWidgetState();
}

class _ThemeEditorWidgetState extends State<ThemeEditorWidget> {
  final _colorController = TextEditingController();

  void _saveTheme() async {
    final data = {
      'primaryColor': _colorController.text,
      'enableDarkMode': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('app_settings')
        .doc('main')
        .set(data, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الإعدادات')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('إعدادات المظهر', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: 'اللون الأساسي (HEX)',
                hintText: '#006400',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _saveTheme,
              child: const Text('حفظ الإعدادات'),
            ),
          ],
        ),
      ),
    );
  }
}