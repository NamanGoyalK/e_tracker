import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/config/cubit/theme_cubit.dart';

void showThemeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    builder: (context) {
      return BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final accentColors = [
            Colors.red,
            Colors.deepOrange,
            Colors.amber[900]!,
            Colors.orange,
            Colors.amber,
            Colors.amber[400]!,
            Colors.lime[600]!,
            Colors.lightGreen,
            Colors.green,
            Colors.teal[700]!,
            Colors.teal,
            Colors.cyan,
            Colors.lightBlue,
            Colors.blue,
            Colors.indigo,
            Colors.indigoAccent,
            Colors.purple,
            Colors.deepPurple,
            Colors.deepPurpleAccent,
            Colors.pink,
            Colors.brown,
          ];

          final currentColorIndex =
              accentColors.indexOf(themeState.secondaryColor);
          final sliderValue =
              currentColorIndex == -1 ? 0 : currentColorIndex.toDouble();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'C H A N G E  T H E M E',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<ThemeMode>(
                    borderRadius: BorderRadius.circular(20),
                    isExpanded: false,
                    isDense: true,
                    decoration: InputDecoration(
                      labelText: 'Theme Mode',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Theme.of(context).colorScheme.surface,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    value: themeState.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ThemeCubit>().setThemeMode(value);
                        Navigator.pop(context);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A C C E N T  C O L O R',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Slider(
                  secondaryActiveColor: Theme.of(context).colorScheme.secondary,
                  thumbColor: Theme.of(context).colorScheme.secondary,
                  value: sliderValue.toDouble(),
                  min: 0,
                  max: (accentColors.length - 1).toDouble(),
                  divisions: accentColors.length - 1,
                  label: null,
                  onChanged: (value) {
                    context
                        .read<ThemeCubit>()
                        .setSecondaryColor(accentColors[value.toInt()]);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
