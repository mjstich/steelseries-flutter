// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

ui.Image? _hatchBuffer;

ui.Image? hatchBuffer() {
  return _hatchBuffer;
}

Future<ui.Image> hatchBufferInit(
    {double width = 2.0, double height = 2.0}) async {
  if (_hatchBuffer == null) {
    // Setup buffer
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(1, 0);
    path.moveTo(0, 1);
    path.lineTo(0, 1);
    canvas.drawPath(
        path,
        Paint()
          ..color = const Color.fromRGBO(0, 0, 0, 0.1)
          ..style = ui.PaintingStyle.stroke);

    ui.Picture p = pictureRecorder.endRecording();
    final hatchPattern = await p.toImage(2, 2);
    _hatchBuffer = hatchPattern;
  }
  return _hatchBuffer!;
}
