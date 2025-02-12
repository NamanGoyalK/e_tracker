import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _secondaryColor = Colors.amber[900]!;

  ThemeMode get themeMode => _themeMode;
  Color get secondaryColor => _secondaryColor;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void setSecondaryColor(Color color) {
    _secondaryColor = color;
    notifyListeners();
  }
}
