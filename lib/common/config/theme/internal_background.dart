import 'package:flutter/material.dart';
// import 'package:huddle/common/config/animated_background_base.dart';

class InternalBackground extends StatelessWidget {
  final Widget child;

  const InternalBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDarkTheme
                ? const Color.fromARGB(255, 45, 45, 45)
                : const Color.fromARGB(255, 220, 220, 220),
            isDarkTheme
                ? const Color.fromARGB(255, 5, 5, 5)
                : const Color.fromARGB(255, 244, 244, 244),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
