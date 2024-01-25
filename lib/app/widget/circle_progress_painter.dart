
import 'package:flutter/material.dart';

class CircleProgressPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final double strokeWidth;

  CircleProgressPainter({
    required this.animation,
    required this.color,
    required this.strokeWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double progress = animation.value * 2 * 3.14; // value ranges from 0.0 to 1.0, 3.14 represents a full circle (2π radians)

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      -90 * 0.0174533, // Start angle in radians (convert from degrees)
      progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
