// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'tools.dart';

void drawLevel(Canvas canvas, Size canvasSize, Parameters parameters) {
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  bool decimalsVisible = parameters.decimalsVisibleWithDefault(false);
  bool textOrientationFixed = parameters.textOrientationFixedWithDefault(false);
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(BackgroundColorEnum.DARK_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(ColorEnum.RED);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  bool rotateFace = parameters.rotateFaceWithDefault(false);

  double value = parameters.value ?? 0;
  double stepValue = 0;
  double visibleValue = value;
  double angleStep = TWO_PI / 360;
  double angle;
  int decimals = decimalsVisible ? 1 : 0;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  // **************   Buffer creation  ********************
  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // Buffer for pointer image painting code
  var pointerContextRecorder = ui.PictureRecorder();
  var pointerContext = Canvas(pointerContextRecorder);

  // // Buffer for step pointer image painting code
  var stepPointerContextRecorder = ui.PictureRecorder();
  var stepPointerContext = Canvas(stepPointerContextRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  // **************   Image creation  ********************
  void drawTickmarksImage(Canvas ctx) {
    double stdFontSize;
    double smlFontSize;

    ctx.save();
    ctx.translate(centerX, centerY);

    for (int i = 0; i < 360; i++) {
      Path path = Path();
      path.moveTo(imageWidth * 0.38, 0);
      path.lineTo(imageWidth * 0.37, 0);
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..color = backgroundColor.labelColor
            ..strokeWidth = 0.5
            ..style = ui.PaintingStyle.stroke);

      if (i % 5 == 0) {
        Path path = Path();
        path.moveTo(imageWidth * 0.38, 0);
        path.lineTo(imageWidth * 0.36, 0);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = 1
              ..style = ui.PaintingStyle.stroke);
      }

      if (i % 45 == 0) {
        Path path = Path();
        path.moveTo(imageWidth * 0.38, 0);
        path.lineTo(imageWidth * 0.34, 0);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = 1
              ..style = ui.PaintingStyle.stroke);
      }

      stdFontSize = 0;
      smlFontSize = 0;

      // Draw the labels
      if (imageWidth > 300) {
        stdFontSize = 22;
        smlFontSize = 18;
      }
      if (imageWidth <= 300) {
        stdFontSize = 12;
        smlFontSize = 10;
      }
      if (imageWidth <= 200) {
        stdFontSize = 10;
        smlFontSize = 8;
      }
      if (imageWidth <= 100) {
        stdFontSize = 8;
        smlFontSize = 6;
      }
      ctx.save();
      TextStyle stdFont = getFont(stdFontSize, backgroundColor.labelColor);
      TextStyle smlFont = getFont(smlFontSize, backgroundColor.labelColor);

      switch (i) {
        case 0:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR + HALF_PI);

          var textSpan = TextSpan(
            text: '0\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));

          ctx.rotate(-(i * RAD_FACTOR) + HALF_PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.41, 0);
          ctx.rotate(i * RAD_FACTOR - HALF_PI);

          textSpan = TextSpan(
            text: '0%',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;
        case 45:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR + 0.25 * PI);

          var textSpan = TextSpan(
            text: '45\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));

          ctx.rotate(-(i * RAD_FACTOR) + 0.25 * PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.31, imageWidth * 0.085);
          ctx.rotate(i * RAD_FACTOR - 0.25 * PI);

          textSpan = TextSpan(
            text: '100%',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;

        case 90:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR);
          var textSpan = TextSpan(
            text: '90\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));

          ctx.rotate(-(i * RAD_FACTOR));
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.21, 0);
          ctx.rotate(i * RAD_FACTOR);

          textSpan = TextSpan(
            text: '\u221E',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;

        case 135:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR - 0.25 * PI);
          var textSpan = TextSpan(
            text: '45\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          ctx.rotate(-(i * RAD_FACTOR) - 0.25 * PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.31, -imageWidth * 0.085);
          ctx.rotate(i * RAD_FACTOR + 0.25 * PI);
          textSpan = TextSpan(
            text: '100%',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;
        case 180:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR - HALF_PI);
          var textSpan = TextSpan(
            text: '0\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));

          ctx.rotate(-(i * RAD_FACTOR) - HALF_PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.41, 0);
          ctx.rotate(i * RAD_FACTOR + HALF_PI);
          textSpan = TextSpan(
            text: '0%',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          ctx.translate(-imageWidth * 0.41, 0);
          break;
        case 225:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR - 0.75 * PI);

          var textSpan = TextSpan(
            text: '45\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          ctx.rotate(-(i * RAD_FACTOR) - 0.75 * PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.31, imageWidth * 0.085);
          ctx.rotate(i * RAD_FACTOR + 0.75 * PI);
          textSpan = TextSpan(
            text: '100%',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;

        case 270:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR - PI);
          var textSpan = TextSpan(
            text: '90\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));

          ctx.rotate(-(i * RAD_FACTOR) - PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.21, 0);
          ctx.rotate(i * RAD_FACTOR - PI);
          textSpan = TextSpan(
            text: '\u221E',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;

        case 315:
          ctx.translate(imageWidth * 0.31, 0);
          ctx.rotate(i * RAD_FACTOR - 1.25 * PI);

          var textSpan = TextSpan(
            text: '45\u00B0',
            style: stdFont,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          ctx.rotate(-(i * RAD_FACTOR) - 1.25 * PI);
          ctx.translate(-imageWidth * 0.31, 0);

          ctx.translate(imageWidth * 0.31, -imageWidth * 0.085);
          ctx.rotate(i * RAD_FACTOR + 1.25 * PI);

          textSpan = TextSpan(
            text: '100%',
            style: smlFont,
          );
          textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imageWidth,
          );
          textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 2));
          break;
      }
      ctx.restore();
      ctx.rotate(angleStep);
    }
    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  void drawMarkerImage(Canvas ctx) {
    ctx.save();

    // FRAMELEFT
    Path path = Path();
    path.moveTo(imageWidth * 0.200934, imageHeight * 0.434579);
    path.lineTo(imageWidth * 0.163551, imageHeight * 0.434579);
    path.lineTo(imageWidth * 0.163551, imageHeight * 0.560747);
    path.lineTo(imageWidth * 0.200934, imageHeight * 0.560747);
    ctx.drawPath(
        path,
        Paint()
          ..color = backgroundColor.labelColor
          ..strokeWidth = 1
          ..strokeCap = ui.StrokeCap.square
          ..strokeJoin = ui.StrokeJoin.miter
          ..style = ui.PaintingStyle.stroke);

    // TRIANGLELEFT
    path = Path();
    path.moveTo(imageWidth * 0.163551, imageHeight * 0.471962);
    path.lineTo(imageWidth * 0.205607, imageHeight * 0.5);
    path.lineTo(imageWidth * 0.163551, imageHeight * 0.523364);
    path.lineTo(imageWidth * 0.163551, imageHeight * 0.471962);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = backgroundColor.labelColor
          ..style = ui.PaintingStyle.fill);

    // FRAMERIGHT
    path = Path();
    path.moveTo(imageWidth * 0.799065, imageHeight * 0.434579);
    path.lineTo(imageWidth * 0.836448, imageHeight * 0.434579);
    path.lineTo(imageWidth * 0.836448, imageHeight * 0.560747);
    path.lineTo(imageWidth * 0.799065, imageHeight * 0.560747);
    ctx.drawPath(
        path,
        Paint()
          ..color = backgroundColor.labelColor
          ..strokeWidth = 1
          ..strokeCap = ui.StrokeCap.square
          ..strokeJoin = ui.StrokeJoin.miter
          ..style = ui.PaintingStyle.stroke);

    // TRIANGLERIGHT
    path = Path();
    path.moveTo(imageWidth * 0.836448, imageHeight * 0.471962);
    path.lineTo(imageWidth * 0.794392, imageHeight * 0.5);
    path.lineTo(imageWidth * 0.836448, imageHeight * 0.523364);
    path.lineTo(imageWidth * 0.836448, imageHeight * 0.471962);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = backgroundColor.labelColor
          ..style = ui.PaintingStyle.fill);

    ctx.restore();
  }

  void drawPointerImage(Canvas ctx) {
    ctx.save();

    // POINTER_LEVEL
    Path path = Path();
    path.moveTo(imageWidth * 0.523364, imageHeight * 0.350467);
    path.lineTo(imageWidth * 0.5, imageHeight * 0.130841);
    path.lineTo(imageWidth * 0.476635, imageHeight * 0.350467);
    path.cubicTo(
      imageWidth * 0.476635,
      imageHeight * 0.350467,
      imageWidth * 0.490654,
      imageHeight * 0.345794,
      imageWidth * 0.5,
      imageHeight * 0.345794,
    );
    path.cubicTo(
      imageWidth * 0.509345,
      imageHeight * 0.345794,
      imageWidth * 0.523364,
      imageHeight * 0.350467,
      imageWidth * 0.523364,
      imageHeight * 0.350467,
    );
    path.close();

    Color tmpDarkColor = pointerColor.dark.withOpacity(0.70588);
    Color tmpLightColor = pointerColor.light.withOpacity(0.70588);

    ui.Gradient POINTER_LEVEL_GRADIENT = ui.Gradient.linear(
      Offset(0, 0.154205 * imageHeight),
      Offset(0, 0.350466 * imageHeight),
      [
        tmpDarkColor,
        tmpLightColor,
        tmpLightColor,
        tmpDarkColor,
      ],
      [0, 0.3, 0.59, 1],
    );

    ctx.drawPath(
        path,
        Paint()
          ..shader = POINTER_LEVEL_GRADIENT
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.light
          ..strokeWidth = 1
          ..strokeCap = ui.StrokeCap.square
          ..strokeJoin = ui.StrokeJoin.miter
          ..style = ui.PaintingStyle.stroke);

    ctx.restore();
  }

  void drawStepPointerImage(Canvas ctx) {
    ctx.save();

    Color tmpDarkColor = pointerColor.dark;
    Color tmpLightColor = pointerColor.light;
    tmpDarkColor = tmpDarkColor.withOpacity(0.70588);
    tmpLightColor = tmpLightColor.withOpacity(0.70588);

    // POINTER_LEVEL_LEFT
    Path path = Path();
    path.moveTo(imageWidth * 0.285046, imageHeight * 0.514018);
    path.lineTo(imageWidth * 0.21028, imageHeight * 0.5);
    path.lineTo(imageWidth * 0.285046, imageHeight * 0.481308);
    path.cubicTo(
      imageWidth * 0.285046,
      imageHeight * 0.481308,
      imageWidth * 0.280373,
      imageHeight * 0.490654,
      imageWidth * 0.280373,
      imageHeight * 0.495327,
    );
    path.cubicTo(
      imageWidth * 0.280373,
      imageHeight * 0.504672,
      imageWidth * 0.285046,
      imageHeight * 0.514018,
      imageWidth * 0.285046,
      imageHeight * 0.514018,
    );
    path.close();

    ui.Gradient POINTER_LEVEL_LEFT_GRADIENT = ui.Gradient.linear(
      Offset(0.224299 * imageWidth, 0),
      Offset(0.289719 * imageWidth, 0),
      [
        tmpDarkColor,
        tmpLightColor,
        tmpLightColor,
        tmpDarkColor,
      ],
      [0, 0.3, 0.59, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = POINTER_LEVEL_LEFT_GRADIENT
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.light
          ..strokeWidth = 1
          ..strokeCap = ui.StrokeCap.square
          ..strokeJoin = ui.StrokeJoin.miter
          ..style = ui.PaintingStyle.stroke);

    // POINTER_LEVEL_RIGHT
    path = Path();
    path.moveTo(imageWidth * 0.714953, imageHeight * 0.514018);
    path.lineTo(imageWidth * 0.789719, imageHeight * 0.5);
    path.lineTo(imageWidth * 0.714953, imageHeight * 0.481308);
    path.cubicTo(
      imageWidth * 0.714953,
      imageHeight * 0.481308,
      imageWidth * 0.719626,
      imageHeight * 0.490654,
      imageWidth * 0.719626,
      imageHeight * 0.495327,
    );
    path.cubicTo(
      imageWidth * 0.719626,
      imageHeight * 0.504672,
      imageWidth * 0.714953,
      imageHeight * 0.514018,
      imageWidth * 0.714953,
      imageHeight * 0.514018,
    );
    path.close();

    ui.Gradient POINTER_LEVEL_RIGHT_GRADIENT = ui.Gradient.linear(
      Offset(0.7757 * imageWidth, 0),
      Offset(0.71028 * imageWidth, 0),
      [
        tmpDarkColor,
        tmpLightColor,
        tmpLightColor,
        tmpDarkColor,
      ],
      [0, 0.3, 0.59, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = POINTER_LEVEL_RIGHT_GRADIENT
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.light
          ..strokeWidth = 1
          ..strokeCap = ui.StrokeCap.square
          ..strokeJoin = ui.StrokeJoin.miter
          ..style = ui.PaintingStyle.stroke);

    ctx.restore();
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background
  void init() {
    if (frameVisible) {
      ui.Picture picture = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(picture);
    }

    if (backgroundVisible) {
      ui.Picture picture = drawBackground(
        backgroundColor,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(picture);
      drawTickmarksImage(backgroundContext);
    }

    drawMarkerImage(pointerContext);

    drawPointerImage(pointerContext);

    drawStepPointerImage(stepPointerContext);

    if (foregroundVisible) {
      ui.Picture picture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        false,
        KnobTypeEnum.STANDARD_KNOB,
        KnobStyleEnum.BLACK,
        GaugeTypeEnum.TYPE1,
        OrientationEnum.NORTH,
      );
      foregroundContext.drawPicture(picture);
    }
  }

  void repaint() {
    init();

    canvas.save();

    angle = HALF_PI + value * angleStep - HALF_PI;
    if (rotateFace) {
      canvas.translate(centerX, centerY);
      canvas.rotate(-angle);
      canvas.translate(-centerX, -centerY);
    }
    // Draw buffered image to visible canvas
    if (frameVisible || backgroundVisible) {
      ui.Picture picture = backgroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    canvas.save();
    // Define rotation center
    canvas.translate(centerX, centerY);
    canvas.rotate(angle);

    // Draw pointer
    canvas.translate(-centerX, -centerY);
    ui.Picture picture = pointerContextRecorder.endRecording();
    canvas.drawPicture(picture);

    if (textOrientationFixed) {
      canvas.restore();
      //     if (decimalsVisible) {
      //       mainCtx.font = imageWidth * 0.1 + 'px ' + stdFontName
      //     } else {
      //       mainCtx.font = imageWidth * 0.15 + 'px ' + stdFontName
      //     }
      //     mainCtx.fillText(
      //       visibleValue.toFixed(decimals) + '\u00B0',
      //       centerX,
      //       centerY,
      //       imageWidth * 0.35
      //     )
    } else {
      TextStyle font = getFont(decimalsVisible ? imageWidth * 0.095 : imageWidth * 0.11, backgroundColor.labelColor);
      var textSpan = TextSpan(
        text: '${visibleValue.toStringAsFixed(decimals)}\u00B0',
        style: font,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth * 0.45,
      );
      textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2));
      canvas.restore();
    }

    canvas.translate(centerX, centerY);
    canvas.rotate(angle + stepValue * RAD_FACTOR);
    canvas.translate(-centerX, -centerY);
    picture = stepPointerContextRecorder.endRecording();
    canvas.drawPicture(picture);
    canvas.restore();

    // Draw foreground
    if (foregroundVisible) {
      picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  // Visualize the component
  repaint();
}
