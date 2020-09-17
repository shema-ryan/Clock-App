import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Transform.rotate(
        angle: -pi / 2,
        child: Container(
          height: size.height * 0.4,
          width: size.width * 0.8,
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
    print(size.width);
    // TODO: RADIUS AND OFFSET CALCULATIONS
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    final double radius = min(centerX, centerY);
    final center = Offset(centerX, centerY);
    //TODO:PAINT BRUSH SECTION
    var fillBrush = Paint()..color = Color(0xFF444974);

    var outerBrush = Paint()
      ..strokeWidth = 10
      ..color = Color(0xFFEFEFEF)
      ..style = PaintingStyle.stroke;
    var centerFillBrush = Paint()..color = Color(0xFFEFEFEF);

    var secBrush = Paint()
      ..color = Colors.orange[300]
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    var minBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    // TODO: FINDING POINTS ON THE CIRCLE
    DateTime currentTime = DateTime.now();
    var secX = centerX + 100 * cos((currentTime.second * 6) * pi / 180);
    var secY = centerY + 100 * sin((currentTime.second * 6) * pi / 180);

    var minX = centerX +
        80 *
            cos((currentTime.minute * 6 + currentTime.second * 0.1) * pi / 180);
    var minY = centerY +
        80 *
            sin((currentTime.minute * 6 + currentTime.second * 0.1) * pi / 180);

    var hrX = centerX +
        60 * cos((currentTime.hour * 30 + currentTime.minute * 0.5) * pi / 180);
    var hrY = centerY +
        60 * sin((currentTime.hour * 30 + currentTime.minute * 0.5) * pi / 180);

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outerBrush);
    canvas.drawLine(center, Offset(hrX, hrY), hourBrush);
    canvas.drawLine(center, Offset(minX, minY), minBrush);
    canvas.drawLine(center, Offset(secX, secY), secBrush);
    canvas.drawCircle(center, 10, centerFillBrush);

    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + 150 * cos(i * pi / 180);
      var y1 = centerY + 150 * sin(i * pi / 180);

      var x2 = centerX + 140 * cos(i * pi / 180);
      var y2 = centerY + 140 * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
