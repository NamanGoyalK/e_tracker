import 'package:e_tracker/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await SharedPreferences.getInstance(); // Initialize shared preferences
  runApp(MyApp()); // Run the main application
}
