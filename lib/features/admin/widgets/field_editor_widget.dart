import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FieldEditorWidget extends StatefulWidget {
  final String category;
  final String title;

  const FieldEditorWidget({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  State<FieldEditorWidget> createState() => _FieldEditorWidgetState();
}

class _FieldEditorWidgetState extends State<FieldEditorWidget> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _typeController = TextEditingController();

  void _addField() async {
    if (_formKey.currentState!.validate()) {
      final newField = {
        'id': _labelController.text.toLowerCase().replaceAll(' ', '_'),
        'label': _labelController.text,
        'type': _typeController.text,
        'required': false,
        'order': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('form_fields')
          .doc(widget.category)
          .collection('fields')
          .add(newField);

      _labelController.clear();
      _typeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _labelController,
                    decoration: const InputDecoration(labelText: 'اسم الحقل'),
                    validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                  ),
                  TextFormField(
                    controller: _typeController,
                    decoration: const InputDecoration(
                      labelText: 'نوع الحقل (text, date, number)',
                    ),
                    validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _addField,
                    child: const Text('إضافة حقل'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}