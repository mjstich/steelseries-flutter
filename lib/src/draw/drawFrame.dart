// ignore_for_file: file_names, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> drawFrameCache = {};

ui.Picture drawFrame(FrameDesignEnum frameDesign, double centerX, double centerY, double imageWidth, double imageHeight) {
  //String cacheKey = imageWidth.toString() + imageHeight.toString() + frameDesign.toString();

  // check if we have already created and cached this buffer, if not create it
  //if (!drawFrameCache.containsKey(cacheKey)) {
  // Setup buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);

  Paint strokePaint = Paint()
    ..style = ui.PaintingStyle.stroke
    ..color = const Color.fromRGBO(132, 132, 132, 0.5)
    ..isAntiAlias = true;
  Paint fillPaint = Paint()
    ..style = ui.PaintingStyle.fill
    ..color = colorFromHex('#848484')
    ..isAntiAlias = true;

  // outer gray frame
  Path path = Path();
  Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: imageWidth, height: imageWidth);
  path.addArc(rect, 0, TWO_PI);
  path.close();

  canvas.drawPath(path, fillPaint);
  canvas.drawPath(path, strokePaint);

  path = Path();
  rect = Rect.fromCenter(center: Offset(centerX, centerY), width: imageWidth * 0.990654, height: imageWidth * 0.990654);
  path.addArc(rect, 0, TWO_PI);
  path.close();

  // main gradient frame
  switch (frameDesign) {
    case FrameDesignEnum.METAL:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, imageWidth * 0.004672),
        Offset(0, imageHeight * 0.990654),
        [
          colorFromHex('#fefefe'),
          const Color.fromRGBO(210, 210, 210, 1),
          const Color.fromRGBO(179, 179, 179, 1),
          const Color.fromRGBO(213, 213, 213, 1),
        ],
        [0, 0.07, 0.12, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.BRASS:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, imageWidth * 0.004672),
        Offset(0, imageHeight * 0.990654),
        [
          const Color.fromRGBO(249, 243, 155, 1),
          const Color.fromRGBO(246, 226, 101, 1),
          const Color.fromRGBO(240, 225, 132, 1),
          const Color.fromRGBO(90, 57, 22, 1),
          const Color.fromRGBO(249, 237, 139, 1),
          const Color.fromRGBO(243, 226, 108, 1),
          const Color.fromRGBO(202, 182, 113, 1),
        ],
        [0, 0.05, 0.1, 0.5, 0.9, 0.95, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.STEEL:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, imageWidth * 0.004672),
        Offset(0, imageHeight * 0.990654),
        [
          const Color.fromRGBO(231, 237, 237, 1),
          const Color.fromRGBO(189, 199, 198, 1),
          const Color.fromRGBO(192, 201, 200, 1),
          const Color.fromRGBO(23, 31, 33, 1),
          const Color.fromRGBO(196, 205, 204, 1),
          const Color.fromRGBO(194, 204, 203, 1),
          const Color.fromRGBO(189, 201, 199, 1),
        ],
        [0, 0.05, 0.1, 0.5, 0.9, 0.95, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.GOLD:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, imageWidth * 0.004672),
        Offset(0, imageHeight * 0.990654),
        [
          const Color.fromRGBO(255, 255, 207, 1),
          const Color.fromRGBO(255, 237, 96, 1),
          const Color.fromRGBO(254, 199, 57, 1),
          const Color.fromRGBO(255, 249, 203, 1),
          const Color.fromRGBO(255, 199, 64, 1),
          const Color.fromRGBO(252, 194, 60, 1),
          const Color.fromRGBO(255, 204, 59, 1),
          const Color.fromRGBO(213, 134, 29, 1),
          const Color.fromRGBO(255, 201, 56, 1),
          const Color.fromRGBO(212, 135, 29, 1),
          const Color.fromRGBO(247, 238, 101, 1),
        ],
        [0, 0.15, 0.22, 0.3, 0.38, 0.44, 0.51, 0.6, 0.68, 0.75, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.ANTHRACITE:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, imageWidth * 0.004672),
        Offset(0, imageHeight * 0.990654),
        [
          const Color.fromRGBO(118, 117, 135, 1),
          const Color.fromRGBO(74, 74, 82, 1),
          const Color.fromRGBO(50, 50, 54, 1),
          const Color.fromRGBO(79, 79, 87, 1),
        ],
        [0, 0.06, 0.12, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.TILTED_GRAY:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.233644 * imageWidth, 0.084112 * imageHeight),
        Offset(0.81258 * imageWidth, 0.910919 * imageHeight),
        [
          colorFromHex('#ffffff'),
          const Color.fromRGBO(210, 210, 210, 1),
          const Color.fromRGBO(179, 179, 179, 1),
          colorFromHex('#ffffff'),
          colorFromHex('#c5c5c5'),
          colorFromHex('#ffffff'),
          colorFromHex('#666666'),
        ],
        [0, 0.07, 0.16, 0.33, 0.55, 0.79, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.TILTED_BLACK:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.228971 * imageWidth, 0.079439 * imageHeight),
        Offset(0.802547 * imageWidth, 0.898591 * imageHeight),
        [
          colorFromHex('#666666'),
          colorFromHex('#000000'),
          colorFromHex('#666666'),
          colorFromHex('#000000'),
          colorFromHex('#000000'),
        ],
        [0, 0.21, 0.47, 0.99, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.GLOSSY_METAL:
      var grad = ui.Gradient.radial(
        Offset(0.5 * imageWidth, 0.5 * imageHeight),
        0,
        [
          const Color.fromRGBO(207, 207, 207, 1),
          const Color.fromRGBO(205, 204, 205, 1),
          const Color.fromRGBO(244, 244, 244, 1),
        ],
        <double>[0.0, 0.96, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * imageWidth, 0.5 * imageWidth),
        0.5 * imageWidth,
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);

      path = Path();
      rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: (0.973962 * imageWidth), height: (0.973962 * imageWidth));
      path.addArc(rect, 0, TWO_PI);
      path.close();

      grad = ui.Gradient.linear(
        Offset(0, imageHeight - 0.971962 * imageHeight),
        Offset(0, 0.971962 * imageHeight),
        [
          const Color.fromRGBO(249, 249, 249, 1),
          const Color.fromRGBO(200, 195, 191, 1),
          colorFromHex('#ffffff'),
          const Color.fromRGBO(29, 29, 29, 1),
          const Color.fromRGBO(200, 194, 192, 1),
          const Color.fromRGBO(209, 209, 209, 1),
        ],
        [0, 0.23, 0.36, 0.59, 0.76, 1],
      );
      fillPaint.shader = grad;
      canvas.drawPath(path, fillPaint);

      path = Path();
      rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: (0.869158 * imageWidth), height: (0.869158 * imageWidth));
      path.addArc(rect, 0, TWO_PI);
      path.close();
      fillPaint.shader = null;
      fillPaint.color = colorFromHex('#f6f6f6');
      canvas.drawPath(path, fillPaint);

      path = Path();
      rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: (0.85 * imageWidth), height: (0.85 * imageWidth));
      path.addArc(rect, 0, TWO_PI);
      path.close();
      fillPaint.shader = null;
      fillPaint.color = colorFromHex('#333333');
      canvas.drawPath(path, fillPaint);
      break;

    case FrameDesignEnum.BLACK_METAL:
      //     fractions = [0, 0.125, 0.347222, 0.5, 0.680555, 0.875, 1]

      //     colors = [
      //       const Color.fromRGBO(254, 254, 254, 1),
      //       const Color.fromRGBO(0, 0, 0, 1),
      //       const Color.fromRGBO(153, 153, 153, 1),
      //       const Color.fromRGBO(0, 0, 0, 1),
      //       const Color.fromRGBO(153, 153, 153, 1),
      //       const Color.fromRGBO(0, 0, 0, 1),
      //       const Color.fromRGBO(254, 254, 254, 1)
      //     ]

      //     radFCtx.save()
      //     radFCtx.arc(
      //       centerX,
      //       centerY,
      //       (imageWidth * 0.990654) / 2,
      //       0,
      //       TWO_PI,
      //       true
      //     )
      //     radFCtx.clip()
      //     outerX = imageWidth * 0.495327
      //     innerX = imageWidth * 0.42056
      //     grad = new ConicalGradient(fractions, colors)
      //     grad.fillCircle(radFCtx, centerX, centerY, innerX, outerX)
      //     // fade outer edge
      //     radFCtx.strokeStyle = '#848484'
      //     radFCtx.strokeStyle = 'rgba(132, 132, 132, 0.8)'
      //     radFCtx.beginPath()
      //     radFCtx.lineWidth = imageWidth / 90
      //     radFCtx.arc(centerX, centerY, imageWidth / 2, 0, TWO_PI, true)
      //     radFCtx.closePath()
      //     radFCtx.stroke()
      //     radFCtx.restore()
      break;

    case FrameDesignEnum.SHINY_METAL:
      //     fractions = [0, 0.125, 0.25, 0.347222, 0.5, 0.652777, 0.75, 0.875, 1]

      //     colors = [
      //       const Color.fromRGBO(254, 254, 254, 1),
      //       const Color.fromRGBO(210, 210, 210, 1),
      //       const Color.fromRGBO(179, 179, 179, 1),
      //       const Color.fromRGBO(238, 238, 238, 1),
      //       const Color.fromRGBO(160, 160, 160, 1),
      //       const Color.fromRGBO(238, 238, 238, 1),
      //       const Color.fromRGBO(179, 179, 179, 1),
      //       const Color.fromRGBO(210, 210, 210, 1),
      //       const Color.fromRGBO(254, 254, 254, 1)
      //     ]

      //     radFCtx.save()
      //     radFCtx.arc(
      //       centerX,
      //       centerY,
      //       (imageWidth * 0.990654) / 2,
      //       0,
      //       TWO_PI,
      //       true
      //     )
      //     radFCtx.clip()
      //     outerX = imageWidth * 0.495327
      //     innerX = imageWidth * 0.42056
      //     grad = new ConicalGradient(fractions, colors)
      //     grad.fillCircle(radFCtx, centerX, centerY, innerX, outerX)
      //     // fade outer edge
      //     radFCtx.strokeStyle = '#848484'
      //     radFCtx.strokeStyle = 'rgba(132, 132, 132, 0.8)'
      //     radFCtx.beginPath()
      //     radFCtx.lineWidth = imageWidth / 90
      //     radFCtx.arc(centerX, centerY, imageWidth / 2, 0, TWO_PI, true)
      //     radFCtx.closePath()
      //     radFCtx.stroke()
      //     radFCtx.restore()
      break;

    case FrameDesignEnum.CHROME:
      //     fractions = [
      //       0,
      //       0.09,
      //       0.12,
      //       0.16,
      //       0.25,
      //       0.29,
      //       0.33,
      //       0.38,
      //       0.48,
      //       0.52,
      //       0.63,
      //       0.68,
      //       0.8,
      //       0.83,
      //       0.87,
      //       0.97,
      //       1
      //     ]

      //     colors = [
      //       const Color.fromRGBO(255, 255, 255, 1),
      //       const Color.fromRGBO(255, 255, 255, 1),
      //       const Color.fromRGBO(136, 136, 138, 1),
      //       const Color.fromRGBO(164, 185, 190, 1),
      //       const Color.fromRGBO(158, 179, 182, 1),
      //       const Color.fromRGBO(112, 112, 112, 1),
      //       const Color.fromRGBO(221, 227, 227, 1),
      //       const Color.fromRGBO(155, 176, 179, 1),
      //       const Color.fromRGBO(156, 176, 177, 1),
      //       const Color.fromRGBO(254, 255, 255, 1),
      //       const Color.fromRGBO(255, 255, 255, 1),
      //       const Color.fromRGBO(156, 180, 180, 1),
      //       const Color.fromRGBO(198, 209, 211, 1),
      //       const Color.fromRGBO(246, 248, 247, 1),
      //       const Color.fromRGBO(204, 216, 216, 1),
      //       const Color.fromRGBO(164, 188, 190, 1),
      //       const Color.fromRGBO(255, 255, 255, 1)
      //     ]

      //     radFCtx.save()
      //     radFCtx.arc(
      //       centerX,
      //       centerY,
      //       (imageWidth * 0.990654) / 2,
      //       0,
      //       TWO_PI,
      //       true
      //     )
      //     radFCtx.clip()
      //     outerX = imageWidth * 0.495327
      //     innerX = imageWidth * 0.42056
      //     grad = new ConicalGradient(fractions, colors)
      //     grad.fillCircle(radFCtx, centerX, centerY, innerX, outerX)
      //     // fade outer edge
      //     radFCtx.strokeStyle = '#848484'
      //     radFCtx.strokeStyle = 'rgba(132, 132, 132, 0.8)'
      //     radFCtx.beginPath()
      //     radFCtx.lineWidth = imageWidth / 90
      //     radFCtx.arc(centerX, centerY, imageWidth / 2, 0, TWO_PI, true)
      //     radFCtx.closePath()
      //     radFCtx.stroke()
      //     radFCtx.restore()

      break;
  }

  // inner bright frame
  Paint paint = Paint()
    ..color = const Color.fromRGBO(191, 191, 191, 1)
    ..style = ui.PaintingStyle.fill;
  path = Path();
  rect = Rect.fromCenter(center: Offset(centerX, centerY), width: (imageWidth * 0.841121), height: (imageWidth * 0.841121));
  path.addArc(rect, 0, TWO_PI);
  canvas.drawPath(path, paint);

  // clip out center so it is transparent if the background is not visible
  paint.blendMode = BlendMode.dstOut;
  // Background ellipse
  path = Path();
  rect = Rect.fromCenter(center: Offset(centerX, centerY), width: (imageWidth * 0.83), height: (imageWidth * 0.83));
  path.addArc(rect, 0, TWO_PI);
  canvas.drawPath(path, paint);

  var pic = pictureRecorder.endRecording();
  //drawFrameCache[cacheKey] = pic;
  return pic;
//  }
  //return drawFrameCache[cacheKey]!;
}
