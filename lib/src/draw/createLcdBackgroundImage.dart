// ignore_for_file: file_names

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> lcdBackgroundImageCache = {};

ui.Picture createLcdBackgroundImage(
    double width, double height, LcdColorEnum lcdColor) {
  double xB = 0;
  double yB = 0;
  double wB = width.toDouble();
  double hB = height.toDouble();
  double rB = math.min(width, height).toDouble() * 0.095;
  //let grad
  double xF = 1;
  double yF = 1;
  double wF = width - 2;
  double hF = height - 2;
  double rF = rB - 1;
  //String cacheKey = width.toString() + height.toString() + lcdColor.toString() + DateTime.now().millisecond.toString();

  // check if we have already created and cached this buffer, if not create it
  //if (!lcdBackgroundImageCache.containsKey(cacheKey)) {
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);
  ui.Gradient grad = ui.Gradient.linear(
    Offset(0, yB),
    Offset(0, yB + hB + 3),
    [
      colorFromHex('#4c4c4c'),
      colorFromHex('#666666'),
      colorFromHex('#666666'),
      colorFromHex('#e6e6e6'),
    ],
    [0, 0.08, 0.92, 1],
  );
  Paint paint = Paint()
    ..style = ui.PaintingStyle.fill
    ..shader = grad
    ..isAntiAlias = true;
  Path path = roundedRectangle(xB, yB, wB, hB, rB);
  canvas.drawPath(path, paint);

  // foreground
  grad = ui.Gradient.linear(
    Offset(0, yF),
    Offset(0, yF + hF + 3),
    [
      lcdColor.gradientStartColor,
      lcdColor.gradientFraction1Color,
      lcdColor.gradientFraction2Color,
      lcdColor.gradientFraction3Color,
      lcdColor.gradientStopColor,
    ],
    [0, 0.03, 0.49, 0.5, 1],
  );
  paint.shader = grad;
  path = roundedRectangle(xF, yF, wF, hF, rF);
  canvas.drawPath(path, paint);
  var pic = pictureRecorder.endRecording();
  return pic;

  //   // cache the buffer
  //   lcdBackgroundImageCache[cacheKey] = pic;
  //   return pic;
  // }
  // return lcdBackgroundImageCache[cacheKey]!;
}
