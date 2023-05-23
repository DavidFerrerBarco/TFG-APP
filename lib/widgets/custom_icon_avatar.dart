import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CircularIconAvatar extends StatelessWidget {
  const CircularIconAvatar({
    super.key,
    required this.name,
    required this.radius,
    required this.fontSize,
    required this.backgroundColor,
    required this.textColor,
  });

  final double fontSize;
  final double radius;
  final String name;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    String words = name.split(' ').length > 1
        ? '${name.split(' ')[0].substring(0, 1)}${name.split(' ')[1].substring(0, 1)}'
        : name.split(' ')[0].substring(0, 1);

    return CircleAvatar(
      radius: radius + 2,
      backgroundColor: AppTheme.primary,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        child: Text(
          words,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      ),
    );
  }
}
