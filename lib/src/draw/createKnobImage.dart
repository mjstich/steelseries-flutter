// ignore_for_file: file_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> knobImageCache = {};

ui.Picture createKnobImage(double size, KnobTypeEnum knob, KnobStyleEnum style) {
  double maxPostCenterX = size / 2;
  double maxPostCenterY = size / 2;

  //String cacheKey = size.toString() + knob.toString() + style.toString();

  // check if we have already created and cached this buffer, if not create it
  //if (!knobImageCache.containsKey(cacheKey)) {
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);
  var paint = Paint();
  paint.isAntiAlias = true;
  paint.style = ui.PaintingStyle.fill;
  //knobBuffer = createBuffer(size * 1.18889, size * 1.18889)

  switch (knob) {
    case KnobTypeEnum.METAL_KNOB:
      // METALKNOB_FRAME
      Path path = Path();
      path.moveTo(0, size * 0.5);
      path.cubicTo(
        0,
        size * 0.222222,
        size * 0.222222,
        0,
        size * 0.5,
        0,
      );
      path.cubicTo(
        size * 0.777777,
        0,
        size,
        size * 0.222222,
        size,
        size * 0.5,
      );
      path.cubicTo(
        size,
        size * 0.777777,
        size * 0.777777,
        size,
        size * 0.5,
        size,
      );
      path.cubicTo(size * 0.222222, size, 0, size * 0.777777, 0, size * 0.5);
      path.close();
      ui.Gradient grad = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, size),
        [
          const Color.fromRGBO(92, 95, 101, 1),
          const Color.fromRGBO(46, 49, 53, 1),
          const Color.fromRGBO(22, 23, 26, 1),
        ],
        [0, 0.47, 1],
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);

      // METALKNOB_MAIN
      path = Path();
      path.moveTo(size * 0.055555, size * 0.5);
      path.cubicTo(
        size * 0.055555,
        size * 0.277777,
        size * 0.277777,
        size * 0.055555,
        size * 0.5,
        size * 0.055555,
      );
      path.cubicTo(
        size * 0.722222,
        size * 0.055555,
        size * 0.944444,
        size * 0.277777,
        size * 0.944444,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.944444,
        size * 0.722222,
        size * 0.722222,
        size * 0.944444,
        size * 0.5,
        size * 0.944444,
      );
      path.cubicTo(
        size * 0.277777,
        size * 0.944444,
        size * 0.055555,
        size * 0.722222,
        size * 0.055555,
        size * 0.5,
      );
      path.close();

      List<Color> gradColors = [];
      switch (style) {
        case KnobStyleEnum.BLACK:
          gradColors.add(const Color.fromRGBO(43, 42, 47, 1));
          gradColors.add(const Color.fromRGBO(26, 27, 32, 1));
          break;

        case KnobStyleEnum.BRASS:
          gradColors.add(const Color.fromRGBO(150, 110, 54, 1));
          gradColors.add(const Color.fromRGBO(124, 95, 61, 1));
          break;

        case KnobStyleEnum.SILVER:
          gradColors.add(const Color.fromRGBO(204, 204, 204, 1));
          gradColors.add(const Color.fromRGBO(87, 92, 98, 1));
          break;
      }
      grad = ui.Gradient.linear(
        Offset(0, 0.055555 * size),
        Offset(0, 0.944443 * size),
        gradColors,
        [0, 1],
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);

      // METALKNOB_LOWERHL
      path = Path();
      path.moveTo(size * 0.777777, size * 0.833333);
      path.cubicTo(
        size * 0.722222,
        size * 0.722222,
        size * 0.611111,
        size * 0.666666,
        size * 0.5,
        size * 0.666666,
      );
      path.cubicTo(
        size * 0.388888,
        size * 0.666666,
        size * 0.277777,
        size * 0.722222,
        size * 0.222222,
        size * 0.833333,
      );
      path.cubicTo(
        size * 0.277777,
        size * 0.888888,
        size * 0.388888,
        size * 0.944444,
        size * 0.5,
        size * 0.944444,
      );
      path.cubicTo(
        size * 0.611111,
        size * 0.944444,
        size * 0.722222,
        size * 0.888888,
        size * 0.777777,
        size * 0.833333,
      );
      path.close();
      grad = ui.Gradient.radial(
        Offset(0.555555 * size, 0.944444 * size),
        0,
        [
          const Color.fromRGBO(255, 255, 255, 0.6),
          const Color.fromRGBO(255, 255, 255, 0),
        ],
        <double>[0.0, 1],
        TileMode.clamp,
        null,
        Offset(0.555555 * size, 0.944444 * size),
        0.388888 * size,
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);

      // METALKNOB_UPPERHL
      path = Path();
      path.moveTo(size * 0.944444, size * 0.277777);
      path.cubicTo(
        size * 0.833333,
        size * 0.111111,
        size * 0.666666,
        0,
        size * 0.5,
        0,
      );
      path.cubicTo(
        size * 0.333333,
        0,
        size * 0.166666,
        size * 0.111111,
        size * 0.055555,
        size * 0.277777,
      );
      path.cubicTo(
        size * 0.166666,
        size * 0.333333,
        size * 0.333333,
        size * 0.388888,
        size * 0.5,
        size * 0.388888,
      );
      path.cubicTo(
        size * 0.666666,
        size * 0.388888,
        size * 0.833333,
        size * 0.333333,
        size * 0.944444,
        size * 0.277777,
      );
      path.close();
      grad = ui.Gradient.radial(
        Offset(0.5 * size, 0),
        0,
        [
          const Color.fromRGBO(255, 255, 255, 0.749019),
          const Color.fromRGBO(255, 255, 255, 0),
        ],
        <double>[0.0, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * size, 0),
        0.583333 * size,
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);

      // METALKNOB_INNERFRAME
      path = Path();
      path.moveTo(size * 0.277777, size * 0.555555);
      path.cubicTo(
        size * 0.277777,
        size * 0.388888,
        size * 0.388888,
        size * 0.277777,
        size * 0.5,
        size * 0.277777,
      );
      path.cubicTo(
        size * 0.611111,
        size * 0.277777,
        size * 0.777777,
        size * 0.388888,
        size * 0.777777,
        size * 0.555555,
      );
      path.cubicTo(
        size * 0.777777,
        size * 0.666666,
        size * 0.611111,
        size * 0.777777,
        size * 0.5,
        size * 0.777777,
      );
      path.cubicTo(
        size * 0.388888,
        size * 0.777777,
        size * 0.277777,
        size * 0.666666,
        size * 0.277777,
        size * 0.555555,
      );
      path.close();
      grad = ui.Gradient.linear(
        Offset(0, 0.277777 * size),
        Offset(0, 0.722221 * size),
        [
          colorFromHex('#000000'),
          const Color.fromRGBO(204, 204, 204, 1),
        ],
        [0, 1],
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);

      // METALKNOB_INNERBACKGROUND
      path = Path();
      path.moveTo(size * 0.333333, size * 0.555555);
      path.cubicTo(
        size * 0.333333,
        size * 0.444444,
        size * 0.388888,
        size * 0.333333,
        size * 0.5,
        size * 0.333333,
      );
      path.cubicTo(
        size * 0.611111,
        size * 0.333333,
        size * 0.722222,
        size * 0.444444,
        size * 0.722222,
        size * 0.555555,
      );
      path.cubicTo(
        size * 0.722222,
        size * 0.611111,
        size * 0.611111,
        size * 0.722222,
        size * 0.5,
        size * 0.722222,
      );
      path.cubicTo(
        size * 0.388888,
        size * 0.722222,
        size * 0.333333,
        size * 0.611111,
        size * 0.333333,
        size * 0.555555,
      );
      path.close();
      grad = ui.Gradient.linear(
        Offset(0, 0.333333 * size),
        Offset(0, 0.666666 * size),
        [
          const Color.fromRGBO(10, 9, 1, 1),
          const Color.fromRGBO(42, 41, 37, 1),
        ],
        [0, 1],
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);
      break;

    case KnobTypeEnum.STANDARD_KNOB:
      ui.Gradient grad = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, size),
        [
          const Color.fromRGBO(180, 180, 180, 1),
          const Color.fromRGBO(63, 63, 63, 1),
          const Color.fromRGBO(40, 40, 40, 1),
        ],
        [0, 0.46, 1],
      );
      paint.shader = grad;
      Rect rect = Rect.fromCenter(center: Offset(maxPostCenterX, maxPostCenterY), width: size, height: size);
      Path path = Path();
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.drawPath(path, paint);

      List<Color> gradColors = [];
      switch (style) {
        case KnobStyleEnum.BLACK:
          gradColors.add(const Color.fromRGBO(191, 191, 191, 1));
          gradColors.add(const Color.fromRGBO(45, 44, 49, 1));
          gradColors.add(const Color.fromRGBO(125, 126, 128, 1));
          break;

        case KnobStyleEnum.BRASS:
          gradColors.add(const Color.fromRGBO(223, 208, 174, 1));
          gradColors.add(const Color.fromRGBO(123, 95, 63, 1));
          gradColors.add(const Color.fromRGBO(207, 190, 157, 1));
          break;

        case KnobStyleEnum.SILVER:
          gradColors.add(const Color.fromRGBO(215, 215, 215, 1));
          gradColors.add(const Color.fromRGBO(116, 116, 116, 1));
          gradColors.add(const Color.fromRGBO(215, 215, 215, 1));
          break;
      }
      grad = ui.Gradient.linear(
        Offset(0, size - size * 0.77),
        Offset(0, size * 0.77 + size * 0.77),
        gradColors,
        [0, 0.5, 1],
      );
      paint.shader = grad;
      path = Path();
      rect = Rect.fromCenter(center: Offset(maxPostCenterX, maxPostCenterY), width: (size * 0.77), height: (size * 0.77));
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.drawPath(path, paint);

      grad = ui.Gradient.radial(
        Offset(maxPostCenterX, maxPostCenterY),
        0,
        [
          const Color.fromRGBO(0, 0, 0, 0),
          const Color.fromRGBO(0, 0, 0, 0),
          const Color.fromRGBO(0, 0, 0, 0.01),
          const Color.fromRGBO(0, 0, 0, 0.2),
        ],
        <double>[0.0, 0.75, 0.76, 1],
        TileMode.clamp,
        null,
        Offset(maxPostCenterX, maxPostCenterY),
        (size * 0.77) / 2,
      );
      paint.shader = grad;
      path = Path();
      rect = Rect.fromCenter(center: Offset(maxPostCenterX, maxPostCenterY), width: (size * 0.77), height: (size * 0.77));
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.drawPath(path, paint);
      break;
  }

  var pic = pictureRecorder.endRecording();
  return pic;

  //   // cache the buffer
  //   knobImageCache[cacheKey] = pic;
  // }
  // return knobImageCache[cacheKey]!;
}
