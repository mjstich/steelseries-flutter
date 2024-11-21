// import carbonBuffer from './carbonBuffer.js'
// import punchedSheetBuffer from './punchedSheetBuffer.js'
// import brushedMetalTexture from './brushedMetalTexture.js'

// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'carbonBuffer.dart';
import 'definitions.dart';
import 'punchedSheetBuffer.dart';
import 'tools.dart';

Map<String, ui.Picture> backgroundCache = {};

ui.Picture drawBackground(BackgroundColorEnum backgroundColor, double centerX, double centerY, double imageWidth, double imageHeight) {
  double backgroundOffsetX = (imageWidth * 0.831775) / 2;
  //String cacheKey = imageWidth.toString() + imageHeight.toString() + backgroundColor.name;

  // check if we have already created and cached this buffer, if not create it
  //if (!backgroundCache.containsKey(cacheKey)) {
  // Setup buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);

  // Background ellipse
  Path path = Path();
  Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: (imageWidth * 0.831775), height: (imageWidth * 0.831775));
  path.addArc(rect, 0, TWO_PI);
  path.close();

  // If the backgroundColor is a texture fill it with the texture instead of the gradient
  if (backgroundColor == BackgroundColorEnum.CARBON || backgroundColor == BackgroundColorEnum.PUNCHED_SHEET || backgroundColor == BackgroundColorEnum.BRUSHED_METAL || backgroundColor == BackgroundColorEnum.BRUSHED_STAINLESS) {
    if (backgroundColor == BackgroundColorEnum.CARBON) {
      var carbonImage = carbonBuffer();
      if (carbonImage != null) {
        canvas.save();
        Path path = Path();
        Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: backgroundOffsetX * 2, height: backgroundOffsetX * 2);
        path.addArc(rect, 0, TWO_PI);
        path.close();
        canvas.clipPath(path);
        paintImage(canvas: canvas, rect: Rect.fromLTWH(0, 0, imageWidth, imageHeight), image: carbonImage, repeat: ImageRepeat.repeat);
        canvas.restore();
      }
    }

    if (backgroundColor == BackgroundColorEnum.PUNCHED_SHEET) {
      var punchedSheetImage = punchedSheetBuffer();
      if (punchedSheetImage != null) {
        canvas.save();
        Path path = Path();
        Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: backgroundOffsetX * 2, height: backgroundOffsetX * 2);
        path.addArc(rect, 0, TWO_PI);
        path.close();
        canvas.clipPath(path);
        paintImage(canvas: canvas, rect: Rect.fromLTWH(0, 0, imageWidth, imageHeight), image: punchedSheetImage, repeat: ImageRepeat.repeat);
        canvas.restore();
      }
    }

    // Add another inner shadow to make the look more realistic
    ui.Gradient grad = ui.Gradient.linear(
      Offset(backgroundOffsetX, 0),
      Offset(imageWidth - backgroundOffsetX, 0),
      [
        const Color.fromRGBO(0, 0, 0, 0.25),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0.25),
      ],
      [0, 0.5, 1],
    );
    Paint paint = Paint()
      ..shader = grad
      ..style = ui.PaintingStyle.fill;
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: (imageWidth * 0.831775), height: (imageWidth * 0.831775));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.drawPath(path, paint);

    if (backgroundColor == BackgroundColorEnum.BRUSHED_METAL || backgroundColor == BackgroundColorEnum.BRUSHED_STAINLESS) {
      bool mono = backgroundColor == BackgroundColorEnum.BRUSHED_METAL;
      // textureColor = parseInt(
      //   backgroundColor.gradientStop.getHexColor().substr(-6),
      //   16
      // )
      // texture = brushedMetalTexture(textureColor, 5, 0.1, mono, 0.5)
      // radBCtx.fillStyle = radBCtx.createPattern(
      //   texture.fill(0, 0, imageWidth, imageHeight),
      //   'no-repeat'
      // )
      // radBCtx.fill()
    }
  } else if (backgroundColor == BackgroundColorEnum.STAINLESS || backgroundColor == BackgroundColorEnum.TURNED) {
    // Define the fractions of the conical gradient paint
    List<double> fractions = [
      0,
      0.03,
      0.1,
      0.14,
      0.24,
      0.33,
      0.38,
      0.5,
      0.62,
      0.67,
      0.76,
      0.81,
      0.85,
      0.97,
      1,
    ];

    // Define the colors of the conical gradient paint
    List<Color> colors = [
      colorFromHex('#FDFDFD'),
      colorFromHex('#FDFDFD'),
      colorFromHex('#B2B2B4'),
      colorFromHex('#ACACAE'),
      colorFromHex('#FDFDFD'),
      colorFromHex('#8E8E8E'),
      colorFromHex('#8E8E8E'),
      colorFromHex('#FDFDFD'),
      colorFromHex('#8E8E8E'),
      colorFromHex('#8E8E8E'),
      colorFromHex('#FDFDFD'),
      colorFromHex('#ACACAE'),
      colorFromHex('#B2B2B4'),
      colorFromHex('#FDFDFD'),
      colorFromHex('#FDFDFD'),
    ];

    // grad = new ConicalGradient(fractions, colors)
    // grad.fillCircle(radBCtx, centerX, centerY, 0, backgroundOffsetX)

    if (backgroundColor == BackgroundColorEnum.TURNED) {
      // Define the turning radius
      double radius = backgroundOffsetX;
      double turnRadius = radius * 0.55;
      // Step size proporational to radius
      double stepSize = RAD_FACTOR * (500 / radius);
      // Save before we start
      canvas.save();
      // restrict the turnings to the desired area
      Path path = Path();
      Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: radius * 2, height: radius * 2);
      path.addArc(rect, 0, TWO_PI);
      path.close();
      canvas.clipPath(path);
      // set the style for the turnings
      double lineWidth = 0.5;
      double end = TWO_PI - stepSize * 0.3;
      // Step the engine round'n'round
      for (double i = 0; i < end; i += stepSize) {
        // draw a 'turn'
        Path path = Path();
        Rect rect = Rect.fromCenter(center: Offset(centerX + turnRadius, centerY), width: turnRadius * 2, height: turnRadius * 2);
        path.addArc(rect, 0, TWO_PI);
        canvas.drawPath(
            path,
            Paint()
              ..color = const Color.fromRGBO(240, 240, 255, 0.25)
              ..strokeWidth = lineWidth
              ..style = ui.PaintingStyle.stroke);

        // rotate the 'piece' a fraction to draw 'shadow'
        canvas.translate(centerX, centerY);
        canvas.rotate(stepSize * 0.3);
        canvas.translate(-centerX, -centerY);
        // draw a 'turn'
        path = Path();
        rect = Rect.fromCenter(center: Offset(centerX + turnRadius, centerY), width: turnRadius * 2, height: turnRadius * 2);
        path.addArc(rect, 0, TWO_PI);
        canvas.drawPath(
            path,
            Paint()
              ..color = const Color.fromRGBO(25, 10, 10, 0.1)
              ..strokeWidth = lineWidth
              ..style = ui.PaintingStyle.stroke);

        // now rotate on to the next 'scribe' position minus the 'fraction'
        canvas.translate(centerX, centerY);
        canvas.rotate(stepSize - stepSize * 0.3);
        canvas.translate(-centerX, -centerY);
      }
      // Restore canvas now we are done
      canvas.restore();
    }
  } else {
    ui.Gradient grad = ui.Gradient.linear(
      Offset(0, imageWidth * 0.084112),
      Offset(0, backgroundOffsetX * 2),
      [
        backgroundColor.gradientStart,
        backgroundColor.gradientFraction,
        backgroundColor.gradientStop,
      ],
      [0, 0.4, 1],
    );
    Paint paint = Paint()
      ..shader = grad
      ..style = ui.PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }
  // Inner shadow
  ui.Gradient grad = ui.Gradient.radial(
    Offset(centerX, centerY),
    0,
    [
      const Color.fromRGBO(0, 0, 0, 0),
      const Color.fromRGBO(0, 0, 0, 0),
      const Color.fromRGBO(0, 0, 0, 0),
      const Color.fromRGBO(0, 0, 0, 0.03),
      const Color.fromRGBO(0, 0, 0, 0.07),
      const Color.fromRGBO(0, 0, 0, 0.15),
      const Color.fromRGBO(0, 0, 0, 0.3),
    ],
    <double>[0.0, 0.7, 0.71, 0.86, 0.92, 0.97, 1],
    TileMode.clamp,
    null,
    Offset(centerX, centerY),
    backgroundOffsetX,
  );
  Paint paint = Paint()
    ..shader = grad
    ..style = ui.PaintingStyle.fill;
  path = Path();
  rect = Rect.fromCenter(center: Offset(centerX, centerY), width: backgroundOffsetX * 2, height: backgroundOffsetX * 2);
  path.addArc(rect, 0, TWO_PI);
  path.close();
  canvas.drawPath(path, paint);

  // cache the buffer
  var pic = pictureRecorder.endRecording();
  return pic;
  //backgroundCache[cacheKey] = pic;
  // }
  // return backgroundCache[cacheKey]!;
}
