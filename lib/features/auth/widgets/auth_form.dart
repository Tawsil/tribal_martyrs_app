import 'package:flutter/material.dart';
import 'package:tribal_martyrs_app/core/constants/app_strings.dart';
import 'package:tribal_martyrs_app/core/services/auth/auth_service.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  const AuthForm({super.key, required this.isLogin});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.isLogin) {
          await AuthService.signIn(_emailController.text, _passwordController.text);
          // سيتم التحقق من الصلاحيات في الخطوة التالية
        } else {
          await AuthService.signUp(_emailController.text, _passwordController.text);
        }
        // هنا سنوجه المستخدم حسب دوره لاحقًا
        Navigator.of(context).pushReplacementNamed('/home'); // مؤقت
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: AppStrings.email),
            validator: (value) => value!.isEmpty ? 'الرجاء إدخال البريد' : null,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: AppStrings.password),
            validator: (value) => value!.length < 6 ? 'كلمة المرور قصيرة' : null,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: Text(widget.isLogin ? AppStrings.signIn : AppStrings.register),
          ),
        ],
      ),
    );
  }
}