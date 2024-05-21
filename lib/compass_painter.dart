import 'package:flutter/material.dart';
import 'dart:math';

class CirclePainter extends CustomPainter {
  final List<String> texts;

  CirclePainter({required this.texts});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) * 0.8;

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius, paint);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final angleBetweenTexts = 2 * pi / texts.length;

    for (int i = 0; i < texts.length; i++) {
      textPainter.text = TextSpan(
        text: texts[i],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();

      final textOffset = Offset(
        center.dx + radius * cos(angleBetweenTexts * i) - textPainter.width / 2,
        center.dy + radius * sin(angleBetweenTexts * i) - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}