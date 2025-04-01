import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 250,
                color: Colors.red,
              ),
              CustomPaint(
                size: Size(double.infinity, 180),
                painter: CustomShapePainter(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(60, size.height, 60, size.height - 60);
    path.quadraticBezierTo(80, size.height - 200, 200, size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
