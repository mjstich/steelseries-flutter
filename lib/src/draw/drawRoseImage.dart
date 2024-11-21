// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

void drawRoseImage(Canvas ctx, double centerX, double centerY, double imageWidth, double imageHeight, BackgroundColorEnum backgroundColor) {
  bool fill = true;
  Color symbolColor = backgroundColor.symbolColor;

  ctx.save();
  Paint strokePaint = Paint()
    ..color = symbolColor
    ..strokeWidth = 1
    ..style = ui.PaintingStyle.stroke;
  Paint fillPaint = Paint()
    ..color = symbolColor
    ..style = ui.PaintingStyle.fill;

  ctx.translate(centerX, centerY);
  // broken ring
  for (int i = 0; i < 360; i += 15) {
    fill = !fill;

    Path path = Path();

    Rect rect1 = Rect.fromCenter(center: const Offset(0, 0), width: imageWidth * 0.26 * 2, height: imageWidth * 0.26 * 2);
    path.arcTo(rect1, i * RAD_FACTOR, (15) * RAD_FACTOR, true);
    Rect rect2 = Rect.fromCenter(center: const Offset(0, 0), width: imageWidth * 0.23 * 2, height: imageWidth * 0.23 * 2);
    var startAngle = i * RAD_FACTOR + (15) * RAD_FACTOR;
    path.arcTo(rect2, startAngle, -15 * RAD_FACTOR, false);

    path.close();

    if (fill) {
      ctx.drawPath(path, fillPaint);
    }
    ctx.drawPath(path, strokePaint);
  }

  ctx.translate(-centerX, -centerY);

  for (int i = 0; i <= 360; i += 90) {
    // Small pointers
    Path path = Path();
    path.moveTo(imageWidth * 0.560747, imageHeight * 0.584112);
    path.lineTo(imageWidth * 0.640186, imageHeight * 0.644859);
    path.lineTo(imageWidth * 0.584112, imageHeight * 0.560747);
    path.lineTo(imageWidth * 0.560747, imageHeight * 0.584112);
    path.close();
    ctx.drawPath(path, fillPaint);
    ctx.drawPath(path, strokePaint);

    // // Large pointers
    path = Path();
    path.moveTo(imageWidth * 0.523364, imageHeight * 0.397196);
    path.lineTo(imageWidth * 0.5, imageHeight * 0.196261);
    path.lineTo(imageWidth * 0.471962, imageHeight * 0.397196);
    path.lineTo(imageWidth * 0.523364, imageHeight * 0.397196);
    path.close();

    ui.Gradient grad = ui.Gradient.linear(
      Offset(0.476635 * imageWidth, 0),
      Offset(0.518691 * imageWidth, 0),
      [
        const Color.fromRGBO(222, 223, 218, 1),
        const Color.fromRGBO(222, 223, 218, 1),
        symbolColor,
        symbolColor,
      ],
      [0, 0.48, 0.49, 1],
    );
    Paint gradPaint = Paint()
      ..shader = grad
      ..style = ui.PaintingStyle.fill;
    ctx.drawPath(path, gradPaint);
    ctx.drawPath(path, strokePaint);

    ctx.translate(centerX, centerY);
    ctx.rotate(i * RAD_FACTOR);
    ctx.translate(-centerX, -centerY);
  }

  // Central ring
  Path path = Path();
  ctx.translate(centerX, centerY);
  Rect rect = Rect.fromCenter(center: const Offset(0, 0), width: imageWidth * 0.1 * 2, height: imageWidth * 0.1 * 2);
  path.addArc(rect, 0, TWO_PI);
  Paint paint = Paint()
    ..strokeWidth = imageWidth * 0.022
    ..style = ui.PaintingStyle.stroke;
  ctx.drawPath(path, paint);
  ctx.translate(-centerX, -centerY);

  ctx.restore();
}
