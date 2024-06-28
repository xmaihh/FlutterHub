import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../model/Node.dart';

class SunBurstChartPainter extends CustomPainter {
  late double density; //屏幕密度
  late double viewWidth; //控件宽度
  late double viewHeight; //控件高度
  late double pieCenterX, pieCenterY, pieRadius; //圆心X轴坐标，圆心Y轴坐标,圆半径
  late Paint textPaint,
      piePaint,
      linePaint,
      circlePaint,
      ringPaint,
      inTextPaint; //文本画笔，扇形画笔，线画笔,内圆画笔,圆环画笔
  late Rect pieOval; //矩形边界框
  double textSize = 14; //字体大小
  late double circleRadius; //内圆半径
  //扇形的弧度
  late List<double> arrayDegrees;
  late List<Point> inPoints; //内圆用以记录每个矩形的度数

  //内圆的饼图
  late Rect pieInOval; //内圆矩形边界框
  late double inTotalValue; //总数
  //内圆扇形的弧度
  late List<double> inArrayDegrees;
  late List<Node> dataNodes;
  bool animate = false;
  int depth = 1;
  late Path textPath;
  double ringWidth = 3; //圆环宽度
  double inTextSize = 12; //内圆字体大小
  List<Color> colors = [
    const Color(0xFF0288D1),
    const Color(0xFFF8BBD0),
    const Color(0xFFD4E157),
    const Color(0xFFFF6E40)
  ]; //颜色值

  @override
  void paint(Canvas canvas, Size size) {
    viewWidth = size.width;
    viewHeight = size.height;
    init();
    initTextPaint();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void init() {
    double minWidth = min(viewWidth, viewHeight);
    pieCenterX = viewWidth / 2;
    pieCenterY = viewHeight / 2;
    pieRadius = 2 * minWidth / 5; //获得饼图的半径
    circleRadius = pieRadius / depth; //内圆的半径
    textSize = 12; //
    //得到饼图的矩形
    pieOval = Rect.fromLTRB(
        pieCenterX - circleRadius,
        pieCenterY - circleRadius,
        pieCenterX + circleRadius,
        pieCenterY + circleRadius);
    pieInOval = Rect.fromLTRB(
        pieCenterX - circleRadius,
        pieCenterY - circleRadius,
        pieCenterX + circleRadius,
        pieCenterY + circleRadius);
    textPath = Path();
    arrayDegrees = [];
    inArrayDegrees = [];
  }

  //初始化文字的画笔
  void initTextPaint() {
    textPaint = Paint()
      ..color = const Color(0xFF939393)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 1.0;
    piePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    //初始化饼图的画笔
    piePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    //初始化线的画笔
    linePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = const Color(0xFF939393);
    //初始化内圆的画笔
    circlePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFFFFF);
    //初始化圆环的画笔
    ringPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    //初始化内圆的字体画笔
    inTextPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.white;
  }

  void drawSunBurstChart(Canvas canvas) {
    double start = 0.0;
    int level = 2;
    int lastIndex = 0;
    for (int i = 0; i < dataNodes.length; i++) {
      Node parentNode = dataNodes[i];
      double value = parentNode.value;
      String title = parentNode.name;
      int index = Random.secure().nextInt(colors.length - 1);
      if (index == lastIndex) {
        index = Random.secure().nextInt(colors.length - 1);
      }
      Color color = colors[index];
      double sweep = value / inTotalValue * 360;
      inArrayDegrees.add(sweep);
      // todo 绘制
      drawChild(start, canvas, sweep, parentNode.childNodes!, level);
      drawInCircleAndLine(i, canvas, start, sweep, value, title, color);
      ringPaint.strokeWidth = ringWidth;
      canvas.drawCircle(
          Offset(pieCenterX, pieCenterY), circleRadius, ringPaint);

      inPoints[i] = Point(start, start + sweep);
      start += sweep;
      lastIndex = index;
    }
  }

  void drawChild(double start, Canvas canvas, double angle,
      List<Node> childNodes, int level) {
    double childTotalValue = 0;
    for (int i = 0; i < childNodes.length; i++) {
      Node child = childNodes[i];
      double value = child.value;
      childTotalValue += value;
    }
    for (int i = 0; i < childNodes.length; i++) {
      Node child = childNodes[i];
      double value = child.value;
      String title = child.name;
      double sweep = value / childTotalValue * angle;
      if (child.hasChildNodes) {
        double tempStart = start;
        drawChild(tempStart, canvas, sweep, child.childNodes!, level + 1);
      }
      Color color = colors[Random.secure().nextInt(colors.length - 1)];
      arrayDegrees.add(sweep);
      piePaint.color = color;
      pieOval = Rect.fromLTRB(
          pieCenterX - circleRadius * level,
          pieCenterY - circleRadius * level,
          pieCenterX + circleRadius * level,
          pieCenterY + circleRadius * level);
      canvas.drawArc(pieOval, start, sweep, true, piePaint);
      canvas.drawArc(pieOval, start, sweep, true, ringPaint);

      double radius = circleRadius * level - circleRadius / 2;
      double middleAngle = (start + sweep) / 2;
      double textPointX = pieOval.center.dx + radius * cos(degreesToRadians(middleAngle));
      double textPointY = pieOval.center.dy + radius * sin(degreesToRadians(middleAngle));
      double textPointEndX = pieInOval.center.dx + circleRadius * (level -1) * cos(degreesToRadians(middleAngle));
      double textPointEndY = pieInOval.center.dy + circleRadius * (level -1) * sin(degreesToRadians(middleAngle));
      textPath.reset();
      textPath.moveTo(textPointX, textPointY);
      textPath.lineTo(textPointEndX, textPointEndY);
      ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
        textAlign: TextAlign.start,
      ));
      paragraphBuilder.addText(title);
      canvas.drawParagraph(paragraphBuilder.build(), const Offset(0, 0));
      start += sweep;
    }
  }

  void drawInCircleAndLine(int index, Canvas canvas, double start, double sweep,
      double value, String title, Color color) {
    circlePaint.color = color;
    canvas.drawArc(pieInOval, start, sweep, true, circlePaint);
    canvas.drawArc(pieInOval, start, sweep, true, ringPaint);
    //绘制圆环上扇形的文字
    double middleAngle = (start + sweep) / 2;
    double radius = circleRadius / 3;
    double textPointX = pieInOval.center.dx +
        radius * cos(degreesToRadians(middleAngle));
    double textPointY = pieInOval.center.dy +
        radius * sin(degreesToRadians(middleAngle));
    double textPointEndX = pieInOval.center.dx +
        circleRadius * cos(degreesToRadians(middleAngle));
    double textPointEndY = pieInOval.center.dy + circleRadius * sin(degreesToRadians(middleAngle));
    textPath.reset();
    textPath.moveTo(textPointX, textPointY);
    textPath.lineTo(textPointEndX, textPointEndY);
    canvas.drawPath(textPath, linePaint);
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      textAlign: TextAlign.start,
    ));
    paragraphBuilder.addText(title);
    canvas.drawParagraph(paragraphBuilder.build(), const Offset(0, 0));
  }

  double degreesToRadians(double angleInDegrees) {
    return angleInDegrees * pi / 180;
  }

}
