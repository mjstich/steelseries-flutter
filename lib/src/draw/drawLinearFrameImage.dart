// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> linearFrameImageCache = {};

ui.Picture drawLinearFrameImage(FrameDesignEnum frameDesign, double imageWidth, double imageHeight, bool vertical) {
  double frameWidth;
  double OUTER_FRAME_CORNER_RADIUS;
  double FRAME_MAIN_CORNER_RADIUS;
  double SUBTRACT_CORNER_RADIUS;
  //String cacheKey = imageWidth.toString() + imageHeight.toString() + frameDesign.toString() + vertical.toString();

  // check if we have already created and cached this buffer, if not create it
  //if (!linearFrameImageCache.containsKey(cacheKey)) {
  frameWidth = math.sqrt(imageWidth * imageWidth + imageHeight * imageHeight) * 0.04;
  frameWidth = math.min(frameWidth, (vertical ? imageWidth : imageHeight) * 0.1).ceilToDouble();

  // Setup buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);

  // Calculate corner radii
  if (vertical) {
    OUTER_FRAME_CORNER_RADIUS = (imageWidth * 0.05).ceilToDouble();
    FRAME_MAIN_CORNER_RADIUS = OUTER_FRAME_CORNER_RADIUS - 1;
    SUBTRACT_CORNER_RADIUS = (imageWidth * 0.028571).floorToDouble();
  } else {
    OUTER_FRAME_CORNER_RADIUS = (imageHeight * 0.05).ceilToDouble();
    FRAME_MAIN_CORNER_RADIUS = OUTER_FRAME_CORNER_RADIUS - 1;
    SUBTRACT_CORNER_RADIUS = (imageHeight * 0.028571).floorToDouble();
  }

  Paint paint = Paint()
    ..color = colorFromHex('#838383')
    ..style = ui.PaintingStyle.fill;
  Path path = roundedRectangle(
    0,
    0,
    imageWidth,
    imageHeight,
    OUTER_FRAME_CORNER_RADIUS,
  );
  canvas.drawPath(path, paint);

  path = roundedRectangle(
    1,
    1,
    imageWidth - 2,
    imageHeight - 2,
    FRAME_MAIN_CORNER_RADIUS,
  );

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
      paint.shader = grad;
      canvas.drawPath(path, paint);
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
      paint.shader = grad;
      canvas.drawPath(path, paint);
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
      paint.shader = grad;
      canvas.drawPath(path, paint);
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
      paint.shader = grad;
      canvas.drawPath(path, paint);
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
      paint.shader = grad;
      canvas.drawPath(path, paint);
      break;

    case FrameDesignEnum.TILTED_GRAY:
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.233644 * imageWidth, 0.084112 * imageHeight),
        Offset(0.81258 * imageWidth, 0.910919 * imageHeight),
        [
          const Color.fromRGBO(118, 117, 135, 1),
          const Color.fromRGBO(74, 74, 82, 1),
          const Color.fromRGBO(50, 50, 54, 1),
          const Color.fromRGBO(79, 79, 87, 1),
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
      paint.shader = grad;
      canvas.drawPath(path, paint);
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
      paint.shader = grad;
      canvas.drawPath(path, paint);
      break;

    case FrameDesignEnum.GLOSSY_METAL:
      Path clipPath = roundedRectangle(
        1,
        1,
        imageWidth - 2,
        imageHeight - 2,
        OUTER_FRAME_CORNER_RADIUS,
      );
      canvas.clipPath(clipPath);

      // The fractions from the Java version of linear gauge
      /*
                    grad.addColorStop(0, 'rgb(249, 249, 249)');
                    grad.addColorStop(0.1, 'rgb(200, 195, 191)');
                    grad.addColorStop(0.26, '#ffffff');
                    grad.addColorStop(0.73, 'rgb(29, 29, 29)');
                    grad.addColorStop(1, 'rgb(209, 209, 209)');
        */
      // Modified fractions from the radial gauge - looks better imho
      ui.Gradient grad = ui.Gradient.linear(
        const Offset(0, 1),
        Offset(0, imageHeight - 2),
        [
          const Color.fromRGBO(249, 249, 249, 1),
          const Color.fromRGBO(200, 195, 191, 1),
          colorFromHex('#ffffff'),
          const Color.fromRGBO(29, 29, 29, 1),
          const Color.fromRGBO(200, 194, 192, 1),
          const Color.fromRGBO(209, 209, 209, 1),
        ],
        [0, 0.2, 0.3, 0.6, 0.8, 1],
      );
      paint.shader = grad;
      canvas.drawPath(path, paint);

      // Inner frame bright
      clipPath = roundedRectangle(
        frameWidth - 2,
        frameWidth - 2,
        imageWidth - (frameWidth - 2) * 2,
        imageHeight - (frameWidth - 2) * 2,
        SUBTRACT_CORNER_RADIUS,
      );
      canvas.clipPath(clipPath);
      Paint fillPaint = Paint()
        ..color = colorFromHex('#f6f6f6')
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);

      // Inner frame dark
      clipPath = roundedRectangle(
        frameWidth - 1,
        frameWidth - 1,
        imageWidth - (frameWidth - 1) * 2,
        imageHeight - (frameWidth - 1) * 2,
        SUBTRACT_CORNER_RADIUS,
      );
      canvas.clipPath(clipPath);
      paint = Paint()
        ..color = colorFromHex('#333333')
        ..style = ui.PaintingStyle.fill;
      //                linFCtx.fill();
      break;

    case FrameDesignEnum.BLACK_METAL:
      // List<double> fractions = [0, 0.125, 0.347222, 0.5, 0.680555, 0.875, 1];

      // List<Color> colors = [
      //   colorFromHex('#FFFFFF'),
      //   colorFromHex('#000000'),
      //   colorFromHex('#999999'),
      //   colorFromHex('#000000'),
      //   colorFromHex('#999999'),
      //   colorFromHex('#000000'),
      //   colorFromHex('#FFFFFF'),
      // ];
      // // Set the clip
      // Path clipPath = roundedRectangle(
      //   1,
      //   1,
      //   imageWidth - 2,
      //   imageHeight - 2,
      //   OUTER_FRAME_CORNER_RADIUS,
      // );
      // canvas.clipPath(clipPath);
      // grad = new ConicalGradient(fractions, colors)
      // grad.fillRect(
      //   linFCtx,
      //   imageWidth / 2,
      //   imageHeight / 2,
      //   imageWidth,
      //   imageHeight,
      //   frameWidth,
      //   frameWidth
      // )
      break;

    case FrameDesignEnum.SHINY_METAL:
      // List<double> fractions = [0, 0.125, 0.25, 0.347222, 0.5, 0.652777, 0.75, 0.875, 1];

      // List<Color> colors = [
      //   colorFromHex('#FFFFFF'),
      //   colorFromHex('#D2D2D2'),
      //   colorFromHex('#B3B3B3'),
      //   colorFromHex('#EEEEEE'),
      //   colorFromHex('#A0A0A0'),
      //   colorFromHex('#EEEEEE'),
      //   colorFromHex('#B3B3B3'),
      //   colorFromHex('#D2D2D2'),
      //   colorFromHex('#FFFFFF'),
      // ];
      // // Set the clip
      // Path clipPath = roundedRectangle(
      //   1,
      //   1,
      //   imageWidth - 2,
      //   imageHeight - 2,
      //   OUTER_FRAME_CORNER_RADIUS,
      // );
      // canvas.clipPath(clipPath);
      // grad = new ConicalGradient(fractions, colors)
      // grad.fillRect(
      //   linFCtx,
      //   imageWidth / 2,
      //   imageHeight / 2,
      //   imageWidth,
      //   imageHeight,
      //   frameWidth,
      //   frameWidth
      // )
      break;

    case FrameDesignEnum.CHROME:
      // List<double> fractions = [
      //   0,
      //   0.09,
      //   0.12,
      //   0.16,
      //   0.25,
      //   0.29,
      //   0.33,
      //   0.38,
      //   0.48,
      //   0.52,
      //   0.63,
      //   0.68,
      //   0.8,
      //   0.83,
      //   0.87,
      //   0.97,
      //   1,
      // ];

      // List<Color> colors = [
      //   colorFromHex('#FFFFFF'),
      //   colorFromHex('#FFFFFF'),
      //   colorFromHex('#888890'),
      //   colorFromHex('#A4B9BE'),
      //   colorFromHex('#9EB3B6'),
      //   colorFromHex('#707070'),
      //   colorFromHex('#DDE3E3'),
      //   colorFromHex('#9BB0B3'),
      //   colorFromHex('#9CB0B1'),
      //   colorFromHex('#FEFFFF'),
      //   colorFromHex('#FFFFFF'),
      //   colorFromHex('#9CB4B4'),
      //   colorFromHex('#C6D1D3'),
      //   colorFromHex('#F6F8F7'),
      //   colorFromHex('#CCD8D8'),
      //   colorFromHex('#A4BCBE'),
      //   colorFromHex('#FFFFFF'),
      // ];
      // // Set the clip
      // Path clipPath = roundedRectangle(
      //   1,
      //   1,
      //   imageWidth - 2,
      //   imageHeight - 2,
      //   OUTER_FRAME_CORNER_RADIUS,
      // );
      // canvas.clipPath(clipPath);
      // grad = new ConicalGradient(fractions, colors)
      // grad.fillRect(
      //   linFCtx,
      //   imageWidth / 2,
      //   imageHeight / 2,
      //   imageWidth,
      //   imageHeight,
      //   frameWidth,
      //   frameWidth
      // )
      break;
  }

  path = roundedRectangle(
    frameWidth,
    frameWidth,
    imageWidth - frameWidth * 2,
    imageHeight - frameWidth * 2,
    SUBTRACT_CORNER_RADIUS,
  );
  paint.color = const Color.fromRGBO(192, 192, 192, 1);
  paint.blendMode = ui.BlendMode.dstOut;

  // clip out the center of the frame for transparent backgrounds

  path = roundedRectangle(
    frameWidth,
    frameWidth,
    imageWidth - frameWidth * 2,
    imageHeight - frameWidth * 2,
    SUBTRACT_CORNER_RADIUS,
  );
  canvas.drawPath(path, paint);

  // cache the buffer
  var pic = pictureRecorder.endRecording();
  return pic;
  //   linearFrameImageCache[cacheKey] = pic;
  // }
  // return linearFrameImageCache[cacheKey]!;
}
