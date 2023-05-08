import 'package:flutter/material.dart';
import 'package:test_app/constants/colors.dart';

class StepperPainter extends CustomPainter {
  late int index;
  late int number;

  StepperPainter({required this.index, required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    final paint2 = Paint()
      ..color = const Color.fromRGBO(0x6b, 0x77, 0x9A, 0.8)
      ..style = PaintingStyle.fill;

    var n = 0;
    var start = 0;
    while (n < number) {
      if (n == index) {
        paintLarge(canvas, start);
        n++;
        start += 20;
        continue;
      }

      canvas.drawCircle(Offset(start + 3, 3), 2, paint2);
      start += 10;
      n++;
    }
  }

  void paintLarge(Canvas canvas, int start) {
    final paint1 = Paint()
      ..color = darkBlue
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(start + 8, 2), width: 16, height: 4),
            Radius.circular(3)),
        paint1);
  }

  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class AppStepper extends StatelessWidget {
  final int index;
  final int number;

  const  AppStepper({super.key, required this.index, required this.number});

  Widget build(BuildContext context) {
    int less = number - 1;
    double width = (less * 12) + 16;
    Size size = Size(width, 6);

    return Container(
      child: CustomPaint(
        size: size,
        painter: StepperPainter(index: index, number: number),
      ),
    );
  }
}
