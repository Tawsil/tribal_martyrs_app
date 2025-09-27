import 'package:flutter/material.dart';

class DynamicThemeService extends ChangeNotifier {
	ThemeMode _themeMode = ThemeMode.light;

	ThemeMode get themeMode => _themeMode;

	void toggleTheme() {
		_themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
		notifyListeners();
	}

	void setTheme(ThemeMode mode) {
		_themeMode = mode;
		notifyListeners();
	}
}
