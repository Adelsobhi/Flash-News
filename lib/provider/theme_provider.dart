import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void changeLanguage(ThemeMode newTheme) {
    if (newTheme == themeMode) {
      return;
    }
    themeMode = newTheme;
    notifyListeners();
  }
}
