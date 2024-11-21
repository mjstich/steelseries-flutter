// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'tools.dart';

void drawHorizon(Canvas canvas, Size canvasSize, Parameters parameters) {
  double size =
      parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  FrameDesignEnum frameDesign =
      parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  ForegroundTypeEnum foregroundType =
      parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(ColorEnum.WHITE);
  double roll = parameters.rollWithDefault(0);
  double pitch = parameters.pitchWithDefault(0);
  double pitchPixel = (PI * size) / 360;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  // **************   Buffer creation  ********************
  // Buffer for all static background painting code
  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // Buffer for pointer image painting code
  var valueContextRecorder = ui.PictureRecorder();
  var valueContext = Canvas(valueContextRecorder);

  // Buffer for indicator painting code
  // const indicatorBuffer = createBuffer(size * 0.037383, size * 0.056074)
  // const indicatorContext = indicatorBuffer.getContext('2d')
  var indicatorContextRecorder = ui.PictureRecorder();
  var indicatorContext = Canvas(indicatorContextRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  // **************   Image creation  ********************
  void drawHorizonBackgroundImage(Canvas ctx) {
    ctx.save();

    double imgWidth = size;
    double imgHeight = size * PI;

    // HORIZON
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, imgWidth, imgHeight));
    path.close();

    var HORIZON_GRADIENT = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, imgHeight),
      [
        colorFromHex('#7fd5f0'),
        colorFromHex('#7fd5f0'),
        colorFromHex('#3c4439'),
        colorFromHex('#3c4439'),
      ],
      [0, 0.5, 0.5, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = HORIZON_GRADIENT
          ..style = ui.PaintingStyle.fill);

    // ctx.lineWidth = 1
    double stepSizeY = (imgHeight / 360) * 5;
    bool stepTen = false;
    int step = 10;

    double fontSize = imgWidth * 0.04;
    TextStyle font = getFont(fontSize, colorFromHex('#37596e'));

    for (double y = imgHeight / 2 - stepSizeY; y > 0; y -= stepSizeY) {
      if (step <= 90) {
        if (stepTen) {
          var textSpan = TextSpan(
            text: step.toString(),
            style: font,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imgWidth * 0.375,
          );
          textPainter.paint(
              ctx,
              Offset(
                  (imgWidth - imgWidth * 0.2) / 2 - 8 - textPainter.size.width,
                  y - textPainter.size.height / 2));
          textPainter.paint(
              ctx,
              Offset(imgWidth - (imgWidth - imgWidth * 0.2) / 2 + 8,
                  y - textPainter.size.height / 2));

          Path path = Path();
          path.moveTo((imgWidth - imgWidth * 0.2) / 2, y);
          path.lineTo(imgWidth - (imgWidth - imgWidth * 0.2) / 2, y);
          path.close();
          ctx.drawPath(
              path,
              Paint()
                ..color = colorFromHex('#000000')
                ..strokeWidth = 1
                ..style = ui.PaintingStyle.stroke);

          step += 10;
        } else {
          Path path = Path();
          path.moveTo((imgWidth - imgWidth * 0.1) / 2, y);
          path.lineTo(imgWidth - (imgWidth - imgWidth * 0.1) / 2, y);
          path.close();
          ctx.drawPath(
              path,
              Paint()
                ..color = colorFromHex('#000000')
                ..strokeWidth = 1
                ..style = ui.PaintingStyle.stroke);
        }
        //     ctx.stroke()
      }
      stepTen ^= true;
    }
    font = getFont(fontSize, colorFromHex('#FFFFFF'));
    stepTen = false;
    step = 10;
    path = Path();
    path.moveTo(0, imgHeight / 2);
    path.lineTo(imgWidth, imgHeight / 2);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#FFFFFF')
          ..strokeWidth = 1.5
          ..style = ui.PaintingStyle.stroke);

    for (double y = imgHeight / 2 + stepSizeY; y <= imgHeight; y += stepSizeY) {
      if (step <= 90) {
        if (stepTen) {
          var textSpan = TextSpan(
            text: (-step).toString(),
            style: font,
          );
          var textPainter = TextPainter(
            text: textSpan,
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: imgWidth * 0.375,
          );
          textPainter.paint(
              ctx,
              Offset(
                  (imgWidth - imgWidth * 0.2) / 2 - 8 - textPainter.size.width,
                  y - textPainter.size.height / 2));
          textPainter.paint(
              ctx,
              Offset(imgWidth - (imgWidth - imgWidth * 0.2) / 2 + 8,
                  y - textPainter.size.height / 2));
          Path path = Path();
          path.moveTo((imgWidth - imgWidth * 0.2) / 2, y);
          path.lineTo(imgWidth - (imgWidth - imgWidth * 0.2) / 2, y);
          path.close();
          ctx.drawPath(
              path,
              Paint()
                ..strokeWidth = 1
                ..color = colorFromHex('#FFFFFF')
                ..style = ui.PaintingStyle.stroke);

          step += 10;
        } else {
          Path path = Path();
          path.moveTo((imgWidth - imgWidth * 0.1) / 2, y);
          path.lineTo(imgWidth - (imgWidth - imgWidth * 0.1) / 2, y);
          path.close();
          ctx.drawPath(
              path,
              Paint()
                ..strokeWidth = 1
                ..color = colorFromHex('#FFFFFF')
                ..style = ui.PaintingStyle.stroke);
        }
      }
      stepTen ^= true;
    }

    ctx.restore();
  }

  void drawHorizonForegroundImage(Canvas ctx) {
    ctx.save();

    // CENTERINDICATOR
    Path path = Path();
    path.moveTo(imageWidth * 0.476635, imageHeight * 0.5);
    path.cubicTo(
      imageWidth * 0.476635,
      imageHeight * 0.514018,
      imageWidth * 0.485981,
      imageHeight * 0.523364,
      imageWidth * 0.5,
      imageHeight * 0.523364,
    );
    path.cubicTo(
      imageWidth * 0.514018,
      imageHeight * 0.523364,
      imageWidth * 0.523364,
      imageHeight * 0.514018,
      imageWidth * 0.523364,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.523364,
      imageHeight * 0.485981,
      imageWidth * 0.514018,
      imageHeight * 0.476635,
      imageWidth * 0.5,
      imageHeight * 0.476635,
    );
    path.cubicTo(
      imageWidth * 0.485981,
      imageHeight * 0.476635,
      imageWidth * 0.476635,
      imageHeight * 0.485981,
      imageWidth * 0.476635,
      imageHeight * 0.5,
    );
    path.close();
    path.moveTo(imageWidth * 0.415887, imageHeight * 0.504672);
    path.lineTo(imageWidth * 0.415887, imageHeight * 0.495327);
    path.cubicTo(
      imageWidth * 0.415887,
      imageHeight * 0.495327,
      imageWidth * 0.467289,
      imageHeight * 0.495327,
      imageWidth * 0.467289,
      imageHeight * 0.495327,
    );
    path.cubicTo(
      imageWidth * 0.471962,
      imageHeight * 0.481308,
      imageWidth * 0.481308,
      imageHeight * 0.471962,
      imageWidth * 0.495327,
      imageHeight * 0.467289,
    );
    path.cubicTo(
      imageWidth * 0.495327,
      imageHeight * 0.467289,
      imageWidth * 0.495327,
      imageHeight * 0.415887,
      imageWidth * 0.495327,
      imageHeight * 0.415887,
    );
    path.lineTo(imageWidth * 0.504672, imageHeight * 0.415887);
    path.cubicTo(
      imageWidth * 0.504672,
      imageHeight * 0.415887,
      imageWidth * 0.504672,
      imageHeight * 0.467289,
      imageWidth * 0.504672,
      imageHeight * 0.467289,
    );
    path.cubicTo(
      imageWidth * 0.518691,
      imageHeight * 0.471962,
      imageWidth * 0.528037,
      imageHeight * 0.481308,
      imageWidth * 0.53271,
      imageHeight * 0.495327,
    );
    path.cubicTo(
      imageWidth * 0.53271,
      imageHeight * 0.495327,
      imageWidth * 0.584112,
      imageHeight * 0.495327,
      imageWidth * 0.584112,
      imageHeight * 0.495327,
    );
    path.lineTo(imageWidth * 0.584112, imageHeight * 0.504672);
    path.cubicTo(
      imageWidth * 0.584112,
      imageHeight * 0.504672,
      imageWidth * 0.53271,
      imageHeight * 0.504672,
      imageWidth * 0.53271,
      imageHeight * 0.504672,
    );
    path.cubicTo(
      imageWidth * 0.528037,
      imageHeight * 0.518691,
      imageWidth * 0.518691,
      imageHeight * 0.53271,
      imageWidth * 0.5,
      imageHeight * 0.53271,
    );
    path.cubicTo(
      imageWidth * 0.481308,
      imageHeight * 0.53271,
      imageWidth * 0.471962,
      imageHeight * 0.518691,
      imageWidth * 0.467289,
      imageHeight * 0.504672,
    );
    path.cubicTo(
      imageWidth * 0.467289,
      imageHeight * 0.504672,
      imageWidth * 0.415887,
      imageHeight * 0.504672,
      imageWidth * 0.415887,
      imageHeight * 0.504672,
    );
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.light
          ..style = ui.PaintingStyle.fill);

    // Tickmarks
    double step = 5;
    double stepRad = 5 * RAD_FACTOR;
    ctx.translate(centerX, centerY);
    ctx.rotate(-HALF_PI);
    ctx.translate(-centerX, -centerY);
    for (double angle = -90; angle <= 90; angle += step) {
      if (angle % 45 == 0 || angle == 0) {
        Path path = Path();
        path.moveTo(imageWidth * 0.5, imageHeight * 0.088785);
        path.lineTo(imageWidth * 0.5, imageHeight * 0.113);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = pointerColor.medium
              ..strokeWidth = 2
              ..style = ui.PaintingStyle.stroke);
      } else if (angle % 15 == 0) {
        Path path = Path();
        path.moveTo(imageWidth * 0.5, imageHeight * 0.088785);
        path.lineTo(imageWidth * 0.5, imageHeight * 0.103785);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = colorFromHex('#FFFFFF')
              ..strokeWidth = 1
              ..style = ui.PaintingStyle.stroke);
      } else {
        Path path = Path();
        path.moveTo(imageWidth * 0.5, imageHeight * 0.088785);
        path.lineTo(imageWidth * 0.5, imageHeight * 0.093785);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = colorFromHex('#FFFFFF')
              ..strokeWidth = 0.5
              ..style = ui.PaintingStyle.stroke);
      }
      ctx.translate(centerX, centerY);
      ctx.rotate(stepRad);
      ctx.translate(-centerX, -centerY);
    }

    ctx.restore();
  }

  void drawIndicatorImage(Canvas ctx) {
    ctx.save();

    double imgWidth = imageWidth * 0.037383;
    double imgHeight = imageHeight * 0.056074;

    Path path = Path();
    path.moveTo(imgWidth * 0.5, 0);
    path.lineTo(0, imgHeight);
    path.lineTo(imgWidth, imgHeight);
    path.close();

    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.light
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.medium
          ..style = ui.PaintingStyle.stroke);

    ctx.restore();
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background
  void init() {
    if (frameVisible) {
      ui.Picture framePicture = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(framePicture);
    }

    drawHorizonBackgroundImage(valueContext);

    drawIndicatorImage(indicatorContext);

    drawHorizonForegroundImage(foregroundContext);

    if (foregroundVisible) {
      ui.Picture foregroundPicture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        false,
        KnobTypeEnum.STANDARD_KNOB,
        KnobStyleEnum.BLACK,
        GaugeTypeEnum.TYPE1,
        OrientationEnum.NORTH,
      );
      foregroundContext.drawPicture(foregroundPicture);
    }
  }

  void repaint() {
    init();

    canvas.save();

    ui.Picture picture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(picture);

    canvas.save();

    // Set the clipping area
    Path path = Path();
    Rect rect = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: (imageWidth * 0.831775),
        height: (imageWidth * 0.831775));
    path.addArc(rect, 0, TWO_PI);
    path.close();
    canvas.clipPath(path);

    // Rotate around roll
    canvas.translate(centerX, centerY);
    canvas.rotate(-(roll * RAD_FACTOR));
    canvas.translate(-centerX, 0);
    // Translate about dive
    canvas.translate(0, pitch * pitchPixel);

    double valueBufferHeight = size * PI;
    // Draw horizon
    canvas.save();
    canvas.translate(0, -valueBufferHeight / 2);
    picture = valueContextRecorder.endRecording();
    canvas.drawPicture(picture);
    canvas.translate(0, valueBufferHeight / 2);
    canvas.restore();

    // Draw the scale and angle indicator
    canvas.translate(0, -(pitch * pitchPixel) - centerY);

    double indicatorWidth = size * 0.037383;
    canvas.save();
    canvas.translate(
        imageWidth * 0.5 - indicatorWidth / 2, imageWidth * 0.107476);
    picture = indicatorContextRecorder.endRecording();
    canvas.drawPicture(picture);
    canvas.translate(
        -(imageWidth * 0.5 - indicatorWidth / 2), -imageWidth * 0.107476);
    canvas.restore();

    canvas.restore();

    picture = foregroundContextRecorder.endRecording();
    canvas.drawPicture(picture);

    canvas.restore();
  }

  // Visualize the component
  repaint();
}
