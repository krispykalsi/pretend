import 'package:flutter/material.dart';

class HuePainter extends CustomPainter {
  final Color _color;

  const HuePainter(this._color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = _color;
    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(HuePainter oldDelegate) => _color != oldDelegate._color;
}
