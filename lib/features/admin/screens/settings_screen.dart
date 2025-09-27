import 'package:flutter/material.dart';
import 'package:tribal_martyrs_app/features/admin/widgets/field_editor_widget.dart';
import 'package:tribal_martyrs_app/features/admin/widgets/theme_editor_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ThemeEditorWidget(),
        Divider(),
        FieldEditorWidget(category: 'martyrs', title: 'حقول الشهداء'),
        FieldEditorWidget(category: 'injured', title: 'حقول الجرحى'),
        FieldEditorWidget(category: 'prisoners', title: 'حقول الأسرى'),
      ],
    );
  }
}