import 'package:e_tracker/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  final prefs =
      await SharedPreferences.getInstance(); // Initialize shared preferences
  final monthlyBudget =
      prefs.getDouble('monthlyBudget') ?? 10000.0; // Load monthly budget
  runApp(MyApp(monthlyBudget: monthlyBudget)); // Pass the budget to the app
}
