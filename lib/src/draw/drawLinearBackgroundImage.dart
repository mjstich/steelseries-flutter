//import carbonBuffer from './carbonBuffer.js'
//import punchedSheetBuffer from './punchedSheetBuffer.js'
//import brushedMetalTexture from './brushedMetalTexture.js'

// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'carbonBuffer.dart';
import 'definitions.dart';
import 'punchedSheetBuffer.dart';
import 'tools.dart';

Map<String, ui.Picture> linearBackgroundImageCache = {};

ui.Picture drawLinearBackgroundImage(BackgroundColorEnum backgroundColor,
    double imageWidth, double imageHeight, bool vertical) {
  //String cacheKey = imageWidth.toString() + imageHeight.toString() + vertical.toString() + backgroundColor.name;

  // check if we have already created and cached this buffer, if not create it
  //if (!linearBackgroundImageCache.containsKey(cacheKey)) {
  double frameWidth =
      math.sqrt(imageWidth * imageWidth + imageHeight * imageHeight) * 0.04;
  frameWidth = math
          .min(frameWidth, (vertical ? imageWidth : imageHeight) * 0.1)
          .ceilToDouble() -
      1;

  double CORNER_RADIUS =
      ((vertical ? imageWidth : imageHeight) * 0.028571).floorToDouble();
  // Setup buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);
  Paint strokePaint = Paint()
    ..strokeWidth = 0
    ..style = ui.PaintingStyle.stroke;
  Paint fillPaint = Paint()..style = ui.PaintingStyle.fill;

  Path path = roundedRectangle(
    frameWidth,
    frameWidth,
    imageWidth - frameWidth * 2,
    imageHeight - frameWidth * 2,
    CORNER_RADIUS,
  );

  // If the backgroundColor is a texture fill it with the texture instead of the gradient
  if (backgroundColor == BackgroundColorEnum.CARBON ||
      backgroundColor == BackgroundColorEnum.PUNCHED_SHEET)
  // backgroundColor == BackgroundColorEnum.STAINLESS ||
  // backgroundColor == BackgroundColorEnum.BRUSHED_METAL ||
  // backgroundColor == BackgroundColorEnum.BRUSHED_STAINLESS ||
  // backgroundColor == BackgroundColorEnum.TURNED)
  {
    if (backgroundColor == BackgroundColorEnum.CARBON) {
      var carbonImage = carbonBuffer();
      if (carbonImage != null) {
        canvas.save();
        Path path = Path();
        Rect rect = Rect.fromCenter(
            center: Offset(imageWidth / 2, imageHeight / 2),
            width: imageWidth,
            height: imageHeight);
        path.addArc(rect, 0, TWO_PI);
        path.close();
        canvas.clipPath(path);
        paintImage(
            canvas: canvas,
            rect: Rect.fromLTWH(0, 0, imageWidth, imageHeight),
            image: carbonImage,
            repeat: ImageRepeat.repeat);
        canvas.restore();
      }
    }

    if (backgroundColor == BackgroundColorEnum.PUNCHED_SHEET) {
      var punchedSheetImage = punchedSheetBuffer();
      if (punchedSheetImage != null) {
        canvas.save();
        Path path = Path();
        Rect rect = Rect.fromCenter(
            center: Offset(imageWidth / 2, imageHeight / 2),
            width: imageWidth,
            height: imageHeight);
        path.addArc(rect, 0, TWO_PI);
        path.close();
        canvas.clipPath(path);
        paintImage(
            canvas: canvas,
            rect: Rect.fromLTWH(0, 0, imageWidth, imageHeight),
            image: punchedSheetImage,
            repeat: ImageRepeat.repeat);
        canvas.restore();
      }
    }

    // if (backgroundColor == BackgroundColorEnum.STAINLESS || backgroundColor == BackgroundColorEnum.TURNED) {
    //   // Define the fraction of the conical gradient paint
    //   List<double> fractions = [0, 0.03, 0.1, 0.14, 0.24, 0.33, 0.38, 0.5, 0.62, 0.67, 0.76, 0.81, 0.85, 0.97, 1];

    //   //   // Define the colors of the conical gradient paint
    //   //   List<Color> colors = [
    //   //     colorFromHex('#FDFDFD'),
    //   //     colorFromHex('#FDFDFD'),
    //   //     colorFromHex('#B2B2B4'),
    //   //     colorFromHex('#ACACAE'),
    //   //     colorFromHex('#FDFDFD'),
    //   //     colorFromHex('#8E8E8E'),
    //   //     colorFromHex('#8E8E8E'),
    //   //     colorFromHex('#FDFDFD'),
    //   //     colorFromHex('#8E8E8E'),
    //   //     colorFromHex('#8E8E8E'),
    //   //     colorFromHex('#FDFDFD'),
    //   //     colorFromHex('#ACACAE'),
    //   //     colorFromHex('#B2B2B4'),
    //   //     colorFromHex('#FDFDFD'),
    //   //     colorFromHex('#FDFDFD'),
    //   //   ];
    //   //   grad = new ConicalGradient(fractions, colors)
    //   //   // Set a clip as we will be drawing outside the required area
    //   //   linBCtx.clip()
    //   //   grad.fillRect(
    //   //     linBCtx,
    //   //     imageWidth / 2,
    //   //     imageHeight / 2,
    //   //     imageWidth - frameWidth * 2,
    //   //     imageHeight - frameWidth * 2,
    //   //     imageWidth / 2,
    //   //     imageHeight / 2
    //   //   )
    //   // Add an additional inner shadow to fade out brightness at the top

    //   ui.Gradient grad = ui.Gradient.linear(
    //     Offset(0, frameWidth),
    //     Offset(0, imageHeight - frameWidth * 2),
    //     [
    //       const Color.fromRGBO(0, 0, 0, 0.25),
    //       const Color.fromRGBO(0, 0, 0, 0.05),
    //       const Color.fromRGBO(0, 0, 0, 0),
    //     ],
    //     [0, 0.1, 1],
    //   );

    //   //   linBCtx.fillStyle = grad
    //   //   linBCtx.fill()

    //   if (backgroundColor == BackgroundColorEnum.TURNED) {
    //     // Define the turning radius
    //     double radius = math.sqrt((imageWidth - frameWidth * 2) * (imageWidth - frameWidth * 2) + (imageHeight - frameWidth * 2) * (imageHeight - frameWidth * 2)) / 2;
    //     double turnRadius = radius * 0.55;
    //     double centerX = imageWidth / 2;
    //     double centerY = imageHeight / 2;
    //     // Step size proporational to radius
    //     double stepSize = (TWO_PI / 360) * (400 / radius);

    //     // Save before we start
    //     canvas.save();

    //     // Set a clip as we will be drawing outside the required area
    //     Path path = roundedRectangle(
    //       frameWidth,
    //       frameWidth,
    //       imageWidth - frameWidth * 2,
    //       imageHeight - frameWidth * 2,
    //       CORNER_RADIUS,
    //     );
    //     canvas.clipPath(path);

    //     // set the style for the turnings
    //     double lineWidth = 0.5;
    //     double end = TWO_PI - stepSize * 0.3;
    //     // Step the engine round'n'round
    //     for (double i = 0; i < end; i += stepSize) {
    //       // draw a 'turn'

    //       path = Path();
    //       Rect rect = Rect.fromCenter(center: Offset(centerX + turnRadius, centerY), width: turnRadius * 2, height: turnRadius * 2);
    //       path.addArc(rect, 0, TWO_PI);
    //       canvas.drawPath(
    //           path,
    //           Paint()
    //             ..color = const Color.fromRGBO(240, 240, 255, 0.25)
    //             ..strokeWidth = lineWidth
    //             ..style = ui.PaintingStyle.stroke);
    //       // rotate the 'piece'
    //       canvas.translate(centerX, centerY);
    //       canvas.rotate(stepSize * 0.3);
    //       canvas.translate(-centerX, -centerY);
    //       // draw a 'turn'
    //       path = Path();
    //       rect = Rect.fromCenter(center: Offset(centerX + turnRadius, centerY), width: turnRadius * 2, height: turnRadius * 2);
    //       path.addArc(rect, 0, TWO_PI);
    //       canvas.drawPath(
    //           path,
    //           Paint()
    //             ..color = const Color.fromRGBO(25, 10, 10, 0.1)
    //             ..strokeWidth = lineWidth
    //             ..style = ui.PaintingStyle.stroke);
    //       canvas.translate(centerX, centerY);
    //       canvas.rotate(-stepSize * 0.3);
    //       canvas.translate(-centerX, -centerY);

    //       // rotate the 'piece'
    //       canvas.translate(centerX, centerY);
    //       canvas.rotate(stepSize);
    //       canvas.translate(-centerX, -centerY);
    //     }
    //     // Restore canvas now we are done
    //     canvas.restore();
    //   }
    // }

    ui.Gradient grad = ui.Gradient.linear(
      Offset(frameWidth, frameWidth),
      Offset(imageWidth - frameWidth * 2, imageHeight - frameWidth * 2),
      [
        const Color.fromRGBO(0, 0, 0, 0.25),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0.25),
      ],
      [0, 0.5, 1],
    );

    // Add an additional inner shadow to make the look more realistic
    Path path = roundedRectangle(
      frameWidth,
      frameWidth,
      imageWidth - frameWidth * 2,
      imageHeight - frameWidth * 2,
      CORNER_RADIUS,
    );
    canvas.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // if (
    //   backgroundColor.name === 'BRUSHED_METAL' ||
    //   backgroundColor.name === 'BRUSHED_STAINLESS'
    // ) {
    //   mono = backgroundColor.name === 'BRUSHED_METAL'
    //   textureColor = parseInt(
    //     backgroundColor.gradientStop.getHexColor().substr(-6),
    //     16
    //   )
    //   texture = brushedMetalTexture(textureColor, 5, 0.1, mono, 0.5)
    //   linBCtx.fillStyle = linBCtx.createPattern(
    //     texture.fill(0, 0, imageWidth, imageHeight),
    //     'no-repeat'
    //   )
    //   linBCtx.fill()
    //}
  } else {
    ui.Gradient grad = ui.Gradient.linear(
      Offset(0, frameWidth),
      Offset(0, imageHeight - frameWidth * 2),
      [
        backgroundColor.gradientStart,
        backgroundColor.gradientFraction,
        backgroundColor.gradientStop,
      ],
      [0, 0.4, 1],
    );
    fillPaint.shader = grad;
    canvas.drawPath(path, fillPaint);
  }
  // Add a simple inner shadow
  List<Color> colors = [
    const Color.fromRGBO(0, 0, 0, 0.30),
    const Color.fromRGBO(0, 0, 0, 0.20),
    const Color.fromRGBO(0, 0, 0, 0.13),
    const Color.fromRGBO(0, 0, 0, 0.09),
    const Color.fromRGBO(0, 0, 0, 0.06),
    const Color.fromRGBO(0, 0, 0, 0.04),
    const Color.fromRGBO(0, 0, 0, 0.03),
  ];
  for (int i = 0; i < 7; i++) {
    strokePaint.color = colors[i];
    Path path = roundedRectangle(
      frameWidth + i,
      frameWidth + i,
      imageWidth - frameWidth * 2 - 2 * i,
      imageHeight - frameWidth * 2 - 2 * i,
      CORNER_RADIUS,
    );
    canvas.drawPath(path, strokePaint);
  }
  // cache the buffer
  var pic = pictureRecorder.endRecording();
  return pic;
  //   linearBackgroundImageCache[cacheKey] = pic;
  // }
  // return linearBackgroundImageCache[cacheKey]!;
}
