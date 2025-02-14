import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final List<Offset> _symbolOffsets = [];
  final List<double> _symbolSizes = [];
  final List<double> _symbolSpeeds = [];
  final List<double> _symbolRotations = [];
  final List<int> _symbolOpacities = [];
  final List<double> _symbolScales = [];
  final List<String> _symbols = ['₹'];
  final int _numSymbols = 20;
  final double _minDistanceFactor = 1.5; // Adjust this to control spacing
  final List<Color> _symbolColors = [];
  Duration _lastElapsed = Duration.zero;
  final int _frameRate = 60; // Target frame rate

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_tick)..start();

    for (int i = 0; i < _numSymbols; i++) {
      _symbolOffsets.add(Offset.zero);
      _symbolSizes.add(0.0);
      _symbolSpeeds.add(0.0);
      _symbolRotations.add(0.0);
      _symbolOpacities.add(0);
      _symbolScales.add(0.0);
      _symbolColors.add(const Color.fromARGB(111, 135, 190, 135));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeSymbolProperties();
  }

  void _initializeSymbolProperties() {
    final size = MediaQuery.of(context).size;
    final random = Random();

    for (int i = 0; i < _numSymbols; i++) {
      bool positionValid = false;
      int attempts = 0;

      while (!positionValid && attempts < 100) {
        // Limit attempts to avoid infinite loop
        attempts++;
        _symbolSizes[i] = 16 + random.nextDouble() * 24;
        _symbolSpeeds[i] = 0.5 + random.nextDouble() * 2.0;
        _symbolRotations[i] = random.nextDouble() * 360.0;
        _symbolOpacities[i] = (128 + random.nextDouble() * 128).toInt();
        _symbolScales[i] = 1.0 + random.nextDouble() * 0.5;
        _symbolColors[i] = Colors.green.withAlpha(_symbolOpacities[i]);
        final symbolSize = _symbolSizes[i];
        final newOffset = Offset(
          random.nextDouble() * (size.width - symbolSize), // Stay within bounds
          random.nextDouble() * (size.height - symbolSize),
        );

        positionValid = true;
        for (int j = 0; j < i; j++) {
          final otherSymbolSize = _symbolSizes[j];
          final minDistance =
              (symbolSize + otherSymbolSize) * _minDistanceFactor;
          if ((newOffset - _symbolOffsets[j]).distance < minDistance) {
            positionValid = false;
            break;
          }
        }

        if (positionValid) {
          _symbolOffsets[i] = newOffset;
        }
      }

      if (!positionValid) {
        // If after many attempts a valid position isn't found, place it randomly, better than nothing.
        _symbolSizes[i] = 16 + random.nextDouble() * 24;
        _symbolSpeeds[i] = 0.5 + random.nextDouble() * 2.0;
        _symbolRotations[i] = random.nextDouble() * 360.0;
        _symbolOpacities[i] = (128 + random.nextDouble() * 128).toInt();
        _symbolScales[i] = 1.0 + random.nextDouble() * 0.5;
        _symbolColors[i] = Colors.green.withAlpha(_symbolOpacities[i]);
        final symbolSize = _symbolSizes[i];
        _symbolOffsets[i] = Offset(
          random.nextDouble() * (size.width - symbolSize),
          random.nextDouble() * (size.height - symbolSize),
        );
      }
    }
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    if (elapsed - _lastElapsed < Duration(milliseconds: 1000 ~/ _frameRate))
      return; // Limit updates to target frame rate
    _lastElapsed = elapsed;

    setState(() {
      final size = MediaQuery.of(context).size;
      final time = elapsed.inMilliseconds / 1000.0;
      for (int i = 0; i < _numSymbols; i++) {
        _symbolOffsets[i] = Offset(
          _symbolOffsets[i].dx,
          (_symbolOffsets[i].dy + _symbolSpeeds[i]) % size.height,
        );
        _symbolRotations[i] += 1.0; // Increase rotation angle
        _symbolScales[i] = 1.0 + sin(time + i) * 0.1; // Oscillation effect
        _symbolColors[i] = Color.lerp(
          Colors.green,
          Theme.of(context).colorScheme.primary,
          (sin(time + i) + 1) / 2,
        )!; // Color transition
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundPainter(_symbolOffsets, _symbols, _symbolSizes,
          _symbolRotations, _symbolOpacities, _symbolScales, _symbolColors),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final List<Offset> symbolOffsets;
  final List<String> symbols;
  final List<double> symbolSizes;
  final List<double> symbolRotations;
  final List<int> symbolOpacities;
  final List<double> symbolScales;
  final List<Color> symbolColors;

  _BackgroundPainter(
    this.symbolOffsets,
    this.symbols,
    this.symbolSizes,
    this.symbolRotations,
    this.symbolOpacities,
    this.symbolScales,
    this.symbolColors,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < symbolOffsets.length; i++) {
      final symbol = symbols[Random().nextInt(symbols.length)];
      final fontSize = symbolSizes[i] * symbolScales[i];
      final opacity = symbolOpacities[i];
      final color = symbolColors[i];
      final textSpan = TextSpan(
        text: symbol,
        style: TextStyle(
          fontSize: fontSize,
          color: color.withAlpha(opacity),
        ),
      );
      textPainter.text = textSpan;
      textPainter.layout();

      canvas.save();
      canvas.translate(symbolOffsets[i].dx + fontSize / 2,
          symbolOffsets[i].dy + fontSize / 2);
      canvas.rotate(symbolRotations[i] * pi / 180);
      canvas.translate(-(symbolOffsets[i].dx + fontSize / 2),
          -(symbolOffsets[i].dy + fontSize / 2));

      textPainter.paint(canvas, symbolOffsets[i]);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return true;
  }
}
