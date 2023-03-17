import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration(
      {super.key, required this.child, this.showGradient = false});
  final bool showGradient;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ColoredBox(
          color: primaryColor,
          child: CustomPaint(painter: BackgroundPainter()),
        )),
        Positioned(child: child)
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = textColor.withOpacity(0.2);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.6, 0);

    path.lineTo(size.width, size.height * 0.4);
    paint.color = textColor.withOpacity(0.1);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
