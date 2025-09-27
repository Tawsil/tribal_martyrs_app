import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tribal_martyrs_app/features/auth/screens/login_screen.dart';
import 'package:tribal_martyrs_app/features/admin/screens/admin_dashboard.dart';

class AdminGuard {
  static Future<void> checkAdminStatus(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
      return;
    }

    // تحقق مما إذا كان المستخدم مسؤولًا عبر custom claims
    final idTokenResult = await user.getIdTokenResult();
    if (idTokenResult.claims?['admin'] == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboard()),
        (route) => false,
      );
    } else {
      // هنا يمكنك توجيه المستخدم العادي إلى نموذج الإدخال
      // سيتم إضافته لاحقًا
    }
  }
}