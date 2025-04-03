import 'package:flutter/material.dart';

import '../../styling/app_color.dart';

class DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(0, double.infinity),
      painter: DottedLinePainter(),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.c142293.withOpacity(0.10)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    double dotSpacing = 4.0;
    double dotSize = 1.0;

    for (double y = 0; y < size.height; y += dotSpacing + dotSize) {
      canvas.drawCircle(Offset(0, y), dotSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
