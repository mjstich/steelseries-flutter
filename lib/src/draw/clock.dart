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

void drawClock(Canvas canvas, Size canvasSize, Parameters parameters) {
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  PointerTypeEnum pointerType = parameters.pointerTypeWithDefault(PointerTypeEnum.TYPE1);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(pointerType == PointerTypeEnum.TYPE1 ? ColorEnum.GRAY : ColorEnum.BLACK);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(pointerType == PointerTypeEnum.TYPE1 ? BackgroundColorEnum.ANTHRACITE : BackgroundColorEnum.LIGHT_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  bool secondPointerVisible = parameters.secondPointerVisibleWithDefault(true);
  ui.Image? customLayer = parameters.customLayer;
  double absSeconds = parameters.value ?? 0;
  absSeconds = absSeconds.abs();
  int hour = absSeconds ~/ 3600;
  absSeconds -= hour * 3600;
  hour = hour % 12;
  int minute = absSeconds ~/ 60;
  absSeconds -= minute * 60;
  int second = absSeconds.toInt();

  // const secondMovesContinuous =
  //   undefined === parameters.secondMovesContinuous
  //     ? false
  //     : parameters.secondMovesContinuous

  double minutePointerAngle = 0;
  double hourPointerAngle = 0;
  double secondPointerAngle = 0;

  // Constants
  double ANGLE_STEP = 6;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  // Buffer for the frame
  var frameContextRecorder = ui.PictureRecorder();
  var frameContext = Canvas(frameContextRecorder);

  // Buffer for static background painting code
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // Buffer for hour pointer image painting code
  var hourContextRecorder = ui.PictureRecorder();
  var hourContext = Canvas(hourContextRecorder);

  // Buffer for minute pointer image painting code
  var minuteContextRecorder = ui.PictureRecorder();
  var minuteContext = Canvas(minuteContextRecorder);

  // Buffer for second pointer image painting code
  var secondContextRecorder = ui.PictureRecorder();
  var secondContext = Canvas(secondContextRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  void drawTickmarksImage(Canvas ctx, PointerTypeEnum ptrType) {
    double tickAngle;
    double SMALL_TICK_HEIGHT;
    double BIG_TICK_HEIGHT;
    double INNER_POINT;
    double OUTER_POINT = imageWidth * 0.405;
    ctx.save();
    ctx.translate(centerX, centerY);

    switch (ptrType) {
      case PointerTypeEnum.TYPE1:
        // Draw minutes tickmarks
        SMALL_TICK_HEIGHT = imageWidth * 0.074766;
        INNER_POINT = OUTER_POINT - SMALL_TICK_HEIGHT;
        Paint paint = Paint()
          ..color = backgroundColor.labelColor
          ..strokeWidth = imageWidth * 0.014018
          ..style = ui.PaintingStyle.stroke;

        for (tickAngle = 0; tickAngle < 360; tickAngle += 30) {
          Path path = Path();
          path.moveTo(OUTER_POINT, 0);
          path.lineTo(INNER_POINT, 0);
          path.close();
          ctx.drawPath(path, paint);
          ctx.rotate(30 * RAD_FACTOR);
        }

        // Draw hours tickmarks
        BIG_TICK_HEIGHT = imageWidth * 0.126168;
        INNER_POINT = OUTER_POINT - BIG_TICK_HEIGHT;
        paint.strokeWidth = imageWidth * 0.03271;

        for (tickAngle = 0; tickAngle < 360; tickAngle += 90) {
          Path path = Path();
          path.moveTo(OUTER_POINT, 0);
          path.lineTo(INNER_POINT, 0);
          path.close();
          ctx.drawPath(path, paint);
          ctx.rotate(90 * RAD_FACTOR);
        }
        break;

      case PointerTypeEnum.TYPE2:
      /* falls through */
      default:
        // Draw minutes tickmarks
        SMALL_TICK_HEIGHT = imageWidth * 0.037383;
        INNER_POINT = OUTER_POINT - SMALL_TICK_HEIGHT;
        Paint paint = Paint()
          ..color = backgroundColor.labelColor
          ..strokeWidth = imageWidth * 0.009345
          ..style = ui.PaintingStyle.stroke;

        for (tickAngle = 0; tickAngle < 360; tickAngle += 6) {
          Path path = Path();
          path.moveTo(OUTER_POINT, 0);
          path.lineTo(INNER_POINT, 0);
          path.close();
          ctx.drawPath(path, paint);
          ctx.rotate(6 * RAD_FACTOR);
        }

        // Draw hours tickmarks
        BIG_TICK_HEIGHT = imageWidth * 0.084112;
        INNER_POINT = OUTER_POINT - BIG_TICK_HEIGHT;
        paint.strokeWidth = imageWidth * 0.028037;

        for (tickAngle = 0; tickAngle < 360; tickAngle += 30) {
          Path path = Path();
          path.moveTo(OUTER_POINT, 0);
          path.lineTo(INNER_POINT, 0);
          path.close();
          ctx.drawPath(path, paint);
          ctx.rotate(30 * RAD_FACTOR);
        }
        break;
    }
    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  void drawHourPointer(Canvas ctx, PointerTypeEnum ptrType) {
    ctx.save();

    switch (ptrType) {
      case PointerTypeEnum.TYPE2:
        Path path = Path();
        Paint paint = Paint()
          ..color = pointerColor.medium
          ..strokeWidth = imageWidth * 0.046728
          ..style = ui.PaintingStyle.stroke;
        path.moveTo(centerX, imageWidth * 0.289719);
        path.lineTo(centerX, imageWidth * 0.289719 + imageWidth * 0.224299);
        path.close();
        ctx.drawPath(path, paint);
        break;

      case PointerTypeEnum.TYPE1:
      /* falls through */
      default:
        Path path = Path();
        path.moveTo(imageWidth * 0.471962, imageHeight * 0.560747);
        path.lineTo(imageWidth * 0.471962, imageHeight * 0.214953);
        path.lineTo(imageWidth * 0.5, imageHeight * 0.182242);
        path.lineTo(imageWidth * 0.528037, imageHeight * 0.214953);
        path.lineTo(imageWidth * 0.528037, imageHeight * 0.560747);
        path.lineTo(imageWidth * 0.471962, imageHeight * 0.560747);
        path.close();
        ui.Gradient grad = ui.Gradient.linear(
          Offset(imageWidth * 0.471962, imageHeight * 0.560747),
          Offset(imageWidth * 0.528037, imageHeight * 0.214953),
          [
            pointerColor.veryLight,
            pointerColor.light,
          ],
          [0, 1],
        );
        ctx.drawPath(
            path,
            Paint()
              ..shader = grad
              ..style = ui.PaintingStyle.fill);
        ctx.drawPath(
            path,
            Paint()
              ..color = pointerColor.light
              ..style = ui.PaintingStyle.stroke);
        break;
    }
    ctx.restore();
  }

  void drawMinutePointer(Canvas ctx, PointerTypeEnum ptrType) {
    ctx.save();

    switch (ptrType) {
      case PointerTypeEnum.TYPE2:
        Path path = Path();
        path.moveTo(centerX, imageWidth * 0.116822);
        path.lineTo(centerX, imageWidth * 0.116822 + imageWidth * 0.38785);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = pointerColor.medium
              ..strokeWidth = imageWidth * 0.03271
              ..style = ui.PaintingStyle.stroke);
        break;

      case PointerTypeEnum.TYPE1:
      /* falls through */
      default:
        Path path = Path();
        path.moveTo(imageWidth * 0.518691, imageHeight * 0.574766);
        path.lineTo(imageWidth * 0.523364, imageHeight * 0.135514);
        path.lineTo(imageWidth * 0.5, imageHeight * 0.107476);
        path.lineTo(imageWidth * 0.476635, imageHeight * 0.140186);
        path.lineTo(imageWidth * 0.476635, imageHeight * 0.574766);
        path.lineTo(imageWidth * 0.518691, imageHeight * 0.574766);
        path.close();
        ui.Gradient grad = ui.Gradient.linear(
          Offset(imageWidth * 0.518691, imageHeight * 0.574766),
          Offset(imageWidth * 0.476635, imageHeight * 0.140186),
          [
            pointerColor.veryLight,
            pointerColor.light,
          ],
          [0, 1],
        );
        ctx.drawPath(
            path,
            Paint()
              ..shader = grad
              ..style = ui.PaintingStyle.fill);
        ctx.drawPath(
            path,
            Paint()
              ..color = pointerColor.light
              ..style = ui.PaintingStyle.stroke);
        break;
    }
    ctx.restore();
  }

  void drawSecondPointer(Canvas ctx, PointerTypeEnum ptrType) {
    ctx.save();

    switch (ptrType) {
      case PointerTypeEnum.TYPE2:
        // top rectangle
        Paint paint = Paint()
          ..color = ColorEnum.RED.dark
          ..strokeWidth = imageWidth * 0.009345
          ..style = ui.PaintingStyle.stroke;
        Path path = Path();
        path.moveTo(centerX, imageWidth * 0.09813);
        path.lineTo(centerX, imageWidth * 0.09813 + imageWidth * 0.126168);
        path.close();
        ctx.drawPath(path, paint);

        // bottom rectangle
        paint.strokeWidth = imageWidth * 0.018691;
        path = Path();
        path.moveTo(centerX, imageWidth * 0.308411);
        path.lineTo(centerX, imageWidth * 0.308411 + imageWidth * 0.191588);
        path.close();
        ctx.drawPath(path, paint);
        // circle
        paint.strokeWidth = imageWidth * 0.016;
        path = Path();
        Rect rect = Rect.fromCenter(center: Offset(centerX, imageWidth * 0.26), width: (imageWidth * 0.085), height: (imageWidth * 0.085));
        path.addArc(rect, 0, TWO_PI);
        path.close();
        ctx.drawPath(path, paint);
        break;

      case PointerTypeEnum.TYPE1:
      /* falls through */
      default:
        Path path = Path();
        path.moveTo(imageWidth * 0.509345, imageHeight * 0.116822);
        path.lineTo(imageWidth * 0.509345, imageHeight * 0.574766);
        path.lineTo(imageWidth * 0.490654, imageHeight * 0.574766);
        path.lineTo(imageWidth * 0.490654, imageHeight * 0.116822);
        path.lineTo(imageWidth * 0.509345, imageHeight * 0.116822);
        path.close();
        ui.Gradient grad = ui.Gradient.linear(
          Offset(imageWidth * 0.509345, imageHeight * 0.116822),
          Offset(imageWidth * 0.490654, imageHeight * 0.574766),
          [
            ColorEnum.RED.light,
            ColorEnum.RED.medium,
            ColorEnum.RED.dark,
          ],
          [0, 0.47, 1],
        );

        ctx.drawPath(
            path,
            Paint()
              ..shader = grad
              ..style = ui.PaintingStyle.fill);
        ctx.drawPath(
            path,
            Paint()
              ..color = ColorEnum.RED.dark
              ..style = ui.PaintingStyle.stroke);
        break;
    }
    ctx.restore();
  }

  void drawKnob(Canvas ctx) {
    // draw the knob
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(centerX, centerX), width: imageWidth * 0.045 * 2, height: imageWidth * 0.045 * 2);
    path.addArc(rect, 0, TWO_PI);
    path.close();
    ui.Gradient grad = ui.Gradient.linear(
      Offset(centerX - (imageWidth * 0.045) / 2, centerY - (imageWidth * 0.045) / 2),
      Offset(centerX + (imageWidth * 0.045) / 2, centerY + (imageWidth * 0.045) / 2),
      [
        colorFromHex('#eef0f2'),
        colorFromHex('#65696d'),
      ],
      [0, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
  }

  void drawTopKnob(Canvas ctx, PointerTypeEnum ptrType) {
    ctx.save();

    switch (ptrType) {
      case PointerTypeEnum.TYPE2:
        // draw knob
        Path path = Path();
        Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: (imageWidth * 0.088785), height: (imageWidth * 0.088785));
        path.addArc(rect, 0, TWO_PI);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = colorFromHex('#000000')
              ..style = ui.PaintingStyle.fill);
        break;

      case PointerTypeEnum.TYPE1:
      /* falls through */
      default:
        // draw knob
        ui.Gradient grad = ui.Gradient.linear(
          Offset(centerX - (imageWidth * 0.027) / 2, centerY - (imageWidth * 0.027) / 2),
          Offset(centerX + (imageWidth * 0.027) / 2, centerY + (imageWidth * 0.027) / 2),
          [
            colorFromHex('#f3f4f7'),
            colorFromHex('#f3f5f7'),
            colorFromHex('#f1f3f5'),
            colorFromHex('#c0c5cb'),
            colorFromHex('#bec3c9'),
            colorFromHex('#bec3c9'),
          ],
          [0, 0.11, 0.12, 0.2, 0.2, 1],
        );
        Path path = Path();
        Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: imageWidth * 0.027 * 2, height: imageWidth * 0.027 * 2);
        path.addArc(rect, 0, TWO_PI);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = grad
              ..style = ui.PaintingStyle.fill);
        break;
    }

    ctx.restore();
  }

  void calculateAngles(double hour, double minute, double second) {
    secondPointerAngle = second * ANGLE_STEP * RAD_FACTOR;
    minutePointerAngle = minute * ANGLE_STEP * RAD_FACTOR;
    hourPointerAngle = (hour + minute / 60) * ANGLE_STEP * 5 * RAD_FACTOR;
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background
  void init(dynamic parameters) {
    bool drawFrame2 = parameters['frame'] == null ? false : parameters['frame'] as bool;
    bool drawBackground2 = parameters['background'] == null ? false : parameters['background'] as bool;
    bool drawPointers = parameters['pointers'] == null ? false : parameters['pointers'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;

    if (drawFrame2 && frameVisible) {
      ui.Picture framePicture = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      frameContext.drawPicture(framePicture);
    }

    if (drawBackground2 && backgroundVisible) {
      // Create background in background buffer (backgroundBuffer)
      ui.Picture backgroundPicture = drawBackground(
        backgroundColor,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(backgroundPicture);

      // Create custom layer in background buffer (backgroundBuffer)
      drawRadialCustomImage(
        backgroundContext,
        customLayer,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );

      drawTickmarksImage(backgroundContext, pointerType);
    }

    if (drawPointers) {
      drawHourPointer(hourContext, pointerType);
      drawMinutePointer(minuteContext, pointerType);
      drawSecondPointer(secondContext, pointerType);
    }

    if (drawForeground2 && foregroundVisible) {
      drawTopKnob(foregroundContext, pointerType);
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
    init({'frame': true, 'background': true, 'pointers': true, 'foreground': true});

    // Draw frame
    if (frameVisible) {
      ui.Picture picture = frameContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw buffered image to visible canvas
    if (backgroundVisible) {
      ui.Picture picture = backgroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // have to draw to a rotated temporary image area so we can translate in
    // absolute x, y values when drawing to main context
    double shadowOffset = imageWidth * 0.006;

    // draw hour pointer
    // Define rotation center
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(hourPointerAngle);
    canvas.translate(-centerX, -centerY);
    // Set the pointer shadow params
    // mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    // mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
    // mainCtx.shadowBlur = shadowOffset * 2
    // Draw the pointer
    ui.Picture picture = hourContextRecorder.endRecording();
    canvas.drawPicture(picture);

    // draw minute pointer
    // Define rotation center
    canvas.translate(centerX, centerY);
    canvas.rotate(minutePointerAngle - hourPointerAngle);
    canvas.translate(-centerX, -centerY);
    picture = minuteContextRecorder.endRecording();
    canvas.drawPicture(picture);
    canvas.restore();

    if (pointerType == PointerTypeEnum.TYPE1) {
      drawKnob(canvas);
    }

    if (secondPointerVisible) {
      // draw second pointer
      // Define rotation center
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(secondPointerAngle);
      canvas.translate(-centerX, -centerY);
      // Set the pointer shadow params
      // mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
      // mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
      // mainCtx.shadowBlur = shadowOffset * 2
      // Draw the pointer
      picture = secondContextRecorder.endRecording();
      canvas.drawPicture(picture);
      canvas.restore();
    }

    // Draw foreground
    if (foregroundVisible) {
      picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  void tickTock() {
    hour = hour % 12;
    minute = minute % 60;
    second = second % 60;
    // Calculate angles from current hour and minute values
    calculateAngles(hour.toDouble(), minute.toDouble(), second.toDouble());

    repaint();
  }

  // Visualize the component
  tickTock();
}
