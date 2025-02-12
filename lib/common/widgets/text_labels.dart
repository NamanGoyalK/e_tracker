import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String displayText;

  const DisplayText({
    super.key,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        displayText,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class SubDisplayText extends StatelessWidget {
  final String subDisplayText;

  const SubDisplayText({
    super.key,
    required this.subDisplayText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        subDisplayText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class PageTitleSideWays extends StatelessWidget {
  const PageTitleSideWays({
    super.key,
    required bool isDrawerOpen,
    required this.pageTitle,
  }) : _isDrawerOpen = isDrawerOpen;

  final bool _isDrawerOpen;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) {
      return Stack(
        children: [
          Positioned(
            top: 30,
            left: 100,
            child: Text(
              'E TRACKER \\\\\\',
              style: TextStyle(
                fontSize: 66,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 280),
              opacity: _isDrawerOpen ? 0.0 : 1.0,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  '$pageTitle \\\\\\',
                  style: const TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Positioned(
        bottom: 20,
        left: 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 280),
          opacity: _isDrawerOpen ? 0.0 : 1.0, // Fade text when drawer is open
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              children: [
                const SizedBox(
                  height: 12,
                  width: 12,
                ),
                Text(
                  'E TRACKER',
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w200,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  ' \\ $pageTitle \\\\\\',
                  style: const TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

String formatTime(DateTime dateTime) {
  int hour = dateTime.hour;
  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  if (hour == 0) hour = 12;

  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
  return formattedTime;
}

String formatDay(int weekday) {
  switch (weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return 'Day';
  }
}

class EmptyPostsPlaceholder extends StatelessWidget {
  const EmptyPostsPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 100,
      ),
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            "assets/images/penguin_light.png",
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Text(
          "Oops, it's a bit empty here!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          "Why not create your first post or refresh to find something new?",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Did you know you could swipe down to refresh?",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: color,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    ),
  );
}

class NoFavorsPlaceholder extends StatelessWidget {
  const NoFavorsPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 120,
      ),
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            "assets/images/penguin_light.png",
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Text(
          "Nice! Looks like everybody received help.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          "You can ask for a favour or refresh to find something new?",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "You can swipe down too make sure !",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
