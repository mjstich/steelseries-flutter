// ignore_for_file: file_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> ledCache = {};

ui.Picture createLedImage(double size, int state, LedColorEnum ledColor) {
  double ledCenterX = size / 2.0;
  double ledCenterY = size / 2.0;
  //var cacheKey = size.toString() + state.toString() + ledColor.outerColor_ON.toString();

  // if (ledCache.containsKey(cacheKey)) {
  //   return ledCache[cacheKey]!;
  // }

  if (state == 0) {
    // switch (state) {
    //   case 0: // LED OFF
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;
    paint.style = ui.PaintingStyle.fill;

    var grad = ui.Gradient.radial(
      Offset(ledCenterX, ledCenterY),
      0,
      [
        ledColor.innerColor1_OFF,
        ledColor.innerColor2_OFF,
        ledColor.outerColor_OFF,
      ],
      <double>[0.0, 0.2, 1],
      TileMode.clamp,
      null,
      Offset(ledCenterX, ledCenterY),
      (size * 0.5) / 2,
    );

    paint.shader = grad;
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(ledCenterX, ledCenterY), width: (size * 0.5), height: (size * 0.5));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.drawPath(path, paint);

    grad = ui.Gradient.linear(
      Offset(0, 0.35 * size),
      Offset(0, 0.35 * size + 0.15 * size),
      [
        const Color.fromRGBO(255, 255, 255, 0.4),
        const Color.fromRGBO(255, 255, 255, 0),
      ],
      [0, 1],
    );
    paint.shader = grad;
    path = Path();
    rect = Rect.fromCenter(center: Offset(ledCenterX, 0.35 * size + (0.2 * size) / 2), width: (size * 0.4), height: (size * 0.4));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.drawPath(path, paint);

    var pic = pictureRecorder.endRecording();
    //ui.Image img = await pic.toImage(size, size);
    // var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    // var buffer = byteData!.buffer.asUint8List();

    //ledCache[cacheKey] = pic;

    return pic;
  } else {
    // switch (state) {
    //   case 0: // LED OFF
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;
    paint.style = ui.PaintingStyle.fill;

    var grad = ui.Gradient.radial(
      Offset(ledCenterX, ledCenterY),
      0,
      [
        ledColor.innerColor1_ON,
        ledColor.innerColor2_ON,
        ledColor.outerColor_ON,
      ],
      <double>[0.0, 0.2, 1],
      TileMode.clamp,
      null,
      Offset(ledCenterX, ledCenterY),
      (size * 0.5) / 2,
    );

    paint.shader = grad;
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(ledCenterX, ledCenterY), width: (size * 0.5), height: (size * 0.5));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.drawPath(path, paint);

    grad = ui.Gradient.linear(
      Offset(0, 0.35 * size),
      Offset(0, 0.35 * size + 0.15 * size),
      [
        const Color.fromRGBO(255, 255, 255, 0.4),
        const Color.fromRGBO(255, 255, 255, 0),
      ],
      [0, 1],
    );
    paint.shader = grad;
    path = Path();
    rect = Rect.fromCenter(center: Offset(ledCenterX, 0.35 * size + (0.2 * size) / 2), width: (size * 0.4), height: (size * 0.4));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.drawPath(path, paint);

    grad = ui.Gradient.radial(
      Offset(ledCenterX, ledCenterY),
      0,
      [
        ledColor.coronaColor.withOpacity(0),
        ledColor.coronaColor.withOpacity(0.4),
        ledColor.coronaColor.withOpacity(0.25),
        ledColor.coronaColor.withOpacity(0.15),
        ledColor.coronaColor.withOpacity(0.05),
        ledColor.coronaColor.withOpacity(0),
      ],
      <double>[0.0, 0.6, 0.7, 0.8, 0.85, 1],
      TileMode.clamp,
      null,
      Offset(ledCenterX, ledCenterY),
      size / 2,
    );
    paint.shader = grad;
    path = Path();
    rect = Rect.fromCenter(center: Offset(ledCenterX, ledCenterY), width: size.toDouble(), height: size.toDouble());
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.drawPath(path, paint);

    var pic = pictureRecorder.endRecording();
    // ledCache[cacheKey] = pic;

    return pic;
  }
}
