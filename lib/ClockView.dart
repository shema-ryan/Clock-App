import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: -pi / 2,
        child: Container(
          height: widget.size,
          width: widget.size,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: RADIUS AND OFFSET CALCULATIONS
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    final double radius = min(centerX, centerY);
    final center = Offset(centerX, centerY);
    //TODO:PAINT BRUSH SECTION
    var fillBrush = Paint()..color = Color(0xFF444974);

    var outerBrush = Paint()
      ..strokeWidth = centerX / 15
      ..color = Color(0xFFEFEFEF)
      ..style = PaintingStyle.stroke;
    var centerFillBrush = Paint()..color = Color(0xFFEFEFEF);

    var secBrush = Paint()
      ..color = Colors.orange[300]
      ..strokeWidth = centerX / 30
      ..strokeCap = StrokeCap.round;

    var minBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = (8 / 150 * 150);

    var hourBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = centerX / 15;
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = centerX / 150;
    var minDashBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = centerX / 150;
    // TODO: FINDING POINTS ON THE CIRCLE
    DateTime currentTime = DateTime.now();
    var secX =
        centerX + (centerX / 1.5) * cos((currentTime.second * 6) * pi / 180);
    var secY =
        centerY + (centerX / 1.5) * sin((currentTime.second * 6) * pi / 180);

    var minX = centerX +
        (8 / 15 * centerX) *
            cos((currentTime.minute * 6 + currentTime.second * 0.1) * pi / 180);
    var minY = centerY +
        (8 / 15 * centerX) *
            sin((currentTime.minute * 6 + currentTime.second * 0.1) * pi / 180);

    var hrX = centerX +
        (2 / 5 * centerX) *
            cos((currentTime.hour * 30 + currentTime.minute * 0.5) * pi / 180);
    var hrY = centerY +
        (2 / 5 * centerX) *
            sin((currentTime.hour * 30 + currentTime.minute * 0.5) * pi / 180);

    canvas.drawCircle(center, radius - (4 / 15 * centerX), fillBrush);
    canvas.drawCircle(center, radius - (4 / 15 * centerX), outerBrush);
    canvas.drawLine(center, Offset(hrX, hrY), hourBrush);
    canvas.drawLine(center, Offset(minX, minY), minBrush);
    canvas.drawLine(center, Offset(secX, secY), secBrush);
    canvas.drawCircle(center, (1 / 15 * centerX), centerFillBrush);

    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + (14 / 15 * centerX) * cos(i * pi / 180);
      var y1 = centerY + (14 / 15 * centerX) * sin(i * pi / 180);

      var x2 = centerX + (13 / 15 * centerX) * cos(i * pi / 180);
      var y2 = centerY + (13 / 15 * centerX) * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + (14 / 15 * centerX) * cos(i * pi / 180);
      var y1 = centerY + (14 / 15 * centerX) * sin(i * pi / 180);

      var x2 = centerX + (13 / 15 * centerX) * cos(i * pi / 180);
      var y2 = centerY + (13 / 15 * centerX) * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), minDashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
