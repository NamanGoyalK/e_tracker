import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final String labelText;
  final ImageProvider? image;
  final VoidCallback? onPressed;

  const ColoredButton({
    super.key,
    required this.labelText,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 350,
        child: MaterialButton(
          onPressed: onPressed,
          color: Theme.of(context).colorScheme.inverseSurface,
          elevation: 2,
          padding: const EdgeInsets.all(1),
          textColor: Theme.of(context).colorScheme.inversePrimary,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null)
                Image(
                  image: image!,
                  height: 20,
                  width: 20,
                ),
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: theme.brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonInsideTF extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonInsideTF({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  State<ButtonInsideTF> createState() => _ButtonInsideTFState();
}

class _ButtonInsideTFState extends State<ButtonInsideTF> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          elevation: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}

class DrawerWeekButton extends StatelessWidget {
  final String day;
  final bool isSelected;
  final bool isToday;
  final bool isEnabled; // Add this line
  final VoidCallback onTap;

  const DrawerWeekButton({
    super.key,
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.isEnabled, // Add this line
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null, // Disable on-tap if not enabled
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            color: isSelected
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.surfaceBright),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
                fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                fontSize: 18,
                color: isEnabled
                    ? (isToday ? Theme.of(context).colorScheme.secondary : null)
                    : Theme.of(context)
                        .colorScheme
                        .error // Change text color if not enabled
                ),
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const NavButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          color: Theme.of(context).colorScheme.surface,
          // color: Colors.black,
        ),
        child: Icon(
          icon,
          size: 20,
          // color: Colors.white,
        ),
      ),
    );
  }
}

class CustomNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isRotated;

  const CustomNavButton({
    required this.icon,
    required this.onTap,
    required this.isRotated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              width: 1,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          color: isDarkTheme ? Colors.black : Colors.white,
        ),
        child: AnimatedRotation(
          turns: isRotated ? 0.5 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            icon,
            size: 22,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
