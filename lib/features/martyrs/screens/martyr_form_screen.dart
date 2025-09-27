import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tribal_martyrs_app/shared/widgets/dynamic_form_builder.dart';
import 'package:tribal_martyrs_app/shared/components/file_picker_widget.dart';

class MartyrFormScreen extends StatefulWidget {
  const MartyrFormScreen({super.key});

  @override
  State<MartyrFormScreen> createState() => _MartyrFormScreenState();
}

class _MartyrFormScreenState extends State<MartyrFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _docId;

  @override
  void initState() {
    _docId = FirebaseFirestore.instance.collection('martyrs').doc().id;
    super.initState();
  }

  void _submitForm(Map<String, dynamic> data) {
    data['createdAt'] = FieldValue.serverTimestamp();
    FirebaseFirestore.instance
        .collection('martyrs')
        .doc(_docId)
        .set(data)
        .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حفظ بيانات الشهيد بنجاح')),
          );
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة شهيد')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DynamicFormBuilder(
                category: 'martyrs',
                onSubmit: _submitForm,
              ),
              if (_docId != null)
                FilePickerWidget(category: 'martyrs', docId: _docId!),
            ],
          ),
        ),
      ),
    );
  }
}