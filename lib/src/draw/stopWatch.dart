// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'drawRadialCustomImage.dart';
import 'tools.dart';

void drawStopwatch(Canvas canvas, Size canvasSize, Parameters parameters) {
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.BLACK_METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(BackgroundColorEnum.LIGHT_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(ColorEnum.BLACK);
  ui.Image? customLayer = parameters.customLayer;
  double seconds = parameters.seccondsWithDefault(0);
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));

  double ANGLE_STEP = 6;

  double minutePointerAngle = 0;
  double secondPointerAngle = 0;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  double smallPointerSize = 0.285 * imageWidth;
  double smallPointerX_Offset = centerX - smallPointerSize / 2;
  double smallPointerY_Offset = 0.17 * imageWidth;

  // Buffer for the frame
  var frameContextRecorder = ui.PictureRecorder();
  var frameContext = Canvas(frameContextRecorder);

  // Buffer for static background painting code
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // Buffer for small pointer image painting code
  var smallPointerContextRecorder = ui.PictureRecorder();
  var smallPointerContext = Canvas(smallPointerContextRecorder);

  // Buffer for large pointer image painting code
  var largePointerContextRecorder = ui.PictureRecorder();
  var largePointerContext = Canvas(largePointerContextRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  void drawTickmarksImage(Canvas ctx, double width, double range, double text_scale, double text_dist_factor, double x_offset, double y_offset) {
    double STD_FONT_SIZE = text_scale * width;
    //double STD_FONT = STD_FONT_SIZE + 'px ' + stdFontName;
    double TEXT_WIDTH = width * 0.25;
    double THIN_STROKE = 0.5;
    double MEDIUM_STROKE = 1;
    double THICK_STROKE = 1.5;
    double TEXT_DISTANCE = text_dist_factor * width;
    double MIN_LENGTH = (0.025 * width).roundToDouble();
    double MED_LENGTH = (0.035 * width).roundToDouble();
    double MAX_LENGTH = (0.045 * width).roundToDouble();
    Color TEXT_COLOR = backgroundColor.labelColor;
    Color TICK_COLOR = backgroundColor.labelColor;
    double CENTER = width / 2;
    // Create the ticks itself
    double RADIUS = width * 0.4;
    List<double> innerPoint;
    List<double> outerPoint;
    List<double> textPoint;
    int counter = 0;
    int numberCounter = 0;
    double valueCounter; // value for the tickmarks
    double sinValue = 0;
    double cosValue = 0;
    double alpha; // angle for the tickmarks
    double ALPHA_START = -PI;
    double ANGLE_STEPSIZE = TWO_PI / range;

    ctx.save();

    alpha = ALPHA_START;
    valueCounter = 0;
    for (; valueCounter <= range + 1; alpha -= ANGLE_STEPSIZE * 0.1, valueCounter += 0.1) {
      //     ctx.lineWidth = THIN_STROKE
      sinValue = math.sin(alpha);
      cosValue = math.cos(alpha);

      // tickmark every 2 units
      if (counter % 2 == 0) {
        // ctx.lineWidth = THIN_STROKE;
        innerPoint = [CENTER + (RADIUS - MIN_LENGTH) * sinValue + x_offset, CENTER + (RADIUS - MIN_LENGTH) * cosValue + y_offset];
        outerPoint = [CENTER + RADIUS * sinValue + x_offset, CENTER + RADIUS * cosValue + y_offset];
        // Draw ticks
        Path path = Path();
        path.moveTo(innerPoint[0], innerPoint[1]);
        path.lineTo(outerPoint[0], outerPoint[1]);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = TICK_COLOR
              ..strokeWidth = THIN_STROKE
              ..style = ui.PaintingStyle.stroke);
      }

      // Different tickmark every 10 units
      if (counter == 10 || counter == 0) {
        double lineWidth = MEDIUM_STROKE;
        outerPoint = [CENTER + RADIUS * sinValue + x_offset, CENTER + RADIUS * cosValue + y_offset];
        textPoint = [CENTER + (RADIUS - TEXT_DISTANCE) * sinValue + x_offset, CENTER + (RADIUS - TEXT_DISTANCE) * cosValue + y_offset];

        // Draw text
        if (numberCounter == 5) {
          if (valueCounter != range) {
            if (valueCounter.round() != 60) {
              TextStyle font = getFont(STD_FONT_SIZE, TEXT_COLOR);
              var textSpan = TextSpan(
                text: valueCounter.round().toString(),
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
                maxWidth: TEXT_WIDTH,
              );
              textPainter.paint(ctx, Offset(textPoint[0] - textPainter.size.width / 2, textPoint[1] - textPainter.size.height / 2));
            }
          }
          lineWidth = THICK_STROKE;
          innerPoint = [CENTER + (RADIUS - MAX_LENGTH) * sinValue + x_offset, CENTER + (RADIUS - MAX_LENGTH) * cosValue + y_offset];
          numberCounter = 0;
        } else {
          lineWidth = MEDIUM_STROKE;
          innerPoint = [CENTER + (RADIUS - MED_LENGTH) * sinValue + x_offset, CENTER + (RADIUS - MED_LENGTH) * cosValue + y_offset];
        }

        // Draw ticks

        Path path = Path();
        path.moveTo(innerPoint[0], innerPoint[1]);
        path.lineTo(outerPoint[0], outerPoint[1]);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = TICK_COLOR
              ..strokeWidth = lineWidth
              ..style = ui.PaintingStyle.stroke);

        counter = 0;
        numberCounter++;
      }
      counter++;
    }
    ctx.restore();
  }

  void drawLargePointer(Canvas ctx) {
    ui.Gradient grad;
    double radius;

    ctx.save();
    Path path = Path();
    path.moveTo(imageWidth * 0.509345, imageWidth * 0.457943);
    path.lineTo(imageWidth * 0.5, imageWidth * 0.102803);
    path.lineTo(imageWidth * 0.490654, imageWidth * 0.457943);
    path.cubicTo(
      imageWidth * 0.490654,
      imageWidth * 0.457943,
      imageWidth * 0.490654,
      imageWidth * 0.457943,
      imageWidth * 0.490654,
      imageWidth * 0.457943,
    );
    path.cubicTo(
      imageWidth * 0.471962,
      imageWidth * 0.462616,
      imageWidth * 0.457943,
      imageWidth * 0.481308,
      imageWidth * 0.457943,
      imageWidth * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.457943,
      imageWidth * 0.518691,
      imageWidth * 0.471962,
      imageWidth * 0.537383,
      imageWidth * 0.490654,
      imageWidth * 0.542056,
    );
    path.cubicTo(
      imageWidth * 0.490654,
      imageWidth * 0.542056,
      imageWidth * 0.490654,
      imageWidth * 0.542056,
      imageWidth * 0.490654,
      imageWidth * 0.542056,
    );
    path.lineTo(imageWidth * 0.490654, imageWidth * 0.621495);
    path.lineTo(imageWidth * 0.509345, imageWidth * 0.621495);
    path.lineTo(imageWidth * 0.509345, imageWidth * 0.542056);
    path.cubicTo(
      imageWidth * 0.509345,
      imageWidth * 0.542056,
      imageWidth * 0.509345,
      imageWidth * 0.542056,
      imageWidth * 0.509345,
      imageWidth * 0.542056,
    );
    path.cubicTo(
      imageWidth * 0.528037,
      imageWidth * 0.537383,
      imageWidth * 0.542056,
      imageWidth * 0.518691,
      imageWidth * 0.542056,
      imageWidth * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.542056,
      imageWidth * 0.481308,
      imageWidth * 0.528037,
      imageWidth * 0.462616,
      imageWidth * 0.509345,
      imageWidth * 0.457943,
    );
    path.cubicTo(
      imageWidth * 0.509345,
      imageWidth * 0.457943,
      imageWidth * 0.509345,
      imageWidth * 0.457943,
      imageWidth * 0.509345,
      imageWidth * 0.457943,
    );
    path.close();

    grad = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, imageWidth * 0.621495),
      [
        pointerColor.medium,
        pointerColor.medium,
        pointerColor.light,
        pointerColor.medium,
        pointerColor.medium,
      ],
      [0, 0.388888, 0.5, 0.611111, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.dark
          ..style = ui.PaintingStyle.stroke);

    // Draw the rings
    path = Path();
    radius = (imageWidth * 0.06542) / 2;
    Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: radius * 2, height: radius * 2);
    path.addArc(rect, 0, TWO_PI);
    path.close();

    grad = ui.Gradient.linear(
      Offset(centerX - radius, centerX + radius),
      Offset(0, centerY + radius),
      [
        colorFromHex('#e6b35c'),
        colorFromHex('#e6b35c'),
        colorFromHex('#c48200'),
        colorFromHex('#c48200'),
      ],
      [0, 0.01, 0.99, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    path = Path();
    radius = (imageWidth * 0.046728) / 2;
    rect = Rect.fromCenter(center: Offset(centerX, centerY), width: radius * 2, height: radius * 2);
    path.addArc(rect, 0, TWO_PI);
    path.close();
    grad = ui.Gradient.radial(
      Offset(centerX, centerY),
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
      Offset(centerX, centerY),
      radius,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    ctx.restore();
  }

  void drawSmallPointer(Canvas ctx) {
    double radius;

    ctx.save();
    Path path = Path();
    path.moveTo(imageWidth * 0.476635, imageWidth * 0.313084);
    path.cubicTo(
      imageWidth * 0.476635,
      imageWidth * 0.322429,
      imageWidth * 0.485981,
      imageWidth * 0.331775,
      imageWidth * 0.495327,
      imageWidth * 0.336448,
    );
    path.cubicTo(
      imageWidth * 0.495327,
      imageWidth * 0.336448,
      imageWidth * 0.495327,
      imageWidth * 0.350467,
      imageWidth * 0.495327,
      imageWidth * 0.350467,
    );
    path.lineTo(imageWidth * 0.504672, imageWidth * 0.350467);
    path.cubicTo(
      imageWidth * 0.504672,
      imageWidth * 0.350467,
      imageWidth * 0.504672,
      imageWidth * 0.336448,
      imageWidth * 0.504672,
      imageWidth * 0.336448,
    );
    path.cubicTo(
      imageWidth * 0.514018,
      imageWidth * 0.331775,
      imageWidth * 0.523364,
      imageWidth * 0.322429,
      imageWidth * 0.523364,
      imageWidth * 0.313084,
    );
    path.cubicTo(
      imageWidth * 0.523364,
      imageWidth * 0.303738,
      imageWidth * 0.514018,
      imageWidth * 0.294392,
      imageWidth * 0.504672,
      imageWidth * 0.289719,
    );
    path.cubicTo(
      imageWidth * 0.504672,
      imageWidth * 0.289719,
      imageWidth * 0.5,
      imageWidth * 0.200934,
      imageWidth * 0.5,
      imageWidth * 0.200934,
    );
    path.cubicTo(
      imageWidth * 0.5,
      imageWidth * 0.200934,
      imageWidth * 0.495327,
      imageWidth * 0.289719,
      imageWidth * 0.495327,
      imageWidth * 0.289719,
    );
    path.cubicTo(
      imageWidth * 0.485981,
      imageWidth * 0.294392,
      imageWidth * 0.476635,
      imageWidth * 0.303738,
      imageWidth * 0.476635,
      imageWidth * 0.313084,
    );
    path.close();

    ui.Gradient grad = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(imageWidth, 0),
      [
        pointerColor.medium,
        pointerColor.medium,
        pointerColor.light,
        pointerColor.medium,
        pointerColor.medium,
      ],
      [0, 0.388888, 0.5, 0.611111, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = pointerColor.dark
          ..style = ui.PaintingStyle.stroke);

    // Draw the rings
    path = Path();
    radius = (imageWidth * 0.037383) / 2;
    Rect rect = Rect.fromCenter(center: Offset(centerX, smallPointerY_Offset + smallPointerSize / 2), width: radius * 2, height: radius * 2);
    path.addArc(rect, 0, TWO_PI);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#C48200')
          ..style = ui.PaintingStyle.fill);

    path = Path();
    radius = (imageWidth * 0.028037) / 2;
    rect = Rect.fromCenter(center: Offset(centerX, smallPointerY_Offset + smallPointerSize / 2), width: radius * 2, height: radius * 2);
    path.addArc(rect, 0, TWO_PI);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#999999')
          ..style = ui.PaintingStyle.fill);

    path = Path();
    radius = (imageWidth * 0.018691) / 2;
    rect = Rect.fromCenter(center: Offset(centerX, smallPointerY_Offset + smallPointerSize / 2), width: radius * 2, height: radius * 2);
    path.addArc(rect, 0, TWO_PI);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#000000')
          ..style = ui.PaintingStyle.fill);

    ctx.restore();
  }

  void calculateAngles() {
    secondPointerAngle = seconds * ANGLE_STEP;
    minutePointerAngle = (seconds / 60) * ANGLE_STEP * 2;
  }

  void init(dynamic parameters) {
    bool drawFrame2 = parameters['frame'] == null ? false : parameters['frame'] as bool;
    bool drawBackground2 = parameters['background'] == null ? false : parameters['background'] as bool;
    bool drawPointers = parameters['pointers'] == null ? false : parameters['pointers'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;

    if (drawFrame2 && frameVisible) {
      ui.Picture picture = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      frameContext.drawPicture(picture);
    }

    if (drawBackground2 && backgroundVisible) {
      // Create background in background buffer (backgroundBuffer)
      ui.Picture picture = drawBackground(
        backgroundColor,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(picture);

      // Create custom layer in background buffer (backgroundBuffer)
      drawRadialCustomImage(
        backgroundContext,
        customLayer,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );

      drawTickmarksImage(
        backgroundContext,
        imageWidth,
        60,
        0.075,
        0.1,
        0,
        0,
      );
      drawTickmarksImage(
        backgroundContext,
        smallPointerSize,
        30,
        0.095,
        0.13,
        smallPointerX_Offset,
        smallPointerY_Offset,
      );
    }
    if (drawPointers) {
      drawLargePointer(largePointerContext);
      drawSmallPointer(smallPointerContext);
    }

    if (drawForeground2 && foregroundVisible) {
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
    init({
      'frame': true,
      'background': true,
      'pointers': true,
      'foreground': true,
    });

    ui.Picture picture;

    // Draw frame
    if (frameVisible) {
      picture = frameContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw buffered image to visible canvas
    if (backgroundVisible) {
      picture = backgroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // have to draw to a rotated temporary image area so we can translate in
    // absolute x, y values when drawing to main context
    //double shadowOffset = imageWidth * 0.006;

    double rotationAngle = (minutePointerAngle + -0.03 * math.sin(minutePointerAngle * RAD_FACTOR)) * RAD_FACTOR;
    double secRotationAngle = (secondPointerAngle + -0.03 * math.sin(secondPointerAngle * math.pi / 180.0)) * math.pi / 180.0;

    // Draw the minute pointer
    // Define rotation center
    canvas.save();
    canvas.translate(centerX, smallPointerY_Offset + smallPointerSize / 2);
    canvas.rotate(rotationAngle);
    canvas.translate(-centerX, -(smallPointerY_Offset + smallPointerSize / 2));
    // Set the pointer shadow params
    // mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    // mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset / 2
    // mainCtx.shadowBlur = shadowOffset
    // Draw the pointer
    picture = smallPointerContextRecorder.endRecording();
    canvas.drawPicture(picture);
    canvas.restore();

    // Draw the second pointer
    // Define rotation center
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(secRotationAngle);
    canvas.translate(-centerX, -centerY);
    // Set the pointer shadow params
    // mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    // mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset / 2
    // mainCtx.shadowBlur = shadowOffset
    // Draw the pointer
    picture = largePointerContextRecorder.endRecording();
    canvas.drawPicture(picture);
    // Undo the translations & shadow settings
    canvas.restore();

    // Draw the foreground
    if (foregroundVisible) {
      picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  // Visualize the component
  calculateAngles();
  repaint();
}
