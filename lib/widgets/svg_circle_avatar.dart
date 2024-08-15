import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgCircleAvatar extends StatelessWidget {
  final String svgAssetPath;
  final double radius;

  SvgCircleAvatar({
    required this.svgAssetPath,
    this.radius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface, // 背景色
      ),
      child: Center(
        child: SvgPicture.asset(
          svgAssetPath,
          width: radius * 2, // 确保 SVG 图片充满整个圆形
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}