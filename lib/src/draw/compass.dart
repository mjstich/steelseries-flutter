// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'drawRadialCustomImage.dart';
import 'drawRoseImage.dart';
import 'tools.dart';

class CompassInit {
  final ui.Picture? frameImage;
  final ui.Picture? backgroundImage;
  final ui.Picture? foregroundImage;

  CompassInit({this.frameImage, this.backgroundImage, this.foregroundImage});
}

void drawCompass(Canvas canvas, Size canvasSize, Parameters parameters) {
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.foregroundVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(BackgroundColorEnum.RED);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  PointerTypeEnum pointerType = parameters.pointerTypeWithDefault(PointerTypeEnum.TYPE1);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(ColorEnum.RED);
  KnobTypeEnum knobType = parameters.knobTypeWithDefault(KnobTypeEnum.METAL_KNOB);
  KnobStyleEnum knobStyle = parameters.knobStyleWithDefault(KnobStyleEnum.SILVER);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE2);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  List<String> pointSymbols = parameters.pointerSymbolsWithDefault(['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']);
  bool pointSymbolsVisible = parameters.pointSymbolsVisibleWithDefault(true);
  ui.Image? customLayer = parameters.customLayer;
  bool degreeScale = parameters.degreeScaleWithDefault(true);
  bool roseVisible = parameters.roseVisibleWithDefault(true);
  bool rotateFace = parameters.rotateFaceWithDefault(false);
  double value = parameters.valueWithDefault(0.0);
  Color degreeFontColor = parameters.degreeFontColorWithDefault(Colors.white);

  double angleStep = RAD_FACTOR;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  //double shadowOffset = imageWidth * 0.006;

  // **************   Image creation  ********************
  void drawTickmarksImage(Canvas ctx) {
    // let val
    // ctx.textAlign = 'center'
    // ctx.textBaseline = 'middle'

    ctx.save();
    Paint strokePaint = Paint()
      ..color = backgroundColor.labelColor
      ..strokeWidth = 1
      ..style = ui.PaintingStyle.stroke;
    ctx.translate(centerX, centerY);

    if (!degreeScale) {
      double fontXOffset = -0.311;
      double smallFontXOffset = -0.59;

      final TextStyle stdFont = getFont(0.12 * imageWidth, degreeFontColor);
      final TextStyle smlFont = getFont(0.06 * imageWidth, degreeFontColor);

      for (double i = 0; i < 360; i += 2.5) {
        // ctx.save();
        // ctx.rotate(i * angleStep);

        if (i.toInt() % 5 == 0) {
          Path path = Path();
          path.moveTo(imageWidth * 0.38, 0);
          path.lineTo(imageWidth * 0.36, 0);
          path.close();
          canvas.drawPath(path, strokePaint);
        }

        // Draw the labels
        ctx.save();
        switch (i) {
          case 0:
            ctx.translate(imageWidth * 0.445, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[2],
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
            ctx.translate(-imageWidth * 0.445, 0);
            break;
          case 45:
            ctx.translate(imageWidth * 0.34, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[3],
              style: smlFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(smlFont.fontSize! * smallFontXOffset, 0));
            ctx.translate(-imageWidth * 0.34, 0);
            break;
          case 90:
            ctx.translate(imageWidth * 0.445, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[4],
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
            ctx.translate(-imageWidth * 0.445, 0);
            break;
          case 135:
            ctx.translate(imageWidth * 0.34, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[5],
              style: smlFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(smlFont.fontSize! * smallFontXOffset, 0));
            ctx.translate(-imageWidth * 0.34, 0);
            break;
          case 180:
            ctx.translate(imageWidth * 0.445, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[6],
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
            ctx.translate(-imageWidth * 0.445, 0);
            break;
          case 225:
            ctx.translate(imageWidth * 0.34, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[7],
              style: smlFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(smlFont.fontSize! * smallFontXOffset, 0));
            ctx.translate(-imageWidth * 0.34, 0);
            break;
          case 270:
            ctx.translate(imageWidth * 0.445, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[0],
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
            ctx.translate(-imageWidth * 0.445, 0);
            break;
          case 315:
            ctx.translate(imageWidth * 0.34, 0);
            ctx.rotate(HALF_PI);
            var textSpan = TextSpan(
              text: pointSymbols[1],
              style: smlFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: imageWidth,
            );
            textPainter.paint(canvas, Offset(smlFont.fontSize! * smallFontXOffset, 0));
            ctx.translate(-imageWidth * 0.34, 0);
            break;
        }
        ctx.restore();

        if (roseVisible && (i == 0 || i == 22.5 || i == 45 || i == 67.5 || i == 90 || i == 112.5 || i == 135 || i == 157.5 || i == 180 || i == 202.5 || i == 225 || i == 247.5 || i == 270 || i == 292.5 || i == 315 || i == 337.5 || i == 360)) {
          // ROSE_LINE
          ctx.save();
          Path path = Path();
          // indent the 16 half quadrant lines a bit for visual effect
          if (i % 45 != 0) {
            path.moveTo(imageWidth * 0.29, 0);
          } else {
            path.moveTo(imageWidth * 0.38, 0);
          }
          path.lineTo(imageWidth * 0.1, 0);
          path.close();
          ctx.restore();
          ctx.drawPath(
              path,
              Paint()
                ..strokeWidth = 1
                ..color = backgroundColor.symbolColor
                ..style = ui.PaintingStyle.stroke);
        }
        ctx.rotate(angleStep * 2.5);
        //ctx.restore();
      }
    } else {
      double fontXOffset = -0.309;
      double smallFontXOffset = -0.99;

      final TextStyle stdFont = getFont(0.07 * imageWidth, degreeFontColor);
      final TextStyle smlFont = getFont(0.023 * imageWidth, degreeFontColor);

      ctx.rotate(angleStep * 10);

      for (int i = 10; i <= 360; i += 10) {
        // Draw the labels
        ctx.save();
        if (pointSymbolsVisible) {
          switch (i) {
            case 360:
              ctx.translate(imageWidth * 0.41, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[2],
                style: stdFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: 50,
              );
              textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
              ctx.translate(-imageWidth * 0.41, 0);
              break;
            case 90:
              ctx.translate(imageWidth * 0.41, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[4],
                style: stdFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: 50,
              );
              textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
              ctx.translate(-imageWidth * 0.41, 0);
              break;
            case 180:
              ctx.translate(imageWidth * 0.41, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[6],
                style: stdFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: 50,
              );
              textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
              ctx.translate(-imageWidth * 0.41, 0);
              break;
            case 270:
              ctx.translate(imageWidth * 0.41, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[0],
                style: stdFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: 50,
              );
              textPainter.paint(canvas, Offset(stdFont.fontSize! * fontXOffset, 0));
              ctx.translate(-imageWidth * 0.41, 0);
              break;
            default:
              double val = (i + 90) % 360;
              ctx.translate(imageWidth * 0.39, 0);
              ctx.rotate(HALF_PI);
              String text = val.toInt().toString();
              if (val.toInt() < 100) {
                text = '0$text';
              }
              var textSpan = TextSpan(
                text: text,
                style: smlFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: 50,
              );
              textPainter.paint(canvas, Offset(smlFont.fontSize! * smallFontXOffset, 0));
              ctx.translate(-imageWidth * 0.39, 0);
          }
        } else {
          double val = (i + 90) % 360;
          ctx.translate(imageWidth * 0.39, 0);
          ctx.rotate(HALF_PI);
          String text = val.toInt().toString();
          if (val.toInt() < 10) {
            text = '00$text';
          } else if (val.toInt() < 100) {
            text = '0$text';
          }
          var textSpan = TextSpan(
            text: text,
            style: smlFont,
          );
          final textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: 50,
          );
          textPainter.paint(canvas, Offset(smlFont.fontSize! * smallFontXOffset, 0));
          ctx.translate(-imageWidth * 0.39, 0);
        }
        ctx.restore();
        ctx.rotate(angleStep * 10);
      }
    }
    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  void drawPointerImage(Canvas ctx) {
    ctx.save();

    switch (pointerType) {
      case PointerTypeEnum.TYPE2:
        {
          // NORTHPOINTER
          Path path = Path();
          path.moveTo(imageWidth * 0.53271, imageHeight * 0.453271);
          path.cubicTo(
            imageWidth * 0.53271,
            imageHeight * 0.453271,
            imageWidth * 0.5,
            imageHeight * 0.149532,
            imageWidth * 0.5,
            imageHeight * 0.149532,
          );
          path.cubicTo(
            imageWidth * 0.5,
            imageHeight * 0.149532,
            imageWidth * 0.467289,
            imageHeight * 0.453271,
            imageWidth * 0.467289,
            imageHeight * 0.453271,
          );
          path.cubicTo(
            imageWidth * 0.453271,
            imageHeight * 0.462616,
            imageWidth * 0.443925,
            imageHeight * 0.481308,
            imageWidth * 0.443925,
            imageHeight * 0.5,
          );
          path.cubicTo(
            imageWidth * 0.443925,
            imageHeight * 0.5,
            imageWidth * 0.556074,
            imageHeight * 0.5,
            imageWidth * 0.556074,
            imageHeight * 0.5,
          );
          path.cubicTo(
            imageWidth * 0.556074,
            imageHeight * 0.481308,
            imageWidth * 0.546728,
            imageHeight * 0.462616,
            imageWidth * 0.53271,
            imageHeight * 0.453271,
          );
          path.close();
          ui.Gradient NORTHPOINTER2_GRADIENT = ui.Gradient.linear(
            Offset(0.471962 * imageWidth, 0),
            Offset(0.528036 * imageWidth, 0),
            [
              pointerColor.light,
              pointerColor.light,
              pointerColor.medium,
              pointerColor.medium,
            ],
            [0, 0.46, 0.47, 1],
          );
          Paint fillPaint = Paint()
            ..shader = NORTHPOINTER2_GRADIENT
            ..style = ui.PaintingStyle.fill;
          Paint strokePaint = Paint()
            ..color = pointerColor.dark
            ..style = ui.PaintingStyle.stroke
            ..strokeWidth = 1
            ..strokeCap = ui.StrokeCap.square
            ..strokeJoin = ui.StrokeJoin.miter;

          canvas.drawPath(path, fillPaint);
          canvas.drawPath(path, strokePaint);

          // SOUTHPOINTER
          path = Path();
          path.moveTo(imageWidth * 0.467289, imageHeight * 0.546728);
          path.cubicTo(
            imageWidth * 0.467289,
            imageHeight * 0.546728,
            imageWidth * 0.5,
            imageHeight * 0.850467,
            imageWidth * 0.5,
            imageHeight * 0.850467,
          );
          path.cubicTo(
            imageWidth * 0.5,
            imageHeight * 0.850467,
            imageWidth * 0.53271,
            imageHeight * 0.546728,
            imageWidth * 0.53271,
            imageHeight * 0.546728,
          );
          path.cubicTo(
            imageWidth * 0.546728,
            imageHeight * 0.537383,
            imageWidth * 0.556074,
            imageHeight * 0.518691,
            imageWidth * 0.556074,
            imageHeight * 0.5,
          );
          path.cubicTo(
            imageWidth * 0.556074,
            imageHeight * 0.5,
            imageWidth * 0.443925,
            imageHeight * 0.5,
            imageWidth * 0.443925,
            imageHeight * 0.5,
          );
          path.cubicTo(
            imageWidth * 0.443925,
            imageHeight * 0.518691,
            imageWidth * 0.453271,
            imageHeight * 0.537383,
            imageWidth * 0.467289,
            imageHeight * 0.546728,
          );
          path.close();
          ui.Gradient SOUTHPOINTER2_GRADIENT = ui.Gradient.linear(
            Offset(0.471962 * imageWidth, 0),
            Offset(0.528036 * imageWidth, 0),
            [
              colorFromHex('#e3e5e8'),
              colorFromHex('#e3e5e8'),
              colorFromHex('#abb1b8'),
              colorFromHex('#abb1b8'),
            ],
            [0, 0.48, 0.48, 1],
          );
          fillPaint.shader = SOUTHPOINTER2_GRADIENT;
          Color strokeColor_SOUTHPOINTER2 = colorFromHex('#abb1b8');
          strokePaint.color = strokeColor_SOUTHPOINTER2;
          canvas.drawPath(path, fillPaint);
          canvas.drawPath(path, strokePaint);
        }
        break;

      case PointerTypeEnum.TYPE3:
        {
          // NORTHPOINTER
          Path path = Path();
          path.moveTo(imageWidth * 0.5, imageHeight * 0.149532);
          path.cubicTo(
            imageWidth * 0.5,
            imageHeight * 0.149532,
            imageWidth * 0.443925,
            imageHeight * 0.490654,
            imageWidth * 0.443925,
            imageHeight * 0.5,
          );
          path.cubicTo(
            imageWidth * 0.443925,
            imageHeight * 0.53271,
            imageWidth * 0.467289,
            imageHeight * 0.556074,
            imageWidth * 0.5,
            imageHeight * 0.556074,
          );
          path.cubicTo(
            imageWidth * 0.53271,
            imageHeight * 0.556074,
            imageWidth * 0.556074,
            imageHeight * 0.53271,
            imageWidth * 0.556074,
            imageHeight * 0.5,
          );
          path.cubicTo(
            imageWidth * 0.556074,
            imageHeight * 0.490654,
            imageWidth * 0.5,
            imageHeight * 0.149532,
            imageWidth * 0.5,
            imageHeight * 0.149532,
          );
          path.close();
          ui.Gradient NORTHPOINTER3_GRADIENT = ui.Gradient.linear(
            Offset(0.471962 * imageWidth, 0),
            Offset(0.528036 * imageWidth, 0),
            [
              pointerColor.light,
              pointerColor.light,
              pointerColor.medium,
              pointerColor.medium,
            ],
            [0, 0.46, 0.47, 1],
          );
          Paint fillPaint = Paint()
            ..shader = NORTHPOINTER3_GRADIENT
            ..style = ui.PaintingStyle.fill;
          Paint strokePaint = Paint()
            ..color = pointerColor.dark
            ..style = ui.PaintingStyle.stroke
            ..strokeWidth = 1
            ..strokeCap = ui.StrokeCap.square
            ..strokeJoin = ui.StrokeJoin.miter;

          canvas.drawPath(path, fillPaint);
          canvas.drawPath(path, strokePaint);
        }
        break;

      case PointerTypeEnum.TYPE1:
      /* falls through */
      default:
        {
          // NORTHPOINTER
          Path path = Path();
          path.moveTo(imageWidth * 0.5, imageHeight * 0.495327);
          path.lineTo(imageWidth * 0.528037, imageHeight * 0.495327);
          path.lineTo(imageWidth * 0.5, imageHeight * 0.149532);
          path.lineTo(imageWidth * 0.471962, imageHeight * 0.495327);
          path.lineTo(imageWidth * 0.5, imageHeight * 0.495327);
          path.close();
          ui.Gradient NORTHPOINTER1_GRADIENT = ui.Gradient.linear(
            Offset(0.471962 * imageWidth, 0),
            Offset(0.528036 * imageWidth, 0),
            [
              pointerColor.light,
              pointerColor.light,
              pointerColor.medium,
              pointerColor.medium,
            ],
            [0, 0.46, 0.47, 1],
          );
          Paint fillPaint = Paint()
            ..shader = NORTHPOINTER1_GRADIENT
            ..style = ui.PaintingStyle.fill;
          Paint strokePaint = Paint()
            ..color = pointerColor.dark
            ..style = ui.PaintingStyle.stroke
            ..strokeWidth = 1
            ..strokeCap = ui.StrokeCap.square
            ..strokeJoin = ui.StrokeJoin.miter;

          canvas.drawPath(path, fillPaint);
          canvas.drawPath(path, strokePaint);

          // SOUTHPOINTER
          path = Path();
          path.moveTo(imageWidth * 0.5, imageHeight * 0.504672);
          path.lineTo(imageWidth * 0.471962, imageHeight * 0.504672);
          path.lineTo(imageWidth * 0.5, imageHeight * 0.850467);
          path.lineTo(imageWidth * 0.528037, imageHeight * 0.504672);
          path.lineTo(imageWidth * 0.5, imageHeight * 0.504672);
          path.close();
          ui.Gradient SOUTHPOINTER1_GRADIENT = ui.Gradient.linear(
            Offset(0.471962 * imageWidth, 0),
            Offset(0.528036 * imageWidth, 0),
            [
              colorFromHex('#e3e5e8'),
              colorFromHex('#e3e5e8'),
              colorFromHex('#abb1b8'),
              colorFromHex('#abb1b8'),
            ],
            [0, 0.48, 0.480099, 1],
          );
          fillPaint.shader = SOUTHPOINTER1_GRADIENT;
          Color strokeColor_SOUTHPOINTER = colorFromHex('#abb1b8');
          strokePaint.color = strokeColor_SOUTHPOINTER;
          canvas.drawPath(path, fillPaint);
          canvas.drawPath(path, strokePaint);
        }
        break;
    }
    ctx.restore();
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background
  CompassInit init(Canvas canvas) {
    ui.Picture? frameImage;
    ui.Picture? backgroundImage;
    ui.Picture? foregroundImage;

    if (frameVisible) {
      frameImage = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
    }

    if (backgroundVisible) {
      backgroundImage = drawBackground(
        backgroundColor,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
    }

    if (foregroundVisible) {
      foregroundImage = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        true,
        knobType,
        knobStyle,
        GaugeTypeEnum.TYPE1,
        OrientationEnum.EAST,
      );
    }
    return CompassInit(frameImage: frameImage, foregroundImage: foregroundImage, backgroundImage: backgroundImage);
  }

  bool repaint() {
    var compassInit = init(canvas);

    canvas.save();
    // double radius = imageWidth / 2;
    // canvas.save();
    // canvas.translate(size / 2, size / 2);
    // Offset center = const Offset(0.0, 0.0);
    // // draw shadow first
    // Path oval = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    // Paint shadowPaint = Paint()
    //   ..color = Colors.black.withOpacity(0.3)
    //   ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    // canvas.drawPath(oval, shadowPaint);
    // canvas.restore();

    // mainCtx.clearRect(0, 0, mainCtx.canvas.width, mainCtx.canvas.height)
    // // Define rotation center
    double angle = HALF_PI + value * angleStep - HALF_PI;

    if (backgroundVisible || frameVisible) {
      if (frameVisible) {
        canvas.drawPicture(compassInit.frameImage!);
      }

      if (backgroundVisible) {
        canvas.drawPicture(compassInit.backgroundImage!);
      }
    }

    if (rotateFace) {
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(-angle);
      canvas.translate(-centerX, -centerY);
      drawRadialCustomImage(
        canvas,
        customLayer,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      if (roseVisible) {
        drawRoseImage(
          canvas,
          centerX,
          centerY,
          imageWidth,
          imageHeight,
          backgroundColor,
        );
      }
      drawTickmarksImage(canvas);
      canvas.restore();
    } else {
      drawRadialCustomImage(
        canvas,
        customLayer,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      if (roseVisible) {
        drawRoseImage(
          canvas,
          centerX,
          centerY,
          imageWidth,
          imageHeight,
          backgroundColor,
        );
      }
      drawTickmarksImage(canvas);
      canvas.translate(centerX, centerY);
      canvas.rotate(angle);
      canvas.translate(-centerX, -centerY);
    }
    // Set the pointer shadow params
    // mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    // mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
    // mainCtx.shadowBlur = shadowOffset * 2
    // // Draw the pointer
    drawPointerImage(canvas);

    // Undo the translations & shadow settings
    canvas.restore();

    if (foregroundVisible) {
      canvas.drawPicture(compassInit.foregroundImage!);
    }
    return true;
  }

  // Visualize the component
  repaint();
}
