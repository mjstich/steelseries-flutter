// ignore_for_file: file_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Map<String, ui.Picture> measuredValueImageCache = {};

ui.Picture createMeasuredValueImage(
    double size, Color indicatorColor, bool radial, bool vertical) {
  //String cacheKey = size.toString() + indicatorColor.toString() + radial.toString() + vertical.toString();

  // check if we have already created and cached this buffer, if so return it and exit
  //if (!measuredValueImageCache.containsKey(cacheKey)) {
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);
  Paint paint = Paint()
    ..color = indicatorColor
    ..style = ui.PaintingStyle.fill;

  if (radial) {
    Path path = Path();
    path.moveTo(size * 0.5, size);
    path.lineTo(0, 0);
    path.lineTo(size, 0);
    path.close();
    canvas.drawPath(path, paint);
  } else {
    if (vertical) {
      Path path = Path();
      path.moveTo(size, size * 0.5);
      path.lineTo(0, 0);
      path.lineTo(0, size);
      path.close();
      canvas.drawPath(path, paint);
    } else {
      Path path = Path();
      path.moveTo(size * 0.5, 0);
      path.lineTo(size, size);
      path.lineTo(0, size);
      path.close();
      canvas.drawPath(path, paint);
    }
  }
  var pic = pictureRecorder.endRecording();
  return pic;
  //   // cache the buffer
  //   measuredValueImageCache[cacheKey] = pic;
  // }
  // return measuredValueImageCache[cacheKey]!;
}
