import 'package:flutter/material.dart';

class OtherSettings extends StatelessWidget {
  final String settingsLabel;
  final IconData settingsIcon;

  final void Function() onTap;

  const OtherSettings({
    super.key,
    required this.settingsLabel,
    required this.settingsIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              settingsIcon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              ' $settingsLabel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
