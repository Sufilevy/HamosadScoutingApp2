import 'dart:math' as math;

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double progress;

  CirclePainter({
    this.color = Colors.indigo,
    this.strokeWidth = 3,
    this.progress = 0,
  });

  double _mapRange(double value, double inputStart, double inputEnd,
          double outputStart, double outputEnd) =>
      outputStart +
      ((outputEnd - outputStart) / (inputEnd - inputStart)) *
          (value - inputStart);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color.withOpacity(0.33);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      (size.width + size.height) / 4,
      paint,
    );

    paint.color = color;
    canvas.drawArc(
      Offset.zero & size,
      -math.pi / 2,
      _mapRange(progress, 0, 100, 0, math.pi * 2),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
