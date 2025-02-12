import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../../../common/config/theme/internal_background.dart';
import '../../../../common/widgets/index.dart';
import 'components/about_bottom_sheet.dart';
import 'components/bottom_sheet_tc.dart';
import 'components/other_setting_buttons.dart';
import 'components/user_info_fields.dart'; // Adjust path as needed

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InternalBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 70.0,
                  top: 100,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: FullColumn(),
              ),
            ),
            Positioned(
              top: 44,
              left: 14,
              child: CustomNavButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () {
                  Navigator.pop(context);
                },
                isRotated: false,
              ),
            ),
            const PageTitleSideWays(
              isDrawerOpen: false,
              pageTitle: 'SETTINGS',
            ),
          ],
        ),
      ),
    );
  }
}

class FullColumn extends StatelessWidget {
  const FullColumn({super.key});

  @override
  Widget build(BuildContext context) {
    // Static user data
    final UserProfile user = UserProfile(
      name: "Your Name", // Replace with actual data
      email: "your.email@example.com", // Replace with actual data
      gender: "Male", // Replace with actual data
      address: "Your Address", // Replace with actual data
      roomNo: 123, // Replace with actual data
      bio: "Your Bio", // Replace with actual data
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileColumn(user: user), // Use the static user data
        const Spacer(),
        Column(
          children: [
            OtherSettings(
              settingsLabel: 'M Y  E X P E N S E S', // Example
              settingsIcon: Icons.money, // Example
              onTap: () {},
            ),
            OtherSettings(
              settingsLabel: 'A D D  E X P E N S E', // Example
              settingsIcon: Icons.add, // Example
              onTap: () {},
            ),
          ],
        ),
        OtherSettings(
          onTap: () {
            showThemeBottomSheet(context);
          },
          settingsLabel: 'C H A N G E  T H E M E',
          settingsIcon: Icons.color_lens_rounded,
        ),
        OtherSettings(
          settingsLabel: 'A B O U T',
          settingsIcon: Icons.info,
          onTap: () {
            showAboutBottomSheet(context);
          },
        ),
      ],
    );
  }
}

class ProfileColumn extends StatelessWidget {
  const ProfileColumn({super.key, required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.person_rounded,
          size: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        Center(
          child: SizedBox(
            height: 50,
            width: 300,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textStyle = TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.secondary,
                );

                final textPainter = TextPainter(
                  text: TextSpan(text: user.name, style: textStyle),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout();

                if (textPainter.size.width > 280) {
                  return Marquee(
                    text: user.name,
                    style: textStyle,
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    pauseAfterRound: const Duration(seconds: 3),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 2),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  );
                } else {
                  return Center(
                    child: Text(
                      user.name,
                      style: textStyle,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Center(
          child: SizedBox(
            height: 50,
            width: 300,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textStyle = TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                );

                final textPainter = TextPainter(
                  text: TextSpan(text: user.email, style: textStyle),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout();

                if (textPainter.size.width > 280) {
                  return Marquee(
                    text: user.email,
                    style: textStyle,
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    pauseAfterRound: const Duration(seconds: 3),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 2),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  );
                } else {
                  return Center(
                    child: Text(
                      user.email,
                      style: textStyle,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              UserInfoFields(
                text: user.gender,
                hintText: 'G E N D E R',
              ),
              const SizedBox(height: 5),
              UserInfoFields(
                text: user.address,
                hintText: 'B L O C K',
              ),
              const SizedBox(height: 5),
              UserInfoFields(
                text: user.roomNo.toString(),
                hintText: 'R O O M  N O.',
              ),
              const SizedBox(height: 5),
              UserInfoFields(
                text: user.bio,
                hintText: 'B I O',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String gender;
  final String address;
  final int roomNo;
  final String bio;

  UserProfile({
    required this.name,
    required this.email,
    required this.gender,
    required this.address,
    required this.roomNo,
    required this.bio,
  });
}
