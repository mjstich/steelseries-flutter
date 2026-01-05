// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'createKnobImage.dart';
import 'createLedImage.dart';
import 'createMeasuredValueImage.dart';
import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'drawPointerImage.dart';
import 'tools.dart';

void drawRadialVertical(Canvas canvas, Size canvasSize, Parameters parameters) {
  OrientationEnum orientation = parameters.orientationWithDefault(OrientationEnum.NORTH);
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  double minValue = parameters.minValueWithDefault(0);
  double maxValue = parameters.maxValueWithDefault(100);
  bool niceScale = parameters.niceScaleWithDefault(true);
  double threshold = parameters.thresholdWithDefault((maxValue - minValue) / 2 + minValue);
  List<Section>? section = parameters.section;
  List<Section>? area = parameters.area;
  String titleString = parameters.titleStringWithDefault('');
  String unitString = parameters.unitStringWithDefault('');
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(BackgroundColorEnum.DARK_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  PointerTypeEnum pointerType = parameters.pointerTypeWithDefault(PointerTypeEnum.TYPE1);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(ColorEnum.RED);
  KnobTypeEnum knobType = parameters.knobTypeWithDefault(KnobTypeEnum.STANDARD_KNOB);
  KnobStyleEnum knobStyle = parameters.knobStyleWithDefault(KnobStyleEnum.SILVER);
  LedColorEnum ledColor = parameters.ledColorWithDefault(LedColorEnum.RED_LED);
  bool ledVisible = parameters.ledVisibleWithDefault(false);
  bool ledOn = parameters.ledOnWithDefault(false);
  bool thresholdVisible = parameters.thresholdVisibleWithDefault(true);
  bool minMeasuredValueVisible = parameters.minMeasuredValueVisibleWithDefault(false);
  bool maxMeasuredValueVisible = parameters.maxMeasuredValueVisibleWithDefault(false);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  LabelNumberFormatEnum labelNumberFormat = parameters.labelNumberFormatWithDefault(LabelNumberFormatEnum.STANDARD);

  GaugeTypeEnum gaugeType = GaugeTypeEnum.TYPE5;

  double value = parameters.value ?? minValue;

  // Properties
  double minMeasuredValue = parameters.minMeasuredValueWithDefault(minValue);
  double maxMeasuredValue = parameters.maxMeasuredValueWithDefault(maxValue);
  double imageWidth = size;
  double imageHeight = size;

  // Tickmark specific private variables
  double niceMinValue = minValue;
  double niceMaxValue = maxValue;
  double niceRange = maxValue - minValue;
  double range = niceMaxValue - niceMinValue;
  double minorTickSpacing = 0;
  double majorTickSpacing = 0;
  double maxNoOfMinorTicks = 10;
  double maxNoOfMajorTicks = 10;

  double rotationOffset = 1.25 * PI;
  double angleRange = HALF_PI;
  double angleStep = angleRange / range;
  //double shadowOffset = imageWidth * 0.006;
  double pointerOffset = (imageWidth * 1.17) / 2;

  double angle = rotationOffset + (value - minValue) * angleStep;

  double centerX = imageWidth / 2;
  double centerY = imageHeight * 0.733644;

  // Misc
  double ledPosX = 0.455 * imageWidth;
  double ledPosY = 0.54 * imageHeight;

  if (maxValue > 100) {
    maxNoOfMajorTicks = 5;
  }

  // Method to calculate nice values for min, max and range for the tickmarks
  void calculate() {
    if (niceScale) {
      niceRange = calcNiceNumber(maxValue - minValue, false);
      majorTickSpacing = calcNiceNumber(
        niceRange / (maxNoOfMajorTicks - 1),
        true,
      );
      niceMinValue = (minValue / majorTickSpacing).floorToDouble() * majorTickSpacing;
      niceMaxValue = (maxValue / majorTickSpacing).ceilToDouble() * majorTickSpacing;
      minorTickSpacing = calcNiceNumber(
        majorTickSpacing / (maxNoOfMinorTicks - 1),
        true,
      );
      minValue = niceMinValue;
      maxValue = niceMaxValue;
      range = maxValue - minValue;
    } else {
      niceRange = maxValue - minValue;
      niceMinValue = minValue;
      niceMaxValue = maxValue;
      range = niceRange;
      minorTickSpacing = 1;
      majorTickSpacing = 10;
    }
    // Make sure values are still in range
    value = value < minValue
        ? minValue
        : value > maxValue
            ? maxValue
            : value;
    minMeasuredValue = minMeasuredValue < minValue
        ? minValue
        : minMeasuredValue > maxValue
            ? maxValue
            : minMeasuredValue;
    maxMeasuredValue = maxMeasuredValue < minValue
        ? minValue
        : maxMeasuredValue > maxValue
            ? maxValue
            : maxMeasuredValue;
    threshold = threshold < minValue
        ? minValue
        : threshold > maxValue
            ? maxValue
            : threshold;

    rotationOffset = 1.25 * PI;
    angleRange = HALF_PI;
    angleStep = angleRange / range;

    angle = rotationOffset + (value - minValue) * angleStep;
  }

  // **************   Buffer creation  ********************
  // Buffer for the frame
  var frameContextRecorder = ui.PictureRecorder();
  var frameContext = Canvas(frameContextRecorder);

  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // Buffer for led on painting code
  var ledBufferOnRecorder = ui.PictureRecorder();
  var ledContextOn = Canvas(ledBufferOnRecorder);

  // Buffer for led off painting code
  var ledBufferOffRecorder = ui.PictureRecorder();
  var ledContextOff = Canvas(ledBufferOffRecorder);

  // // Buffer for current led painting code
  // const ledBuffer = ledBufferOff

  // Buffer for the minMeasuredValue indicator
  var minMeasuredValueBufferRecorder = ui.PictureRecorder();
  var minMeasuredValueCtx = Canvas(minMeasuredValueBufferRecorder);

  // Buffer for the maxMeasuredValue indicator
  var maxMeasuredValueBufferRecorder = ui.PictureRecorder();
  var maxMeasuredValueCtx = Canvas(maxMeasuredValueBufferRecorder);

  // Buffer for pointer image painting code
  var pointerContextRecorder = ui.PictureRecorder();
  var pointerContext = Canvas(pointerContextRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  // **************   Image creation  ********************
  void drawPostsImage(Canvas ctx) {
    if (gaugeType == GaugeTypeEnum.TYPE5) {
      ctx.save();
      if (orientation == OrientationEnum.WEST) {
        // Min post
        ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
        ctx.save();
        ctx.translate(imageWidth * 0.44, imageHeight * 0.8);
        ctx.drawPicture(knobImage);
        ctx.translate(-imageWidth * 0.44, -imageHeight * 0.8);
        ctx.restore();

        // Max post
        knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
        ctx.save();
        ctx.translate(imageWidth * 0.44, imageHeight * 0.16);
        ctx.drawPicture(knobImage);
        ctx.translate(-imageWidth * 0.44, -imageHeight * 0.16);
        ctx.restore();
      } else if (orientation == OrientationEnum.EAST) {
        // Min post
        ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
        ctx.save();
        ctx.translate(imageWidth * 0.52, imageHeight * 0.8);
        ctx.drawPicture(knobImage);
        ctx.translate(-imageWidth * 0.52, -imageHeight * 0.8);
        ctx.restore();

        // Max post
        knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
        ctx.save();
        ctx.translate(imageWidth * 0.52, imageHeight * 0.16);
        ctx.drawPicture(knobImage);
        ctx.translate(-imageWidth * 0.52, -imageHeight * 0.16);
        ctx.restore();
      } else {
        // Min post
        ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
        ctx.save();
        ctx.translate(imageWidth * 0.2 - imageHeight * 0.037383, imageHeight * 0.446666);
        ctx.drawPicture(knobImage);
        ctx.translate(-(imageWidth * 0.2 - imageHeight * 0.037383), -imageHeight * 0.446666);
        ctx.restore();

        // Max post
        knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
        ctx.save();
        ctx.translate(imageWidth * 0.8, imageHeight * 0.446666);
        ctx.drawPicture(knobImage);
        ctx.translate(-imageWidth * 0.8, -imageHeight * 0.446666);
        ctx.restore();
      }
      ctx.restore();
    }
  }

  ui.Picture createThresholdImage() {
    var thresholdCtxtRecorder = ui.PictureRecorder();
    var thresholdCtx = Canvas(thresholdCtxtRecorder);

    double width = (size * 0.046728).ceilToDouble();
    double height = (width * 0.9).ceilToDouble();

    thresholdCtx.save();
    ui.Gradient grad = ui.Gradient.linear(
      const Offset(0, 0.1),
      Offset(0, height * 0.9),
      [
        colorFromHex('#520000'),
        colorFromHex('#fc1d00'),
        colorFromHex('#fc1d00'),
        colorFromHex('#520000'),
      ],
      [0, 0.3, 0.59, 1],
    );

    Path path = Path();
    path.moveTo(width * 0.5, 0.1);
    path.lineTo(width * 0.9, height * 0.9);
    path.lineTo(width * 0.1, height * 0.9);
    path.lineTo(width * 0.5, 0.1);
    path.close();

    thresholdCtx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
    thresholdCtx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#FFFFFF')
          ..style = ui.PaintingStyle.stroke);

    thresholdCtx.restore();

    return thresholdCtxtRecorder.endRecording();
  }

  void drawAreaSectionImage(Canvas ctx, double start, double stop, Color color, bool filled) {
    ctx.save();
    double lineWidth = imageWidth * 0.035;
    Paint strokePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = ui.PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = ui.PaintingStyle.fill;
    double startAngle = (angleRange / range) * start - (angleRange / range) * minValue;
    double stopAngle = startAngle + (stop - start) / (range / angleRange);
    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset);
    Path path = Path();
    if (filled) {
      path.moveTo(0, 0);
      double width = (imageWidth * 0.365 - lineWidth / 2) * 2;
      Rect rect = Rect.fromCenter(center: const Offset(0, 0), width: width, height: width);
      path.addArc(rect, startAngle, (stopAngle - startAngle));
      path.lineTo(0, 0);
      path.close();
    } else {
      double width = (imageWidth * 0.365) * 2;
      Rect rect = Rect.fromCenter(center: const Offset(0, 0), width: width, height: width);
      path.addArc(rect, startAngle, (stopAngle - startAngle));
      //ctx.arc(0, 0, imageWidth * 0.365, startAngle, stopAngle, false)
    }
    if (filled) {
      path.moveTo(0, 0);
      path.close();
      ctx.drawPath(path, fillPaint);
    } else {
      ctx.drawPath(path, strokePaint);
    }

    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  void drawTitleImage(Canvas ctx) {
    ctx.save();
    // ctx.textAlign = 'left'
    // ctx.textBaseline = 'middle'
    // ctx.strokeStyle = backgroundColor.labelColor.getRgbaColor()
    // ctx.fillStyle = backgroundColor.labelColor.getRgbaColor()

    //ctx.font = 0.046728 * imageWidth + 'px ' + stdFontName

    final TextStyle stdFont = getFont(0.046728 * imageWidth, backgroundColor.labelColor);
    var textSpan = TextSpan(
      text: titleString,
      style: stdFont,
    );
    var textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: imageWidth * 0.3,
    );
    textPainter.paint(ctx, Offset((imageWidth - textPainter.width) / 2, imageHeight * 0.41));
    textSpan = TextSpan(
      text: unitString,
      style: stdFont,
    );
    textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: imageWidth * 0.3,
    );
    textPainter.paint(ctx, Offset((imageWidth - textPainter.width) / 2, imageHeight * 0.48));
    ctx.restore();
  }

  void drawTickmarksImage(Canvas ctx, LabelNumberFormatEnum labelNumberFormat) {
    ctx.save();

    if (OrientationEnum.WEST == orientation) {
      ctx.translate(centerX, centerX);
      ctx.rotate(-HALF_PI);
      ctx.translate(-centerX, -centerX);
    }
    if (OrientationEnum.EAST == orientation) {
      ctx.translate(centerX, centerX);
      ctx.rotate(HALF_PI);
      ctx.translate(-centerX, -centerX);
    }

    double fontSize = (imageWidth * 0.040).ceilToDouble();

    if (maxValue > 999 || labelNumberFormat == LabelNumberFormatEnum.FRACTIONAL || labelNumberFormat == LabelNumberFormatEnum.SCIENTIFIC) {
      fontSize = fontSize * 0.8;
    }

    final TextStyle stdFont = getFont(fontSize, backgroundColor.labelColor);

    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset);
    double rotationStep = angleStep * minorTickSpacing;
    double textRotationAngle;

    double valueCounter = minValue;
    double majorTickCounter = maxNoOfMinorTicks - 1;

    double OUTER_POINT = imageWidth * 0.44;
    double MAJOR_INNER_POINT = imageWidth * 0.41;
    double MED_INNER_POINT = imageWidth * 0.415;
    double MINOR_INNER_POINT = imageWidth * 0.42;
    double TEXT_TRANSLATE_X = imageWidth * 0.48;
    double TEXT_WIDTH = imageWidth * 0.25;
    double HALF_MAX_NO_OF_MINOR_TICKS = maxNoOfMinorTicks / 2;
    double MAX_VALUE_ROUNDED = double.parse(maxValue.toStringAsFixed(2));

    for (double i = minValue; double.parse(i.toStringAsFixed(2)) <= MAX_VALUE_ROUNDED; i += minorTickSpacing) {
      textRotationAngle = rotationStep + HALF_PI;
      majorTickCounter++;
      // Draw major tickmarks
      if (majorTickCounter == maxNoOfMinorTicks) {
        Path path = Path();
        path.moveTo(OUTER_POINT, 0);
        path.lineTo(MAJOR_INNER_POINT, 0);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = 1.5
              ..style = ui.PaintingStyle.stroke);
        ctx.save();
        ctx.translate(TEXT_TRANSLATE_X, 0);
        ctx.rotate(textRotationAngle);
        switch (labelNumberFormat) {
          case LabelNumberFormatEnum.FRACTIONAL:
            var textSpan = TextSpan(
              text: valueCounter.toStringAsFixed(2),
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: TEXT_WIDTH * 2,
            );
            textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 1.4));
            break;

          case LabelNumberFormatEnum.SCIENTIFIC:
            var textSpan = TextSpan(
              text: valueCounter.toStringAsPrecision(2),
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: TEXT_WIDTH,
            );
            textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 1.4));
            break;

          case LabelNumberFormatEnum.STANDARD:
            var textSpan = TextSpan(
              text: valueCounter.toStringAsFixed(0),
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: TEXT_WIDTH,
            );
            textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 1.4));
            break;
        }
        ctx.translate(-TEXT_TRANSLATE_X, 0);
        ctx.restore();

        valueCounter += majorTickSpacing;
        majorTickCounter = 0;
        ctx.rotate(rotationStep);
        continue;
      }

      // Draw tickmark every minor tickmark spacing
      if (maxNoOfMinorTicks % 2 == 0 && majorTickCounter == HALF_MAX_NO_OF_MINOR_TICKS) {
        Path path = Path();
        path.moveTo(OUTER_POINT, 0);
        path.lineTo(MED_INNER_POINT, 0);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = 1
              ..style = ui.PaintingStyle.stroke);
      } else {
        Path path = Path();
        path.moveTo(OUTER_POINT, 0);
        path.lineTo(MINOR_INNER_POINT, 0);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = 0.5
              ..style = ui.PaintingStyle.stroke);
      }
      ctx.rotate(rotationStep);
    }

    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background
  void init(dynamic parameters) {
    bool drawFrame2 = parameters['frame'] == null ? false : parameters['frame'] as bool;
    bool drawBackground2 = parameters['background'] == null ? false : parameters['background'] as bool;
    bool drawLed = parameters['led'] == null ? false : parameters['led'] as bool;
    bool drawPointer = parameters['pointer'] == null ? false : parameters['pointer'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;

    // Calculate the current min and max values and the range
    calculate();

    // Create frame in frame buffer (backgroundBuffer)
    if (drawFrame2 && frameVisible) {
      ui.Picture framePicture = drawFrame(
        frameDesign,
        centerX,
        size / 2,
        imageWidth,
        imageHeight,
      );
      frameContext.drawPicture(framePicture);
    }

    // Create background in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
      ui.Picture backgroundPicture = drawBackground(
        backgroundColor,
        centerX,
        size / 2,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(backgroundPicture);
    }

    //   // Draw LED ON in ledBuffer_ON
    if (drawLed) {
      // Draw LED ON in ledBuffer_ON
      ui.Picture ledOnPicture = createLedImage((size * 0.093457).ceilToDouble(), 1, ledColor);
      ledContextOn.drawPicture(ledOnPicture);

      // Draw LED OFF in ledBuffer_OFF
      ui.Picture ledOffPicture = createLedImage((size * 0.093457).ceilToDouble(), 0, ledColor);
      ledContextOff.drawPicture(ledOffPicture);
    }

    // Draw min measured value indicator in minMeasuredValueBuffer
    if (minMeasuredValueVisible) {
      minMeasuredValueCtx.drawPicture(
        createMeasuredValueImage(
          (size * 0.028037).ceilToDouble(),
          ColorEnum.BLUE.dark,
          true,
          true,
        ),
      );
    }

    // Draw max measured value indicator in maxMeasuredValueBuffer
    if (maxMeasuredValueVisible) {
      maxMeasuredValueCtx.drawPicture(
        createMeasuredValueImage(
          (size * 0.028037).ceilToDouble(),
          ColorEnum.RED.medium,
          true,
          false,
        ),
      );
    }

    // Create alignment posts in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
      drawPostsImage(backgroundContext);

      // Create section in background buffer (backgroundBuffer)
      if (section != null && section.isNotEmpty) {
        backgroundContext.save();
        if (OrientationEnum.WEST == orientation) {
          backgroundContext.translate(centerX, centerX);
          backgroundContext.rotate(-HALF_PI);
          backgroundContext.translate(-centerX, -centerX);
        } else if (OrientationEnum.EAST == orientation) {
          backgroundContext.translate(centerX, centerX);
          backgroundContext.rotate(HALF_PI);
          backgroundContext.translate(-centerX, -centerX);
        }
        int sectionIndex = section.length;
        do {
          sectionIndex--;
          drawAreaSectionImage(
            backgroundContext,
            section[sectionIndex].start,
            section[sectionIndex].stop,
            section[sectionIndex].color,
            false,
          );
        } while (sectionIndex > 0);
        backgroundContext.restore();
      }

      // Create area in background buffer (backgroundBuffer)
      if (area != null && area.isNotEmpty) {
        backgroundContext.save();
        if (OrientationEnum.WEST == orientation) {
          backgroundContext.translate(centerX, centerX);
          backgroundContext.rotate(-HALF_PI);
          backgroundContext.translate(-centerX, -centerX);
        }
        if (OrientationEnum.EAST == orientation) {
          backgroundContext.translate(centerX, centerX);
          backgroundContext.rotate(HALF_PI);
          backgroundContext.translate(-centerX, -centerX);
        }
        int areaIndex = area.length;
        do {
          areaIndex--;
          drawAreaSectionImage(
            backgroundContext,
            area[areaIndex].start,
            area[areaIndex].stop,
            area[areaIndex].color,
            true,
          );
        } while (areaIndex > 0);
        backgroundContext.restore();
      }

      // Create tickmarks in background buffer (backgroundBuffer)
      drawTickmarksImage(backgroundContext, labelNumberFormat);

      // Create title in background buffer (backgroundBuffer)
      drawTitleImage(backgroundContext);
    }

    // Draw threshold image to background context
    if (thresholdVisible) {
      backgroundContext.save();
      if (OrientationEnum.WEST == orientation) {
        backgroundContext.translate(centerX, centerX);
        backgroundContext.rotate(-HALF_PI);
        backgroundContext.translate(-centerX, -centerX);
      }
      if (OrientationEnum.EAST == orientation) {
        backgroundContext.translate(centerX, centerX);
        backgroundContext.rotate(HALF_PI);
        backgroundContext.translate(-centerX, -centerX);
      }
      backgroundContext.translate(centerX, centerY);
      backgroundContext.rotate(rotationOffset + (threshold - minValue) * angleStep + HALF_PI);
      backgroundContext.translate(-centerX, -centerY);
      ui.Picture picture = createThresholdImage();
      backgroundContext.translate(imageWidth * 0.475, imageHeight * 0.32);
      backgroundContext.drawPicture(picture);
      backgroundContext.translate(-imageWidth * 0.475, -imageHeight * 0.32);
      backgroundContext.restore();
    }

    // Create pointer image in pointer buffer (contentBuffer)
    if (drawPointer) {
      ui.Picture picture = drawPointerImage(
        imageWidth * 1.17,
        pointerType,
        pointerColor.toColorDef(),
        backgroundColor.labelColor,
      );
      pointerContext.drawPicture(picture);
    }

    // Create foreground in foreground buffer (foregroundBuffer)
    if (drawForeground2 && foregroundVisible) {
      bool knobVisible = !(pointerType == PointerTypeEnum.TYPE15 || pointerType == PointerTypeEnum.TYPE16);
      ui.Picture picture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        knobVisible,
        knobType,
        knobStyle,
        gaugeType,
        orientation == OrientationEnum.NORTH ? OrientationEnum.SOUTH : orientation,
      );
      foregroundContext.drawPicture(picture);
    }
  }

  void repaint() {
    init({
      'frame': true,
      'background': true,
      'led': true,
      'pointer': true,
      'foreground': true,
    });

    canvas.save();

    // Draw frame
    if (frameVisible) {
      ui.Picture picture = frameContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw buffered image to visible canvas
    ui.Picture picture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(picture);

    // Draw led
    if (ledVisible) {
      picture = ledOn ? ledBufferOnRecorder.endRecording() : ledBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(ledPosX, ledPosY);
      canvas.drawPicture(picture);
      canvas.translate(-ledPosX, -ledPosY);
      canvas.restore();
    }

    if (OrientationEnum.WEST == orientation) {
      canvas.translate(centerX, centerX);
      canvas.rotate(-HALF_PI);
      canvas.translate(-centerX, -centerX);
    }
    if (OrientationEnum.EAST == orientation) {
      canvas.translate(centerX, centerX);
      canvas.rotate(HALF_PI);
      canvas.translate(-centerX, -centerX);
    }

    // Draw min measured value indicator
    if (minMeasuredValueVisible) {
      picture = minMeasuredValueBufferRecorder.endRecording();
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(rotationOffset + HALF_PI + (minMeasuredValue - minValue) * angleStep);
      canvas.translate(-centerX, -centerY);
      canvas.translate(imageWidth * 0.4865, imageHeight * 0.27);
      canvas.drawPicture(picture);
      canvas.translate(-imageWidth * 0.4865, -imageHeight * 0.27);
      canvas.restore();
    }

    // Draw max measured value indicator
    if (maxMeasuredValueVisible) {
      picture = maxMeasuredValueBufferRecorder.endRecording();
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(rotationOffset + HALF_PI + (maxMeasuredValue - minValue) * angleStep);
      canvas.translate(-centerX, -centerY);
      canvas.translate(imageWidth * 0.4865, imageHeight * 0.27);
      canvas.drawPicture(picture);
      canvas.translate(-imageWidth * 0.4865, -imageHeight * 0.27);
      canvas.restore();
    }

    angle = rotationOffset + HALF_PI + (value - minValue) * angleStep;

    // Define rotation center
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(angle);
    //   // Set the pointer shadow params
    //   mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    //   mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
    //   mainCtx.shadowBlur = shadowOffset * 2
    //   // Draw pointer
    canvas.translate(-pointerOffset, -pointerOffset);
    picture = pointerContextRecorder.endRecording();
    canvas.drawPicture(picture);
    // Undo the translations & shadow settings
    canvas.restore();

    // Draw foreground
    if (foregroundVisible) {
      if (OrientationEnum.WEST == orientation) {
        canvas.translate(centerX, centerX);
        canvas.rotate(HALF_PI);
        canvas.translate(-centerX, -centerX);
      } else if (OrientationEnum.EAST == orientation) {
        canvas.translate(centerX, centerX);
        canvas.rotate(-HALF_PI);
        canvas.translate(-centerX, -centerX);
      }
      picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
    canvas.restore();
  }

  // Visualize the component
  repaint();
}
