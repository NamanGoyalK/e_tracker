import 'package:flutter/material.dart';

ThemeData appThemeDark() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Colors.red, // Accent color for highlighting elements
    ),
    useMaterial3: true,
  );
}

ThemeData appThemeMain() {
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.blue, // Accent color for light mode
    ),
    useMaterial3: true,
  );
}
