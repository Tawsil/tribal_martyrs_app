import 'package:flutter/material.dart';
import 'package:tribal_martyrs_app/core/constants/app_strings.dart';
import 'package:tribal_martyrs_app/features/martyrs/screens/martyr_form_screen.dart';
import 'package:tribal_martyrs_app/features/injured/screens/injured_form_screen.dart';
import 'package:tribal_martyrs_app/features/prisoners/screens/prisoner_form_screen.dart';
import 'data_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCategoryButton(
              context,
              icon: Icons.military_tech,
              label: 'إضافة شهيد',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MartyrFormScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _buildCategoryButton(
              context,
              icon: Icons.medical_services,
              label: 'إضافة جريح',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InjuredFormScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _buildCategoryButton(
              context,
              icon: Icons.lock,
              label: 'إضافة أسير',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrisonerFormScreen()),
              ),
            ),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: () => _showDataSelectionDialog(context),
              icon: const Icon(Icons.visibility, color: Colors.grey),
              label: const Text(
                'عرض البيانات المحفوظة',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showDataSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.military_tech),
                title: const Text('الشهداء'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DataListScreen(
                        category: 'martyrs',
                        title: 'قائمة الشهداء',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.medical_services),
                title: const Text('الجرحى'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DataListScreen(
                        category: 'injured',
                        title: 'قائمة الجرحى',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('الأسرى'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DataListScreen(
                        category: 'prisoners',
                        title: 'قائمة الأسرى',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}