import 'package:flutter/material.dart';
import 'package:test_app/constants/colors.dart';

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter(this.progress);


  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Color.fromARGB(255, 219, 218, 218)
      ..style = PaintingStyle.fill;
      final paint2 = Paint()
      ..color = teal
      ..style = PaintingStyle.fill;
    double progressCenter = ((progress * 160)/ 2).roundToDouble();
    
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(80, 5), width: 160, height: 10),
            Radius.circular(3)),
        paint1);

      if (progressCenter <= 0) {
        return;
      }

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(progressCenter, 5), width: progressCenter * 2, height: 10),
            Radius.circular(8)),
        paint2);
  }
  
  @override
    bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class AppProgress extends StatelessWidget {
  final double progress;

  const AppProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    Size size = Size(160, 8);
       return  CustomPaint(
        size: size,
        painter: ProgressPainter(progress)
    );
  }
}