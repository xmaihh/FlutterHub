import 'package:flutter/material.dart';
import 'dart:math';

class CirclePainter extends CustomPainter {
  final List<List<String>> textGroups;

  CirclePainter({required this.textGroups});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) * 0.8;
    const strokeWidth = 2.0;
    const padding = 8.0;
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final maxTextHeight = textGroups.map((texts) {
      textPainter.text = TextSpan(text: texts.longest, style: textStyle);
      textPainter.layout();
      return textPainter.height;
    }).reduce(max);

    final numCircles = textGroups.length;
    final circleRadii = List.generate(
      numCircles,
      (i) => radius - (strokeWidth + maxTextHeight + padding) * i,
    );

    for (int i = 0; i < numCircles; i++) {
      final angleBetweenTexts = 2 * pi / textGroups[i].length;
      _paintTextsOnCircle(
        canvas,
        center,
        circleRadii[i],
        angleBetweenTexts,
        textGroups[i],
        textPainter,
        textStyle,
      );
    }
  }

  void _paintTextsOnCircle(
    Canvas canvas,
    Offset center,
    double radius,
    double angleBetweenTexts,
    List<String> texts,
    TextPainter textPainter,
    TextStyle textStyle,
  ) {
    for (int i = 0; i < texts.length; i++) {
      textPainter.text = TextSpan(
        text: texts[i],
        style: textStyle,
      );

      textPainter.layout();

      final textOffset = Offset(
        center.dx + radius * cos(angleBetweenTexts * i),
        center.dy + radius * sin(angleBetweenTexts * i),
      );

      final arcStartAngle = angleBetweenTexts * i - angleBetweenTexts / 2;
      final arcSweepAngle = angleBetweenTexts;

      canvas.save();
      canvas.translate(textOffset.dx, textOffset.dy);
      canvas.rotate(arcStartAngle + arcSweepAngle / 2);

      final textRect = Rect.fromLTWH(
        -textPainter.width / 2,
        -textPainter.height / 2,
        textPainter.width,
        textPainter.height,
      );

      // 检查文字是否会超出圆环范围
      final inscribeCircleRadius = radius * sin(arcSweepAngle / 2);
      const inscribeCircleCenter = Offset.zero;

      if ((textRect.topLeft - inscribeCircleCenter).distanceSquared <=
              inscribeCircleRadius * inscribeCircleRadius &&
          (textRect.topRight - inscribeCircleCenter).distanceSquared <=
              inscribeCircleRadius * inscribeCircleRadius &&
          (textRect.bottomLeft - inscribeCircleCenter).distanceSquared <=
              inscribeCircleRadius * inscribeCircleRadius &&
          (textRect.bottomRight - inscribeCircleCenter).distanceSquared <=
              inscribeCircleRadius * inscribeCircleRadius) {
        // 绘制文字
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

extension on List<String> {
  String get longest => reduce((a, b) => a.length > b.length ? a : b);
}
