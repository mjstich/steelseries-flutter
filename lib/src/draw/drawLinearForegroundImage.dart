// ignore_for_file: file_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Map<String, ui.Picture> linearForegroundImageCache = {};

ui.Picture drawLinearForegroundImage(
    double imageWidth, double imageHeight, bool vertical) {
  //String cacheKey = imageWidth.toString() + imageHeight.toString() + vertical.toString();

  // check if we have already created and cached this buffer, if not create it
  //if (!linearForegroundImageCache.containsKey(cacheKey)) {
  // Setup buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);

  double frameWidth =
      math.sqrt(imageWidth * imageWidth + imageHeight * imageHeight) * 0.04;
  frameWidth =
      math.min(frameWidth, (vertical ? imageWidth : imageHeight) * 0.1);
  double fgOffset = frameWidth * 1.3;
  double fgOffset2 = fgOffset * 1.33;

  Path path = Path();
  path.moveTo(fgOffset, imageHeight - fgOffset);
  path.lineTo(imageWidth - fgOffset, imageHeight - fgOffset);
  path.cubicTo(
    imageWidth - fgOffset,
    imageHeight - fgOffset,
    imageWidth - fgOffset2,
    imageHeight * 0.7,
    imageWidth - fgOffset2,
    imageHeight * 0.5,
  );
  path.cubicTo(
    imageWidth - fgOffset2,
    fgOffset2,
    imageWidth - fgOffset,
    fgOffset,
    imageWidth - frameWidth,
    fgOffset,
  );
  path.lineTo(fgOffset, fgOffset);
  path.cubicTo(
    fgOffset,
    fgOffset,
    fgOffset2,
    imageHeight * 0.285714,
    fgOffset2,
    imageHeight * 0.5,
  );
  path.cubicTo(
    fgOffset2,
    imageHeight * 0.7,
    fgOffset,
    imageHeight - fgOffset,
    frameWidth,
    imageHeight - fgOffset,
  );
  path.close();

  ui.Gradient grad = ui.Gradient.linear(
    Offset(0, imageHeight - frameWidth),
    Offset(0, frameWidth),
    [
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0.013546),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0.082217),
      const Color.fromRGBO(255, 255, 255, 0.288702),
      const Color.fromRGBO(255, 255, 255, 0.298039),
      const Color.fromRGBO(255, 255, 255, 0.119213),
      const Color.fromRGBO(255, 255, 255, 0),
      const Color.fromRGBO(255, 255, 255, 0),
    ],
    [
      0,
      0.06,
      0.07,
      0.12,
      0.17,
      0.1701,
      0.79,
      0.8,
      0.84,
      0.93,
      0.94,
      0.96,
      0.97,
      1
    ],
  );
  Paint paint = Paint()
    ..shader = grad
    ..style = ui.PaintingStyle.fill;
  canvas.drawPath(path, paint);

  // cache the buffer
  var pic = pictureRecorder.endRecording();
  return pic;
  //   linearForegroundImageCache[cacheKey] = pic;
  // }
  // return linearForegroundImageCache[cacheKey]!;
}
