import 'package:flutter/material.dart';
import 'package:tribal_martyrs_app/features/admin/screens/data_viewer_screen.dart';
import 'package:tribal_martyrs_app/features/admin/screens/settings_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة التحكم'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الشهداء'),
              Tab(text: 'الجرحى'),
              Tab(text: 'الإعدادات'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DataViewerScreen(category: 'martyrs', title: 'الشهداء'),
            DataViewerScreen(category: 'injured', title: 'الجرحى'),
            SettingsScreen(),
          ],
        ),
      ),
    );
  }
}