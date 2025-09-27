import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tribal_martyrs_app/core/theme/app_theme.dart';
import 'package:tribal_martyrs_app/features/auth/screens/login_screen.dart';
import 'package:tribal_martyrs_app/features/home/screens/home_screen.dart';
import 'package:tribal_martyrs_app/features/admin/screens/admin_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'توثيق شهداء قبيلة ذو محمد',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar')],
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // المستخدم مسجل دخوله — نتحقق مما إذا كان مسؤولًا
          return AdminCheck(user: snapshot.data!);
        }

        // لم يسجل دخوله بعد
        return const LoginScreen();
      },
    );
  }
}

class AdminCheck extends StatelessWidget {
  final User user;

  const AdminCheck({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user.getIdTokenResult(),
      builder: (context, AsyncSnapshot<IdTokenResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final isAdmin = snapshot.data?.claims?['admin'] == true;

        if (isAdmin) {
          return const AdminDashboard();
        } else {
          return const HomeScreen(); // للمستخدم العادي
        }
      },
    );
  }
}