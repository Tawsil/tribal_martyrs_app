import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF006400), // أخضر داكن (وطني)
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF006400),
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF228B22), // أخضر فاتح
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
  );
}