import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DynamicFormBuilder extends StatelessWidget {
  final String category; // 'martyrs', 'injured', 'prisoners'
  final void Function(Map<String, dynamic>) onSubmit;

  const DynamicFormBuilder({
    super.key,
    required this.category,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('form_fields')
          .doc(category)
          .collection('fields')
          .orderBy('order')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('لا توجد حقول محددة'));
        }

        final fields = snapshot.data!.docs;
        final formKeys = <GlobalKey<FormFieldState>>[];
        final values = <String, dynamic>{};

        return ListView.builder(
          itemCount: fields.length,
          itemBuilder: (context, index) {
            final field = fields[index].data() as Map<String, dynamic>;
            final key = GlobalKey<FormFieldState>();
            formKeys.add(key);

            return _buildField(context, field, (value) {
              values[field['id']] = value;
            });
          },
        );
      },
    );
  }

  Widget _buildField(BuildContext context, Map<String, dynamic> field, void Function(dynamic) onChanged) {
    switch (field['type']) {
      case 'text':
        return TextFormField(
          decoration: InputDecoration(labelText: field['label']),
          validator: (v) => field['required'] == true && (v?.isEmpty ?? true) ? 'هذا الحقل مطلوب' : null,
          onChanged: onChanged,
        );
      case 'date':
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: field['label'],
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              onChanged(date.toIso8601String());
            }
          },
        );
      default:
        return TextFormField(
          decoration: InputDecoration(labelText: field['label']),
          onChanged: onChanged,
        );
    }
  }
}