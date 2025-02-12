import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void showAboutBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    isScrollControlled: false,
    builder: (BuildContext context) {
      return const AboutContent();
    },
  );
}

class AboutContent extends StatefulWidget {
  const AboutContent({super.key});

  @override
  AboutContentState createState() => AboutContentState();
}

class AboutContentState extends State<AboutContent> {
  String helperText = '';
  final ScrollController _scrollController = ScrollController();

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'A B O U T',
                style:
                    Theme.of(context).textTheme.titleLarge ?? const TextStyle(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Welcome to Expense Tracker!', // Changed title
                  style: (Theme.of(context).textTheme.headlineSmall ??
                          const TextStyle())
                      .copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This app is designed to help you easily track and manage your expenses. '
              'Keep your finances organized and gain insights into your spending habits.', // Changed description
              style:
                  (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
                      .copyWith(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              'Key Features:',
              style: (Theme.of(context).textTheme.headlineSmall ??
                      const TextStyle())
                  .copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            buildFeatureItem(context, 'Expense Logging:',
                'Quickly and easily log your expenses with details.'),
            buildFeatureItem(context, 'Categorization:',
                'Categorize your expenses for better analysis.'),
            buildFeatureItem(context, 'Reporting:',
                'Generate reports to visualize your spending patterns.'),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Take control of your finances with this simple and effective expense tracker!', // Changed closing message
                style:
                    (Theme.of(context).textTheme.bodyLarge ?? const TextStyle())
                        .copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: namansProfile(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Column namansProfile(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            const url = 'https://www.linkedin.com/in/naman-goyal-dev';
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Text(
            'Developed by Naman Goyal.', // Removed "Idea and"
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                const url = 'https://www.linkedin.com/in/naman-goyal-dev';
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: const Icon(FontAwesomeIcons.linkedin),
            ),
            IconButton(
              onPressed: () async {
                const url = 'https://github.com/NamanGoyalK';
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: const Icon(FontAwesomeIcons.squareGithub),
            ),
            IconButton(
              onPressed: () async {
                const email = 'namangoyaldev@gmail.com';
                await Clipboard.setData(const ClipboardData(text: email));
                setState(() {
                  helperText =
                      'You can contact me at namangoyaldev@gmail.com. The email address has been copied to your clipboard.';
                });
                _scrollToEnd();
              },
              icon: const Icon(FontAwesomeIcons.squareGooglePlus),
            ),
          ],
        ),
        if (helperText.isNotEmpty) // Conditionally show the text
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  helperText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        // Removed Shiven's info
      ],
    );
  }

  Widget buildFeatureItem(
      BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$title ',
              style:
                  (Theme.of(context).textTheme.bodyLarge ?? const TextStyle())
                      .copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
