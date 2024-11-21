// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

void drawBattery(Canvas canvas, Size size, Parameters parameters) {
  double value = parameters.valueWithDefault(10);
  double imageWidth = size.width;
  //double imageHeight = (imageWidth * 0.45).ceil().toDouble();
  double imageHeight = size.height;

  value = math.min(100, value);

  void createBatteryImage(
      Canvas ctx, double imageWidth, double imageHeight, double value) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    // Background
    Path path = Path();
    path.moveTo(imageWidth * 0.025, imageHeight * 0.055555);
    path.lineTo(imageWidth * 0.9, imageHeight * 0.055555);
    path.lineTo(imageWidth * 0.9, imageHeight * 0.944444);
    path.lineTo(imageWidth * 0.025, imageHeight * 0.944444);
    path.lineTo(imageWidth * 0.025, imageHeight * 0.055555);
    path.close();
    ctx.drawPath(path, paint);

    //
    path = Path();
    path.moveTo(imageWidth * 0.925, 0);
    path.lineTo(0, 0);
    path.lineTo(0, imageHeight);
    path.lineTo(imageWidth * 0.925, imageHeight);
    path.lineTo(imageWidth * 0.925, imageHeight * 0.722222);

    path.moveTo(imageWidth * 0.925, imageHeight * 0.722222);
    path.cubicTo(imageWidth * 0.925, imageHeight * 0.722222, imageWidth * 0.975,
        imageHeight * 0.722222, imageWidth * 0.975, imageHeight * 0.722222);
    path.cubicTo(imageWidth, imageHeight * 0.722222, imageWidth,
        imageHeight * 0.666666, imageWidth, imageHeight * 0.666666);
    path.cubicTo(imageWidth, imageHeight * 0.666666, imageWidth,
        imageHeight * 0.333333, imageWidth, imageHeight * 0.333333);
    path.cubicTo(imageWidth, imageHeight * 0.333333, imageWidth,
        imageHeight * 0.277777, imageWidth * 0.975, imageHeight * 0.277777);
    path.cubicTo(imageWidth * 0.975, imageHeight * 0.277777, imageWidth * 0.925,
        imageHeight * 0.277777, imageWidth * 0.925, imageHeight * 0.6277777);
    path.lineTo(imageWidth * 0.925, 0);
    path.close();

    ui.Gradient grad = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, imageHeight),
      [
        colorFromHex('#ffffff'),
        colorFromHex('#7e7e7e'),
      ],
      [0, 1],
    );
    paint.shader = grad;
    ctx.drawPath(path, paint);

    path = Path();
    double end = math.max(
        imageWidth * 0.875 * (value / 100), (imageWidth * 0.01).ceilToDouble());
    Rect rect = Rect.fromLTWH(imageWidth * 0.025, imageWidth * 0.025, end,
        imageHeight - imageWidth * 0.050);
    //Rect rect = Rect.fromLTWH(imageWidth * 0.025, imageWidth * 0.025, end, imageHeight * 0.94);
    path.addRect(rect);
    path.close();

    final paint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    List<double> BORDER_FRACTIONS = [0, 0.4, 1];
    var BORDER_COLORS = [
      const Color.fromRGBO(177, 25, 2, 1), // 0xB11902
      const Color.fromRGBO(219, 167, 21, 1), // 0xDBA715
      const Color.fromRGBO(121, 162, 75, 1) // 0x79A24B
    ];
    var border = GradientWrapper(0, 100, BORDER_FRACTIONS, BORDER_COLORS);
    var fillColor = border.getColorAt(value / 100);
    paint2.color = fillColor;

    ctx.drawPath(path, paint2);

    path = Path();
    end = math.max(end - imageWidth * 0.05, 0);
    rect = Rect.fromLTWH(imageWidth * 0.05, imageWidth * 0.05, end,
        imageHeight - imageWidth * 0.10);
    //rect = Rect.fromLTWH(imageWidth * 0.05, imageWidth * 0.05, end, imageHeight * 0.867777);
    path.addRect(rect);
    path.close();

    var LIQUID_COLORS_DARK = [
      const Color.fromRGBO(198, 39, 5, 1), // 0xC62705
      const Color.fromRGBO(228, 189, 32, 1), // 0xE4BD20
      const Color.fromRGBO(163, 216, 102, 1) // 0xA3D866
    ];

    var LIQUID_COLORS_LIGHT = [
      const Color.fromRGBO(246, 121, 48, 1), // 0xF67930
      const Color.fromRGBO(246, 244, 157, 1), // 0xF6F49D
      const Color.fromRGBO(223, 233, 86, 1) // 0xDFE956
    ];
    List<double> LIQUID_GRADIENT_FRACTIONS = [0, 0.4, 1];
    var liquidDark =
        GradientWrapper(0, 100, LIQUID_GRADIENT_FRACTIONS, LIQUID_COLORS_DARK);
    var liquidLight =
        GradientWrapper(0, 100, LIQUID_GRADIENT_FRACTIONS, LIQUID_COLORS_LIGHT);

    grad = ui.Gradient.linear(
      Offset(imageWidth * 0.05, 0),
      Offset(imageWidth * 0.875, 0),
      [
        liquidDark.getColorAt(value / 100),
        liquidLight.getColorAt(value / 100),
        liquidDark.getColorAt(value / 100),
      ],
      [0, 0.5, 1],
    );
    final paint3 = Paint()
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    paint3.shader = grad;

    ctx.drawPath(path, paint3);

    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.025, imageWidth * 0.025,
        imageWidth * 0.875, imageHeight * 0.444444);
    path.close();

    grad = ui.Gradient.linear(
      Offset(imageWidth * 0.025, imageWidth * 0.025),
      Offset(imageWidth * 0.875, imageHeight * 0.444444),
      [
        const Color.fromRGBO(255, 255, 255, 0),
        const Color.fromRGBO(255, 255, 255, 0.8),
      ],
      [0, 1],
    );
    final paint4 = Paint()
      //..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    paint4.shader = grad;

    ctx.drawPath(path, paint4);
  }

  createBatteryImage(canvas, imageWidth, imageHeight, value);
}
