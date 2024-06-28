import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/widgets/pie/app_colors.dart';

class SunburstPainter extends CustomPainter {
  // final List<dynamic> data;
  // final double totalValue;
  // final double startAngle;
  //
  // SunburstPainter({
  //   required this.data,
  //   required this.totalValue,
  //   required this.startAngle,
  // });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.redAccent;

    final radius = size.shortestSide / 2;
    const sweepAngle = 60;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      0,
      sweepAngle as double,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SunriseChart extends StatefulWidget {
  const SunriseChart({super.key});

  @override
  State<StatefulWidget> createState() => ConcentriceRings();
}

class ConcentriceRings extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          for (int i = 0; i < 3; i++)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    // pieTouchData: PieTouchData(
                    //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    //     setState(() {
                    //       if (!event.isInterestedForInteractions ||
                    //           pieTouchResponse == null ||
                    //           pieTouchResponse.touchedSection == null) {
                    //         touchedIndex = -1;
                    //         return;
                    //       }
                    //       touchedIndex = pieTouchResponse
                    //           .touchedSection!.touchedSectionIndex;
                    //     });
                    //   },
                    // ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: Colors.red,
                          width: 10.0,
                          style: BorderStyle.solid),
                    ),
                    sectionsSpace: 2,
                    centerSpaceRadius: (40 + 50 * i).toDouble(),
                    sections: showingSections(),
                    titleSunbeamLayout: true,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 10)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: 45,
            title: 'TextStyle',
            radius: radius,
            borderSide:const BorderSide(width: 1),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
              color: AppColors.mainTextColor1,
              // shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.transparent,
            value: 45,
            title: '南',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.transparent,
            value: 45,
            title: '西',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.transparent,
            value: 45,
            title: '北',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
