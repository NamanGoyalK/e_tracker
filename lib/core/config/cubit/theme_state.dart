part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final Color secondaryColor;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.secondaryColor = Colors.amber,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? secondaryColor,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  List<Object> get props => [themeMode, secondaryColor];
}
