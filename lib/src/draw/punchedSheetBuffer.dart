// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'tools.dart';

ui.Image? _punchedSheetBuffer;

ui.Image? punchedSheetBuffer() {
  return _punchedSheetBuffer;
}

Future<ui.Image> punchedSheetBufferInit({double width = 15.0, double height = 15.0}) async {
  if (_punchedSheetBuffer == null) {
    double imageWidth = width;
    double imageHeight = height;

    // Setup buffer
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);

    // BACK
    Path path = Path();
    Rect rect = Rect.fromLTWH(0, 0, imageWidth, imageHeight);
    path.addRect(rect);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#1D2123')
          ..style = ui.PaintingStyle.fill);

    // ULB
    path = Path();
    path.moveTo(0, imageHeight * 0.266666);
    path.cubicTo(
      0,
      imageHeight * 0.4,
      imageWidth * 0.066666,
      imageHeight * 0.466666,
      imageWidth * 0.2,
      imageHeight * 0.466666,
    );
    path.cubicTo(
      imageWidth * 0.333333,
      imageHeight * 0.466666,
      imageWidth * 0.4,
      imageHeight * 0.4,
      imageWidth * 0.4,
      imageHeight * 0.266666,
    );
    path.cubicTo(
      imageWidth * 0.4,
      imageHeight * 0.133333,
      imageWidth * 0.333333,
      imageHeight * 0.066666,
      imageWidth * 0.2,
      imageHeight * 0.066666,
    );
    path.cubicTo(
      imageWidth * 0.066666,
      imageHeight * 0.066666,
      0,
      imageHeight * 0.133333,
      0,
      imageHeight * 0.266666,
    );
    path.close();
    ui.Gradient grad = ui.Gradient.linear(
      Offset(0, 0.066666 * imageHeight),
      Offset(0, 0.466666 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#444444'),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // ULF
    path = Path();
    path.moveTo(0, imageHeight * 0.2);
    path.cubicTo(
      0,
      imageHeight * 0.333333,
      imageWidth * 0.066666,
      imageHeight * 0.4,
      imageWidth * 0.2,
      imageHeight * 0.4,
    );
    path.cubicTo(
      imageWidth * 0.333333,
      imageHeight * 0.4,
      imageWidth * 0.4,
      imageHeight * 0.333333,
      imageWidth * 0.4,
      imageHeight * 0.2,
    );
    path.cubicTo(
      imageWidth * 0.4,
      imageHeight * 0.066666,
      imageWidth * 0.333333,
      0,
      imageWidth * 0.2,
      0,
    );
    path.cubicTo(
      imageWidth * 0.066666,
      0,
      0,
      imageHeight * 0.066666,
      0,
      imageHeight * 0.2,
    );
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#050506')
          ..style = ui.PaintingStyle.fill);

    // LRB
    path = Path();
    path.moveTo(imageWidth * 0.466666, imageHeight * 0.733333);
    path.cubicTo(
      imageWidth * 0.466666,
      imageHeight * 0.866666,
      imageWidth * 0.533333,
      imageHeight * 0.933333,
      imageWidth * 0.666666,
      imageHeight * 0.933333,
    );
    path.cubicTo(
      imageWidth * 0.8,
      imageHeight * 0.933333,
      imageWidth * 0.866666,
      imageHeight * 0.866666,
      imageWidth * 0.866666,
      imageHeight * 0.733333,
    );
    path.cubicTo(
      imageWidth * 0.866666,
      imageHeight * 0.6,
      imageWidth * 0.8,
      imageHeight * 0.533333,
      imageWidth * 0.666666,
      imageHeight * 0.533333,
    );
    path.cubicTo(
      imageWidth * 0.533333,
      imageHeight * 0.533333,
      imageWidth * 0.466666,
      imageHeight * 0.6,
      imageWidth * 0.466666,
      imageHeight * 0.733333,
    );
    path.close();
    grad = ui.Gradient.linear(
      Offset(0, 0.533333 * imageHeight),
      Offset(0, 0.933333 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#444444'),
      ],
      [0, 1],
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // LRF
    path = Path();
    path.moveTo(imageWidth * 0.466666, imageHeight * 0.666666);
    path.cubicTo(
      imageWidth * 0.466666,
      imageHeight * 0.8,
      imageWidth * 0.533333,
      imageHeight * 0.866666,
      imageWidth * 0.666666,
      imageHeight * 0.866666,
    );
    path.cubicTo(
      imageWidth * 0.8,
      imageHeight * 0.866666,
      imageWidth * 0.866666,
      imageHeight * 0.8,
      imageWidth * 0.866666,
      imageHeight * 0.666666,
    );
    path.cubicTo(
      imageWidth * 0.866666,
      imageHeight * 0.533333,
      imageWidth * 0.8,
      imageHeight * 0.466666,
      imageWidth * 0.666666,
      imageHeight * 0.466666,
    );
    path.cubicTo(
      imageWidth * 0.533333,
      imageHeight * 0.466666,
      imageWidth * 0.466666,
      imageHeight * 0.533333,
      imageWidth * 0.466666,
      imageHeight * 0.666666,
    );
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#050506')
          ..style = ui.PaintingStyle.fill);

    ui.Picture p = pictureRecorder.endRecording();

    final carbonPattern = await p.toImage(12, 12);

    _punchedSheetBuffer = carbonPattern;
  }
  return _punchedSheetBuffer!;
}
