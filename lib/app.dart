import 'package:e_tracker/core/config/theme/app_colors.dart';
import 'package:e_tracker/features/expense_page/presentation/cubit/expense_cubit.dart';
import 'package:e_tracker/features/expense_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  const MyApp({super.key, required this.monthlyBudget});

  final double monthlyBudget;

  @override
  Widget build(BuildContext context) {
    //Providing cubits
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(0.94),
              boldText: false,
            ), // 🔹 Prevents system text scaling
            child: child!,
          );
        },
        themeMode: ThemeMode.system,
        theme: appThemeMain(),
        darkTheme: appThemeDark(),
        home: MyHomePage(
          title: 'E X P E N S E  T R A C K E R',
          monthlyBudget: monthlyBudget,
        ),
      ),
    );
  }
}
