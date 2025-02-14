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
  final List<String> _symbols = ['₹'];
  final int _numSymbols = 20;
  final double _scrollSpeed = 2.0;
  final double _minDistanceFactor = 1.5; // Adjust this to control spacing

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_tick)..start();

    for (int i = 0; i < _numSymbols; i++) {
      _symbolOffsets.add(Offset.zero);
      _symbolSizes.add(0.0);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeSymbolPositionsAndSizes();
  }

  void _initializeSymbolPositionsAndSizes() {
    final size = MediaQuery.of(context).size;
    final random = Random();

    for (int i = 0; i < _numSymbols; i++) {
      bool positionValid = false;
      int attempts = 0;

      while (!positionValid && attempts < 100) {
        // Limit attempts to avoid infinite loop
        attempts++;
        _symbolSizes[i] = 16 + random.nextDouble() * 24;
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
    setState(() {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < _numSymbols; i++) {
        _symbolOffsets[i] = Offset(
          _symbolOffsets[i].dx,
          (_symbolOffsets[i].dy + _scrollSpeed) % size.height,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundPainter(_symbolOffsets, _symbols, _symbolSizes),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final List<Offset> symbolOffsets;
  final List<String> symbols;
  final List<double> symbolSizes;

  _BackgroundPainter(this.symbolOffsets, this.symbols, this.symbolSizes);

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < symbolOffsets.length; i++) {
      final symbol = symbols[Random().nextInt(symbols.length)];
      final fontSize = symbolSizes[i];
      final textSpan = TextSpan(
        text: symbol,
        style: TextStyle(
          fontSize: fontSize,
          color: const Color.fromARGB(111, 135, 190, 135),
        ),
      );
      textPainter.text = textSpan;
      textPainter.layout();
      textPainter.paint(canvas, symbolOffsets[i]);
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return true;
  }
}
