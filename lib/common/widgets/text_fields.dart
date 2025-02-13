import 'package:flutter/material.dart';

class TextFromUser extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final IconData icon;

  const TextFromUser({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    this.suffix,
    required this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: suffixIcon,
                )
              : null,
          suffix: suffix,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          hintText: hintText,
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
