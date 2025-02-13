import 'package:e_tracker/cubit/expense_cubit.dart';
import 'package:e_tracker/models/expense_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ExpenseCubit(),
        ),
      ],
      child: BlocListener<ExpenseCubit, List<Expense>>(
        listener: (context, state) {
          final cubit = context.read<ExpenseCubit>();

          // Listen for errors in the Cubit stream
          cubit.stream.listen((event) {}, onError: (error) {
            // Show error message in a Snackbar
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
        },
        child: MaterialApp(
          title: 'E Tracker',
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'E X P E N S E  T R A C K E R'),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
