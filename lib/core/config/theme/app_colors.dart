import 'package:flutter/material.dart';

ThemeData appThemeDark() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(
          255, 100, 100, 100), // Darker primary color for contrast
      surface: Color.fromARGB(200, 0, 0, 0), // Dark background color
      secondary: Colors.teal, // Accent color for highlighting elements
      // secondary: Colors.red,
      onPrimary: Colors.white, // Color for text and icons on primary color
      onSecondary: Colors.white, // Color for text and icons on secondary color
      surfaceBright: Color.fromARGB(255, 49, 49, 49),
      tertiary: Color.fromARGB(100, 100, 100, 100),
    ),
    scaffoldBackgroundColor:
        const Color.fromARGB(255, 25, 25, 25), // Background color for Scaffold
    appBarTheme: const AppBarTheme(
      backgroundColor:
          Color.fromARGB(255, 50, 50, 50), // AppBar background color
      elevation: 0,
    ),
    cardColor: const Color.fromARGB(255, 40, 40, 40), // Card background color
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor:
          Color.fromARGB(255, 45, 45, 45), // BottomSheet background color
    ),
    dialogBackgroundColor:
        const Color.fromARGB(255, 45, 45, 45), // Dialog background color
    useMaterial3: true,
  );
}

ThemeData appThemeMain() {
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: const Color.fromARGB(
          255, 125, 125, 125), // Primary color for light mode
      surface: const Color.fromARGB(
          199, 255, 255, 255), // Background color for light mode
      secondary: Colors.teal[700]!, // Accent color for light mode
      onPrimary: Colors.white, // Color for text and icons on primary color
      surfaceBright: const Color.fromARGB(255, 181, 181, 181),
      onSecondary: Colors.black, // Color for text and icons on secondary color
      tertiary: const Color.fromARGB(175, 175, 175, 175),
    ),
    scaffoldBackgroundColor: Colors.white, // Background color for Scaffold
    appBarTheme: const AppBarTheme(
      backgroundColor:
          Color.fromARGB(255, 220, 220, 220), // AppBar background color
      elevation: 0,
    ),
    cardColor:
        const Color.fromARGB(255, 245, 245, 245), // Card background color
    dialogBackgroundColor:
        const Color.fromARGB(255, 250, 250, 250), // Dialog background color
    useMaterial3: true,
  );
}
