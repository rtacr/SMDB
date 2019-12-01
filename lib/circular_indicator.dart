import 'package:flutter/material.dart';
import 'dart:math';


Color getColor(double value){
  value = value / 100;
  return Color.lerp(Color(0xFFFF0000), Color(0xFF00FF00), value);
}

class CircleProgress extends CustomPainter{

  double currentProgress;

  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {

    //this is base circle
    Paint outerCircle = Paint()
        ..strokeWidth = 10
        ..color = Colors.transparent
        ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color =   getColor(currentProgress)
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}