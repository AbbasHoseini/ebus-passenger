import 'dart:ui';

import 'package:arrow_path/arrow_path.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArrowPainter extends CustomPainter {
  final Axis axis;

  ArrowPainter(this.axis);
  @override
  void paint(Canvas canvas, Size size) {
    Path path;

    // The arrows usually looks better with rounded caps.
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0;

    /// Draw a double sided arrow.
    if (axis == Axis.vertical) {
      path = Path();
      path.moveTo(size.width * 0.5, 0);
      path.quadraticBezierTo(
          0, size.height * 1 / 2, size.width * 0.5, size.height);
      path = ArrowPath.make(path: path, isDoubleSided: true);
      canvas.drawPath(path, paint..color = colorDeactivated);
    } else {
      path = Path();
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, size.height / 2);
      path = ArrowPath.make(path: path, isDoubleSided: true);
      canvas.drawPath(path, paint..color = colorDeactivated);
    }
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => true;
}
