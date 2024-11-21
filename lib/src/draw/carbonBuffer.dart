// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'tools.dart';

ui.Image? _carbonBuffer;

ui.Image? carbonBuffer() {
  return _carbonBuffer;
}

Future<ui.Image> carbonBufferInit({double width = 12.0, double height = 12.0}) async {
  if (_carbonBuffer == null) {
    double imageWidth = width;
    double imageHeight = height;
    double offsetY = 0;

    // Setup buffer
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);

    // RULB
    //canvas.save();
    Path path = Path();
    Rect rect = Rect.fromLTWH(0, 0, imageWidth * 0.5, imageHeight * 0.5);
    path.addRect(rect);
    path.close();
    //canvas.restore();

    ui.Gradient grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.5 * imageHeight + offsetY * imageHeight),
      [
        const Color.fromRGBO(35, 35, 35, 1),
        const Color.fromRGBO(23, 23, 23, 1),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RULF
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.083333, 0, imageWidth * 0.333333, imageHeight * 0.416666);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0;

    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.416666 * imageHeight + offsetY * imageHeight),
      [
        const Color.fromRGBO(38, 38, 38, 1),
        const Color.fromRGBO(30, 30, 30, 1),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RLRB
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.5, imageHeight * 0.5, imageWidth * 0.5, imageHeight * 0.5);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0.5;
    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.5 * imageHeight + offsetY * imageHeight),
      [
        const Color.fromRGBO(35, 35, 35, 1),
        const Color.fromRGBO(23, 23, 23, 1),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RLRF
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.583333, imageHeight * 0.5, imageWidth * 0.333333, imageHeight * 0.416666);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0.5;
    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.416666 * imageHeight + offsetY * imageHeight),
      [
        const Color.fromRGBO(38, 38, 38, 1),
        const Color.fromRGBO(30, 30, 30, 1),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RURB
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.5, 0, imageWidth * 0.5, imageHeight * 0.5);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0;
    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.5 * imageHeight + offsetY * imageHeight),
      [
        colorFromHex('#303030'),
        const Color.fromRGBO(40, 40, 40, 1),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RURF
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.583333, imageHeight * 0.083333, imageWidth * 0.333333, imageHeight * 0.416666);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0.083333;
    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.416666 * imageHeight + offsetY * imageHeight),
      [
        const Color.fromRGBO(53, 53, 53, 1),
        const Color.fromRGBO(45, 45, 45, 1),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RLLB
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(0, imageHeight * 0.5, imageWidth * 0.5, imageHeight * 0.5);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0.5;
    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.5 * imageHeight + offsetY * imageHeight),
      [
        colorFromHex('#303030'),
        colorFromHex('#282828'),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // RLLF
    //canvas.save();
    path = Path();
    rect = Rect.fromLTWH(imageWidth * 0.083333, imageHeight * 0.583333, imageWidth * 0.333333, imageHeight * 0.416666);
    path.addRect(rect);
    path.close();
    //canvas.restore();
    offsetY = 0.583333;
    grad = ui.Gradient.linear(
      Offset(0, offsetY * imageHeight),
      Offset(0, 0.416666 * imageHeight + offsetY * imageHeight),
      [
        colorFromHex('#353535'),
        colorFromHex('#2d2d2d'),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    ui.Picture p = pictureRecorder.endRecording();

    final carbonPattern = await p.toImage(12, 12);

    _carbonBuffer = carbonPattern;
  }
  return _carbonBuffer!;
}
