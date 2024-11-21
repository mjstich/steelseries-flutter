// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'tools.dart';

void drawRadialCustomImage(
  Canvas ctx,
  ui.Image? img,
  double centerX,
  double centerY,
  double imageWidth,
  double imageHeight,
) {
  double drawWidth = imageWidth * 0.831775;
  double drawHeight = imageHeight * 0.831775;
  double x = (imageWidth - drawWidth) / 2;
  double y = (imageHeight - drawHeight) / 2;

  if (img != null && img.height > 0 && img.width > 0) {
    ctx.save();
    // Set the clipping area
    Path path = Path();
    Rect rect = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: (imageWidth * 0.831775),
        height: (imageWidth * 0.831775));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    ctx.clipPath(path);

    // Add the image
    ctx.drawImage(img, Offset(x, y), Paint());
    ctx.restore();
  }
}
