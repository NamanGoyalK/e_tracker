import 'package:flutter/material.dart';

class UserInfoFields extends StatelessWidget {
  const UserInfoFields({
    super.key,
    required this.text,
    required this.hintText,
  });

  final String text;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          hintText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          text.isNotEmpty && text != '0' ? text : 'Not set ...',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            // color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
