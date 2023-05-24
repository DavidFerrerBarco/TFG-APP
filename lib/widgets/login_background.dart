import 'dart:math';

import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final double right;
  final double bottom;

  const BackGround(
      {required this.primaryColor,
      required this.secondaryColor,
      required this.right,
      required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: primaryColor),
        Positioned(
          right: right,
          bottom: bottom,
          child: _ColorBoxRotated(
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}

class _ColorBoxRotated extends StatelessWidget {
  final Color color;

  const _ColorBoxRotated({required this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 5,
      child: Container(
        width: 600,
        height: 1000,
        color: color,
      ),
    );
  }
}
