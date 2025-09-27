import 'package:flutter/material.dart';
import 'package:tribal_martyrs_app/core/constants/app_strings.dart';
import 'package:tribal_martyrs_app/features/auth/widgets/auth_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.loginTitle)),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AuthForm(isLogin: true),
      ),
    );
  }
}