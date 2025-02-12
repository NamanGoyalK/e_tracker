// ignore_for_file: deprecated_member_use

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadSecondaryColor();
  }

  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void setSecondaryColor(Color color) {
    emit(state.copyWith(secondaryColor: color));
    _saveSecondaryColor(color);
  }

  Future<void> _saveSecondaryColor(Color color) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('secondaryColor', color.value);
  }

  Future<void> _loadSecondaryColor() async {
    final preferences = await SharedPreferences.getInstance();
    final colorValue =
        preferences.getInt('secondaryColor') ?? Colors.teal.value;
    emit(state.copyWith(secondaryColor: Color(colorValue)));
  }
}
