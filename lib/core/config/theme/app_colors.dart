import 'package:flutter/material.dart';

ThemeData appThemeDark() {
  return ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.amber[600]!, // Accent color for highlighting elements
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
