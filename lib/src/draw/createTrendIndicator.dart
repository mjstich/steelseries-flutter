// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> trendIndicatorCache = {};

ui.Picture createTrendIndicator(double width, TrendStateEnum onSection, List<LedColorEnum> colors) {
  double height = width * 2;
  //String cacheKey = onSection.toString() + width.toString() + colors[0].toString() + colors[1].toString() + colors[2].toString();

  void drawUpArrow(Canvas canvas) {
    // draw up arrow (red)
    LedColorEnum ledColor = colors[0];
    late ui.Gradient grad;

    if (onSection == TrendStateEnum.UP) {
      grad = ui.Gradient.radial(
        Offset(0.5 * width, 0.2 * height),
        0,
        [
          ledColor.innerColor1_ON,
          ledColor.innerColor2_ON,
          ledColor.outerColor_ON,
        ],
        <double>[0.0, 0.2, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * width, 0.2 * height),
        0.5 * width,
      );
    } else {
      grad = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, 0.5 * height),
        [
          colorFromHex('#323232'),
          colorFromHex('#5c5c5c'),
        ],
        [0, 1],
      );
    }
    Paint paint = Paint()
      ..shader = grad
      ..style = ui.PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0.5 * width, 0);
    path.lineTo(width, 0.2 * height);
    path.lineTo(0.752 * width, 0.2 * height);
    path.lineTo(0.752 * width, 0.37 * height);
    path.lineTo(0.252 * width, 0.37 * height);
    path.lineTo(0.252 * width, 0.2 * height);
    path.lineTo(0, 0.2 * height);
    path.close();
    canvas.drawPath(path, paint);

    if (onSection != TrendStateEnum.UP) {
      // Inner shadow
      Paint paint = Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.4)
        ..style = ui.PaintingStyle.stroke;
      Path path = Path();
      path.moveTo(0, 0.2 * height);
      path.lineTo(0.5 * width, 0);
      path.lineTo(width, 0.2 * height);
      path.moveTo(0.252 * width, 0.2 * height);
      path.lineTo(0.252 * width, 0.37 * height);
      //path.close();
      canvas.drawPath(path, paint);

      // Inner highlight
      paint.color = const Color.fromRGBO(255, 255, 255, 0.3);
      path = Path();
      path.moveTo(0.252 * width, 0.37 * height);
      path.lineTo(0.752 * width, 0.37 * height);
      path.lineTo(0.752 * width, 0.2 * height);
      path.lineTo(width, 0.2 * height);
      //path.close();
      canvas.drawPath(path, paint);
    } else {
      // draw halo
      grad = ui.Gradient.radial(
        Offset(0.5 * width, 0.2 * height),
        0,
        [
          ledColor.coronaColor.withValues(alpha: 0),
          ledColor.coronaColor.withValues(alpha: 0.3),
          ledColor.coronaColor.withValues(alpha: 0.2),
          ledColor.coronaColor.withValues(alpha: 0.1),
          ledColor.coronaColor.withValues(alpha: 0.05),
          ledColor.coronaColor.withValues(alpha: 0),
        ],
        <double>[0.0, 0.5, 0.7, 0.8, 0.85, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * width, 0.2 * height),
        0.7 * width,
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      Rect rect = Rect.fromCenter(center: Offset(0.5 * width, 0.2 * height), width: 0.7 * width * 2, height: 0.7 * width * 2);
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void drawEquals(Canvas canvas) {
    // draw equal symbol
    LedColorEnum ledColor = colors[1];

    Path path = Path();
    Paint paint = Paint()..style = ui.PaintingStyle.fill;

    if (onSection == TrendStateEnum.STEADY) {
      paint.color = ledColor.outerColor_ON;
      Rect rect = Rect.fromLTWH(0.128 * width, 0.41 * height, 0.744 * width, 0.074 * height);
      path.addRect(rect);
      rect = Rect.fromLTWH(0.128 * width, 0.516 * height, 0.744 * width, 0.074 * height);
      path.addRect(rect);
      path.close();
      canvas.drawPath(path, paint);
    } else {
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.41 * height),
        Offset(0, 0.41 * height + 0.074 * height),
        [
          colorFromHex('#323232'),
          colorFromHex('#5c5c5c'),
        ],
        [0, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Rect rect = Rect.fromLTWH(0.128 * width, 0.41 * height, 0.744 * width, 0.074 * height);
      path.addRect(rect);
      path.close();
      canvas.drawPath(path, paint);

      grad = ui.Gradient.linear(
        Offset(0, 0.516 * height),
        Offset(0, 0.516 * height + 0.074 * height),
        [
          colorFromHex('#323232'),
          colorFromHex('#5c5c5c'),
        ],
        [0, 1],
      );
      paint.shader = grad;
      path = Path();
      rect = Rect.fromLTWH(0.128 * width, 0.516 * height, 0.744 * width, 0.074 * height);
      path.addRect(rect);
      path.close();
      canvas.drawPath(path, paint);
    }
    if (onSection != TrendStateEnum.STEADY) {
      // inner shadow
      Paint paint = Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.4)
        ..style = ui.PaintingStyle.stroke;
      Path path = Path();
      path.moveTo(0.128 * width, 0.41 * height + 0.074 * height);
      path.lineTo(0.128 * width, 0.41 * height);
      path.lineTo(0.128 * width + 0.744 * width, 0.41 * height);
      canvas.drawPath(path, paint);

      path = Path();
      path.moveTo(0.128 * width, 0.516 * height + 0.074 * height);
      path.lineTo(0.128 * width, 0.516 * height);
      path.lineTo(0.128 * width + 0.744 * width, 0.516 * height);
      canvas.drawPath(path, paint);

      // inner highlight
      paint.color = const Color.fromRGBO(255, 255, 255, 0.3);
      path = Path();
      path.moveTo(0.128 * width + 0.744 * width, 0.41 * height);
      path.lineTo(0.128 * width + 0.744 * width, 0.41 * height + 0.074 * height);
      path.lineTo(0.128 * width, 0.41 * height + 0.074 * height);
      canvas.drawPath(path, paint);

      path = Path();
      path.moveTo(0.128 * width + 0.744 * width, 0.516 * height);
      path.lineTo(0.128 * width + 0.744 * width, 0.516 * height + 0.074 * height);
      path.lineTo(0.128 * width, 0.516 * height + 0.074 * height);
      canvas.drawPath(path, paint);
    } else {
      // draw halo
      ui.Gradient grad = ui.Gradient.radial(
        Offset(0.5 * width, 0.2 * height),
        0,
        [
          ledColor.coronaColor.withValues(alpha: 0),
          ledColor.coronaColor.withValues(alpha: 0.3),
          ledColor.coronaColor.withValues(alpha: 0.2),
          ledColor.coronaColor.withValues(alpha: 0.1),
          ledColor.coronaColor.withValues(alpha: 0.05),
          ledColor.coronaColor.withValues(alpha: 0),
        ],
        <double>[0.0, 0.5, 0.7, 0.8, 0.85, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * width, 0.2 * height),
        0.7 * width,
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;

      Path path = Path();
      Rect rect = Rect.fromCenter(center: Offset(0.5 * width, 0.2 * height), width: 0.7 * width * 2, height: 0.7 * width * 2);
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void drawDownArrow(Canvas canvas) {
    // draw down arrow
    LedColorEnum ledColor = colors[2];
    late ui.Gradient grad;

    if (onSection == TrendStateEnum.DOWN) {
      grad = ui.Gradient.radial(
        Offset(0.5 * width, 0.8 * height),
        0,
        [
          ledColor.innerColor1_ON,
          ledColor.innerColor2_ON,
          ledColor.outerColor_ON,
        ],
        <double>[0.0, 0.2, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * width, 0.8 * height),
        0.5 * width,
      );
    } else {
      grad = ui.Gradient.linear(
        Offset(0, 0.63 * height),
        Offset(0, height),
        [
          colorFromHex('#323232'),
          colorFromHex('#5c5c5c'),
        ],
        [0, 1],
      );
    }
    Paint paint = Paint()
      ..shader = grad
      ..style = ui.PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0.5 * width, height);
    path.lineTo(width, 0.8 * height);
    path.lineTo(0.725 * width, 0.8 * height);
    path.lineTo(0.725 * width, 0.63 * height);
    path.lineTo(0.252 * width, 0.63 * height);
    path.lineTo(0.252 * width, 0.8 * height);
    path.lineTo(0, 0.8 * height);
    path.close();
    canvas.drawPath(path, paint);
    if (onSection != TrendStateEnum.DOWN) {
      // Inner shadow
      Paint paint = Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.4)
        ..style = ui.PaintingStyle.stroke;
      path = Path();
      path.moveTo(0, 0.8 * height);
      path.lineTo(0.252 * width, 0.8 * height);
      path.moveTo(0.252 * width, 0.63 * height);
      path.lineTo(0.752 * width, 0.63 * height);
      canvas.drawPath(path, paint);

      path = Path();
      path.moveTo(0.752 * width, 0.8 * height);
      path.lineTo(width, 0.8 * height);
      canvas.drawPath(path, paint);

      // Inner highlight
      paint.color = const Color.fromRGBO(255, 255, 255, 0.3);
      path = Path();
      path.moveTo(0, 0.8 * height);
      path.lineTo(0.5 * width, height);
      path.lineTo(width, 0.8 * height);
      canvas.drawPath(path, paint);

      path = Path();
      path.moveTo(0.752 * width, 0.8 * height);
      path.lineTo(0.752 * width, 0.63 * height);
      canvas.drawPath(path, paint);
    } else {
      // draw halo
      ui.Gradient grad = ui.Gradient.radial(
        Offset(0.5 * width, 0.8 * height),
        0,
        [
          ledColor.coronaColor.withValues(alpha: 0),
          ledColor.coronaColor.withValues(alpha: 0.3),
          ledColor.coronaColor.withValues(alpha: 0.2),
          ledColor.coronaColor.withValues(alpha: 0.1),
          ledColor.coronaColor.withValues(alpha: 0.05),
          ledColor.coronaColor.withValues(alpha: 0),
        ],
        <double>[0.0, 0.5, 0.7, 0.8, 0.85, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * width, 0.8 * height),
        0.7 * width,
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      Rect rect = Rect.fromCenter(center: Offset(0.5 * width, 0.8 * height), width: 0.7 * width * 2, height: 0.7 * width * 2);
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  // Check if we have already cached this indicator, if not create it
  //if (!trendIndicatorCache.containsKey(cacheKey)) {
  // create oversized buffer for the glow
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);

  // Must draw the active section last so the 'glow' is on top
  switch (onSection) {
    case TrendStateEnum.UP:
      drawDownArrow(canvas);
      drawEquals(canvas);
      drawUpArrow(canvas);
      break;
    case TrendStateEnum.STEADY:
      drawDownArrow(canvas);
      drawUpArrow(canvas);
      drawEquals(canvas);
      break;
    case TrendStateEnum.DOWN:
    /* falls through */
    default:
      drawUpArrow(canvas);
      drawEquals(canvas);
      drawDownArrow(canvas);
      break;
  }

  var pic = pictureRecorder.endRecording();
  return pic;

  //   // cache the buffer
  //   trendIndicatorCache[cacheKey] = pic;
  // }
  // return trendIndicatorCache[cacheKey]!;
}
