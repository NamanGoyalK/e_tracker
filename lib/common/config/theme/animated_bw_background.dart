import 'package:flutter/material.dart';

import '../animated_background_base.dart';

class AnimatedGradientBackground extends StatelessWidget {
  final Widget child;

  const AnimatedGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBackgroundBase(
      lightAnimationColor1: Colors.white,
      lightAnimationColor2: Colors.grey[500]!,
      darkAnimationColor1: Colors.black,
      darkAnimationColor2: Colors.grey[800]!,
      durationInSeconds: 3,
      leCurve: Curves.easeInOut,
      child: child,
    );
  }
}
