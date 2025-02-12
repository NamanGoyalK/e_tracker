import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedBackgroundBase extends StatefulWidget {
  final Widget child;
  final Color lightAnimationColor1;
  final Color lightAnimationColor2;
  final Color darkAnimationColor1;
  final Color darkAnimationColor2;
  final Curve leCurve;
  final int durationInSeconds;

  const AnimatedBackgroundBase({
    super.key,
    required this.child,
    required this.lightAnimationColor1,
    required this.lightAnimationColor2,
    required this.darkAnimationColor1,
    required this.darkAnimationColor2,
    required this.leCurve,
    required this.durationInSeconds,
  });

  @override
  AnimatedBackgroundBaseState createState() => AnimatedBackgroundBaseState();
}

class AnimatedBackgroundBaseState extends State<AnimatedBackgroundBase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation1;
  late Animation<Color?> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.durationInSeconds),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initAnimations();
  }

  void _initAnimations() {
    final brightness = MediaQuery.of(context).platformBrightness;
    final curve = CurvedAnimation(parent: _controller, curve: widget.leCurve);

    if (brightness == Brightness.dark) {
      _animation1 = ColorTween(
        begin: widget.darkAnimationColor1,
        end: widget.darkAnimationColor2,
      ).animate(curve);

      _animation2 = ColorTween(
        begin: widget.darkAnimationColor2,
        end: widget.darkAnimationColor1,
      ).animate(curve);
    } else {
      _animation1 = ColorTween(
        begin: widget.lightAnimationColor1,
        end: widget.lightAnimationColor2,
      ).animate(curve);

      _animation2 = ColorTween(
        begin: widget.lightAnimationColor2,
        end: widget.lightAnimationColor1,
      ).animate(curve);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _animation1.value!,
                  _animation2.value!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
