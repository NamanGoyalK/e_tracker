import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/cubit/theme_cubit.dart';
import 'core/config/theme/app_colors.dart';
import 'features/home_room_status/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Providing cubits
    return MultiBlocProvider(
      providers: [
        //Theme Cubit
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
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
            theme: appThemeMain().copyWith(
              colorScheme: appThemeMain().colorScheme.copyWith(
                    secondary: themeState.secondaryColor,
                  ),
            ),
            darkTheme: appThemeDark().copyWith(
              colorScheme: appThemeDark().colorScheme.copyWith(
                    secondary: themeState.secondaryColor,
                  ),
            ),
            themeMode: themeState.themeMode,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
