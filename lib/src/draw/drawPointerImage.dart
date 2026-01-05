// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> pointerImageCache = {};

ui.Picture drawPointerImage(double size, PointerTypeEnum ptrType, ColorDef ptrColor, Color lblColor) {
  //String cacheKey = size.toString() + ptrType.toString() + ptrColor.light.toString() + ptrColor.medium.toString();

  // check if we have already created and cached this buffer, if not create it
  //if (!pointerImageCache.containsKey(cacheKey)) {
  // create a pointer buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);

  switch (ptrType) {
    case PointerTypeEnum.TYPE2:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, size * 0.471962),
        Offset(0, size * 0.130841),
        [
          lblColor,
          lblColor,
          ptrColor.light,
          ptrColor.light,
        ],
        [0, 0.36, 0.361, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.518691, size * 0.471962);
      path.lineTo(size * 0.509345, size * 0.462616);
      path.lineTo(size * 0.509345, size * 0.341121);
      path.lineTo(size * 0.504672, size * 0.130841);
      path.lineTo(size * 0.495327, size * 0.130841);
      path.lineTo(size * 0.490654, size * 0.341121);
      path.lineTo(size * 0.490654, size * 0.462616);
      path.lineTo(size * 0.481308, size * 0.471962);
      path.close();
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE3:
      Path path = Path();
      Rect rect = Rect.fromLTWH(size * 0.495327, size * 0.130841, size * 0.009345, size * 0.373831);
      path.addRect(rect);
      path.close();
      Paint paint = Paint()
        ..color = ptrColor.light
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE4:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.467289 * size),
        Offset(0, 0.528036 * size),
        [
          ptrColor.dark,
          ptrColor.dark,
          ptrColor.light,
          ptrColor.light,
        ],
        [0, 0.51, 0.52, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.5, size * 0.126168);
      path.lineTo(size * 0.514018, size * 0.135514);
      path.lineTo(size * 0.53271, size * 0.5);
      path.lineTo(size * 0.523364, size * 0.602803);
      path.lineTo(size * 0.476635, size * 0.602803);
      path.lineTo(size * 0.467289, size * 0.5);
      path.lineTo(size * 0.485981, size * 0.135514);
      path.lineTo(size * 0.5, size * 0.126168);
      path.close();
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE5:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.471962 * size, 0),
        Offset(0.528036 * size, 0),
        [
          ptrColor.light,
          ptrColor.light,
          ptrColor.medium,
          ptrColor.medium,
        ],
        [0, 0.5, 0.5, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.5, size * 0.495327);
      path.lineTo(size * 0.528037, size * 0.495327);
      path.lineTo(size * 0.5, size * 0.149532);
      path.lineTo(size * 0.471962, size * 0.495327);
      path.lineTo(size * 0.5, size * 0.495327);
      path.close();
      canvas.drawPath(path, paint);

      paint = Paint()
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.square
        ..strokeJoin = ui.StrokeJoin.miter
        ..color = ptrColor.dark
        ..style = ui.PaintingStyle.stroke;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE6:
      Paint paint = Paint()
        ..color = ptrColor.medium
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.481308, size * 0.485981);
      path.lineTo(size * 0.481308, size * 0.392523);
      path.lineTo(size * 0.485981, size * 0.317757);
      path.lineTo(size * 0.495327, size * 0.130841);
      path.lineTo(size * 0.504672, size * 0.130841);
      path.lineTo(size * 0.514018, size * 0.317757);
      path.lineTo(size * 0.518691, size * 0.38785);
      path.lineTo(size * 0.518691, size * 0.485981);
      path.lineTo(size * 0.504672, size * 0.485981);
      path.lineTo(size * 0.504672, size * 0.38785);
      path.lineTo(size * 0.5, size * 0.317757);
      path.lineTo(size * 0.495327, size * 0.392523);
      path.lineTo(size * 0.495327, size * 0.485981);
      path.lineTo(size * 0.481308, size * 0.485981);
      path.close();
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE7:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.481308 * size, 0),
        Offset(0.518691 * size, 0),
        [
          ptrColor.dark,
          ptrColor.medium,
        ],
        [0, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.490654, size * 0.130841);
      path.lineTo(size * 0.481308, size * 0.5);
      path.lineTo(size * 0.518691, size * 0.5);
      path.lineTo(size * 0.504672, size * 0.130841);
      path.lineTo(size * 0.490654, size * 0.130841);
      path.close();
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE8:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.471962 * size, 0),
        Offset(0.528036 * size, 0),
        [
          ptrColor.light,
          ptrColor.light,
          ptrColor.medium,
          ptrColor.medium,
        ],
        [0, 0.5, 0.5, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.5, size * 0.53271);
      path.lineTo(size * 0.53271, size * 0.5);
      path.cubicTo(
        size * 0.53271,
        size * 0.5,
        size * 0.509345,
        size * 0.457943,
        size * 0.5,
        size * 0.149532,
      );
      path.cubicTo(
        size * 0.490654,
        size * 0.457943,
        size * 0.467289,
        size * 0.5,
        size * 0.467289,
        size * 0.5,
      );
      path.lineTo(size * 0.5, size * 0.53271);
      path.close();
      canvas.drawPath(path, paint);

      paint = Paint()
        ..color = ptrColor.dark
        ..style = ui.PaintingStyle.stroke;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE9:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.471962 * size, 0),
        Offset(0.528036 * size, 0),
        [
          const Color.fromRGBO(50, 50, 50, 1),
          colorFromHex('#666666'),
          const Color.fromRGBO(50, 50, 50, 1),
        ],
        [0, 0.5, 1],
      );
      //ptrCtx.strokeStyle = '#2E2E2E'
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.495327, size * 0.233644);
      path.lineTo(size * 0.504672, size * 0.233644);
      path.lineTo(size * 0.514018, size * 0.439252);
      path.lineTo(size * 0.485981, size * 0.439252);
      path.lineTo(size * 0.495327, size * 0.233644);
      path.close();
      path.moveTo(size * 0.490654, size * 0.130841);
      path.lineTo(size * 0.471962, size * 0.471962);
      path.lineTo(size * 0.471962, size * 0.528037);
      path.cubicTo(
        size * 0.471962,
        size * 0.528037,
        size * 0.476635,
        size * 0.602803,
        size * 0.476635,
        size * 0.602803,
      );
      path.cubicTo(
        size * 0.476635,
        size * 0.607476,
        size * 0.481308,
        size * 0.607476,
        size * 0.5,
        size * 0.607476,
      );
      path.cubicTo(
        size * 0.518691,
        size * 0.607476,
        size * 0.523364,
        size * 0.607476,
        size * 0.523364,
        size * 0.602803,
      );
      path.cubicTo(
        size * 0.523364,
        size * 0.602803,
        size * 0.528037,
        size * 0.528037,
        size * 0.528037,
        size * 0.528037,
      );
      path.lineTo(size * 0.528037, size * 0.471962);
      path.lineTo(size * 0.509345, size * 0.130841);
      path.lineTo(size * 0.490654, size * 0.130841);
      path.close();
      canvas.drawPath(path, paint);

      path = Path();
      path.moveTo(size * 0.495327, size * 0.219626);
      path.lineTo(size * 0.504672, size * 0.219626);
      path.lineTo(size * 0.504672, size * 0.135514);
      path.lineTo(size * 0.495327, size * 0.135514);
      path.lineTo(size * 0.495327, size * 0.219626);
      path.close();
      paint = Paint()
        ..color = ptrColor.medium
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE10:
      // POINTER_TYPE10
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.471962 * size, 0),
        Offset(0.528036 * size, 0),
        [
          ptrColor.light,
          ptrColor.light,
          ptrColor.medium,
          ptrColor.medium,
        ],
        [0, 0.5, 0.5, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();

      path.moveTo(size * 0.5, size * 0.149532);
      path.cubicTo(
        size * 0.5,
        size * 0.149532,
        size * 0.443925,
        size * 0.490654,
        size * 0.443925,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.443925,
        size * 0.53271,
        size * 0.467289,
        size * 0.556074,
        size * 0.5,
        size * 0.556074,
      );
      path.cubicTo(
        size * 0.53271,
        size * 0.556074,
        size * 0.556074,
        size * 0.53271,
        size * 0.556074,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.556074,
        size * 0.490654,
        size * 0.5,
        size * 0.149532,
        size * 0.5,
        size * 0.149532,
      );
      path.close();
      canvas.drawPath(path, paint);

      paint = Paint()
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.square
        ..strokeJoin = ui.StrokeJoin.miter
        ..color = ptrColor.medium
        ..style = ui.PaintingStyle.stroke;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE11:
      // POINTER_TYPE11
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.168224 * size),
        Offset(0, 0.584112 * size),
        [
          ptrColor.medium,
          ptrColor.dark,
        ],
        [0, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(0.5 * size, 0.168224 * size);
      path.lineTo(0.485981 * size, 0.5 * size);
      path.cubicTo(
        0.485981 * size,
        0.5 * size,
        0.481308 * size,
        0.584112 * size,
        0.5 * size,
        0.584112 * size,
      );
      path.cubicTo(
        0.514018 * size,
        0.584112 * size,
        0.509345 * size,
        0.5 * size,
        0.509345 * size,
        0.5 * size,
      );
      path.lineTo(0.5 * size, 0.168224 * size);
      path.close();
      canvas.drawPath(path, paint);

      paint = Paint()
        ..color = ptrColor.dark
        ..style = ui.PaintingStyle.stroke;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE12:
      // POINTER_TYPE12
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.168224 * size),
        Offset(0, 0.504672 * size),
        [
          ptrColor.medium,
          ptrColor.dark,
        ],
        [0, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      Path path = Path();

      path.moveTo(0.5 * size, 0.168224 * size);
      path.lineTo(0.485981 * size, 0.5 * size);
      path.lineTo(0.5 * size, 0.504672 * size);
      path.lineTo(0.509345 * size, 0.5 * size);
      path.lineTo(0.5 * size, 0.168224 * size);
      path.close();
      canvas.drawPath(path, paint);

      paint = Paint()
        ..color = ptrColor.dark
        ..style = ui.PaintingStyle.stroke;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE13:
    // POINTER_TYPE13
    // eslint-disable-next-line no-fallthrough
    case PointerTypeEnum.TYPE14:
      // POINTER_TYPE14 (same shape as 13)
      Paint paint = Paint()..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(0.485981 * size, 0.168224 * size);
      path.lineTo(0.5 * size, 0.130841 * size);
      path.lineTo(0.509345 * size, 0.168224 * size);
      path.lineTo(0.509345 * size, 0.509345 * size);
      path.lineTo(0.485981 * size, 0.509345 * size);
      path.lineTo(0.485981 * size, 0.168224 * size);
      path.close();
      if (ptrType == PointerTypeEnum.TYPE13) {
        // TYPE13
        ui.Gradient grad = ui.Gradient.linear(
          Offset(0, 0.5 * size),
          Offset(0, 0.130841 * size),
          [
            lblColor,
            lblColor,
            ptrColor.medium,
            ptrColor.medium,
          ],
          [0, 0.85, 0.85, 1],
        );
        paint.shader = grad;
      } else {
        // TYPE14
        ui.Gradient grad = ui.Gradient.linear(
          Offset(0.485981 * size, 0),
          Offset(0.509345 * size, 0),
          [
            ptrColor.veryDark,
            ptrColor.light,
            ptrColor.veryDark,
          ],
          [0, 0.5, 1],
        );
        paint.shader = grad;
      }
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE15:
    // POINTER TYPE15 - Classic with crescent
    // eslint-disable-next-line no-fallthrough
    case PointerTypeEnum.TYPE16:
      // POINTER TYPE16 - Classic without crescent
      Paint paint = Paint()..style = ui.PaintingStyle.fill;
      Path path = Path();
      path.moveTo(size * 0.509345, size * 0.457943);
      path.lineTo(size * 0.5015, size * 0.13);
      path.lineTo(size * 0.4985, size * 0.13);
      path.lineTo(size * 0.490654, size * 0.457943);
      path.cubicTo(
        size * 0.490654,
        size * 0.457943,
        size * 0.490654,
        size * 0.457943,
        size * 0.490654,
        size * 0.457943,
      );
      path.cubicTo(
        size * 0.471962,
        size * 0.462616,
        size * 0.457943,
        size * 0.481308,
        size * 0.457943,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.457943,
        size * 0.518691,
        size * 0.471962,
        size * 0.537383,
        size * 0.490654,
        size * 0.542056,
      );
      path.cubicTo(
        size * 0.490654,
        size * 0.542056,
        size * 0.490654,
        size * 0.542056,
        size * 0.490654,
        size * 0.542056,
      );
      if (ptrType == PointerTypeEnum.TYPE15) {
        path.lineTo(size * 0.490654, size * 0.57);
        path.cubicTo(
          size * 0.46,
          size * 0.58,
          size * 0.46,
          size * 0.62,
          size * 0.490654,
          size * 0.63,
        );
        path.cubicTo(
          size * 0.47,
          size * 0.62,
          size * 0.48,
          size * 0.59,
          size * 0.5,
          size * 0.59,
        );
        path.cubicTo(
          size * 0.53,
          size * 0.59,
          size * 0.52,
          size * 0.62,
          size * 0.509345,
          size * 0.63,
        );
        path.cubicTo(
          size * 0.54,
          size * 0.62,
          size * 0.54,
          size * 0.58,
          size * 0.509345,
          size * 0.57,
        );
        path.lineTo(size * 0.509345, size * 0.57);
      } else {
        path.lineTo(size * 0.490654, size * 0.621495);
        path.lineTo(size * 0.509345, size * 0.621495);
      }
      path.lineTo(size * 0.509345, size * 0.542056);
      path.cubicTo(
        size * 0.509345,
        size * 0.542056,
        size * 0.509345,
        size * 0.542056,
        size * 0.509345,
        size * 0.542056,
      );
      path.cubicTo(
        size * 0.528037,
        size * 0.537383,
        size * 0.542056,
        size * 0.518691,
        size * 0.542056,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.542056,
        size * 0.481308,
        size * 0.528037,
        size * 0.462616,
        size * 0.509345,
        size * 0.457943,
      );
      path.cubicTo(
        size * 0.509345,
        size * 0.457943,
        size * 0.509345,
        size * 0.457943,
        size * 0.509345,
        size * 0.457943,
      );
      path.close();
      if (ptrType == PointerTypeEnum.TYPE15) {
        ui.Gradient grad = ui.Gradient.linear(
          const Offset(0, 0),
          Offset(0, size * 0.63),
          [
            ptrColor.medium,
            ptrColor.medium,
            ptrColor.light,
            ptrColor.medium,
            ptrColor.medium,
          ],
          [0, 0.388888, 0.5, 0.611111, 1],
        );
        paint.shader = grad;
      } else {
        ui.Gradient grad = ui.Gradient.linear(
          const Offset(0, 0),
          Offset(0, size * 0.621495),
          [
            ptrColor.medium,
            ptrColor.medium,
            ptrColor.light,
            ptrColor.medium,
            ptrColor.medium,
          ],
          [0, 0.388888, 0.5, 0.611111, 1],
        );
        paint.shader = grad;
      }
      canvas.drawPath(path, paint);

      paint = Paint()
        ..color = ptrColor.dark
        ..style = ui.PaintingStyle.stroke;
      canvas.drawPath(path, paint);

      // Draw the rings
      path = Path();
      Rect rect = Rect.fromCenter(center: Offset(size * 0.5, size * 0.5), width: (size * 0.06542), height: (size * 0.06542));
      path.addArc(rect, 0, TWO_PI);
      path.close();
      double radius = (size * 0.06542) / 2;
      ui.Gradient grad = ui.Gradient.linear(
        Offset(size * 0.5 - radius, size * 0.5 - radius),
        Offset(0, size * 0.5 - radius),
        [
          colorFromHex('#e6b35c'),
          colorFromHex('#e6b35c'),
          colorFromHex('#c48200'),
          colorFromHex('#c48200'),
        ],
        [0, 0.01, 0.99, 1],
      );
      paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, paint);

      path = Path();
      rect = Rect.fromCenter(center: Offset(size * 0.5, size * 0.5), width: (size * 0.046728), height: (size * 0.046728));
      path.addArc(rect, 0, TWO_PI);
      path.close();
      radius = (size * 0.046728) / 2;

      grad = ui.Gradient.radial(
          Offset(size * 0.5, size * 0.5),
          0,
          [
            colorFromHex('#c5c5c5'),
            colorFromHex('#c5c5c5'),
            colorFromHex('#000000'),
            colorFromHex('#000000'),
            colorFromHex('#707070'),
            colorFromHex('#707070'),
          ],
          <double>[0.0, 0.19, 0.22, 0.8, 0.99, 1],
          TileMode.clamp,
          null,
          Offset(size * 0.5, size * 0.5),
          radius);

      paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, paint);
      break;

    case PointerTypeEnum.TYPE1:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, size * 0.471962),
        Offset(0, size * 0.130841),
        [
          ptrColor.veryDark,
          ptrColor.medium,
          ptrColor.medium,
          ptrColor.veryDark,
        ],
        [0, 0.3, 0.59, 1],
      );
      Paint paint = Paint()
        ..shader = grad
        ..style = ui.PaintingStyle.fill;

      Path path = Path();
      path.moveTo(size * 0.518691, size * 0.471962);
      path.cubicTo(
        size * 0.514018,
        size * 0.457943,
        size * 0.509345,
        size * 0.415887,
        size * 0.509345,
        size * 0.401869,
      );
      path.cubicTo(
        size * 0.504672,
        size * 0.383177,
        size * 0.5,
        size * 0.130841,
        size * 0.5,
        size * 0.130841,
      );
      path.cubicTo(
        size * 0.5,
        size * 0.130841,
        size * 0.490654,
        size * 0.383177,
        size * 0.490654,
        size * 0.397196,
      );
      path.cubicTo(
        size * 0.490654,
        size * 0.415887,
        size * 0.485981,
        size * 0.457943,
        size * 0.481308,
        size * 0.471962,
      );
      path.cubicTo(
        size * 0.471962,
        size * 0.481308,
        size * 0.467289,
        size * 0.490654,
        size * 0.467289,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.467289,
        size * 0.518691,
        size * 0.481308,
        size * 0.53271,
        size * 0.5,
        size * 0.53271,
      );
      path.cubicTo(
        size * 0.518691,
        size * 0.53271,
        size * 0.53271,
        size * 0.518691,
        size * 0.53271,
        size * 0.5,
      );
      path.cubicTo(
        size * 0.53271,
        size * 0.490654,
        size * 0.528037,
        size * 0.481308,
        size * 0.518691,
        size * 0.471962,
      );
      path.close();
      canvas.drawPath(path, paint);
      break;
  }
  // cache buffer
  var pic = pictureRecorder.endRecording();
  return pic;
  //   pointerImageCache[cacheKey] = pic;
  // }

  // return pointerImageCache[cacheKey]!;
}
