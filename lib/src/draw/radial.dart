// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'createKnobImage.dart';
import 'createLcdBackgroundImage.dart';
import 'createLedImage.dart';
import 'createMeasuredValueImage.dart';
import 'createTrendIndicator.dart';
import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'drawPointerImage.dart';
import 'drawRadialCustomImage.dart';
import 'drawTitleImage.dart';
import 'odometer.dart';
import 'tools.dart';

void drawRadial(Canvas canvas, Size canvasSize, Parameters parameters) {
  GaugeTypeEnum gaugeType = parameters.gaugeTypeWithDefault(GaugeTypeEnum.TYPE4);
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  double minValue = parameters.minValueWithDefault(0);
  double maxValue = parameters.maxValueWithDefault(100);
  bool niceScale = parameters.niceScaleWithDefault(true);
  double threshold = parameters.thresholdWithDefault((maxValue - minValue) / 2 + minValue);
  bool thresholdVisible = parameters.thresholdVisibleWithDefault(true);
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
  LcdColorEnum lcdColor = parameters.lcdColorWithDefault(LcdColorEnum.STANDARD);
  bool lcdVisible = parameters.lcdVisibleWithDefault(true);
  int lcdDecimals = parameters.lcdDecimalsWithDefault(1);
  FontTypeEnum fontType = parameters.fontTypeWithDefault(FontTypeEnum.RobotoMono);
  int fractionalScaleDecimals = parameters.fractionalScaleDecimalsWithDefault(1);
  LedColorEnum ledColor = parameters.ledColorWithDefault(LedColorEnum.RED_LED);
  bool ledVisible = parameters.ledVisibleWithDefault(false);
  bool ledOn = parameters.ledOnWithDefault(false);
  LedColorEnum userLedColor = parameters.userLedColorWithDefault(LedColorEnum.GREEN_LED);
  bool userLedVisible = parameters.userLedVisibleWithDefault(false);
  bool userLedOn = parameters.userLedOnWithDefault(false);
  bool minMeasuredValueVisible = parameters.minMeasuredValueVisibleWithDefault(false);
  bool maxMeasuredValueVisible = parameters.maxMeasuredValueVisibleWithDefault(false);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  LabelNumberFormatEnum labelNumberFormat = parameters.labelNumberFormatWithDefault(LabelNumberFormatEnum.STANDARD);
  ui.Image? customLayer = parameters.customLayer;
  TickLabelOrientationEnum tickLabelOrientation = parameters.tickLabelOrientationWithDefault(gaugeType == GaugeTypeEnum.TYPE1 ? TickLabelOrientationEnum.TANGENT : TickLabelOrientationEnum.NORMAL);
  bool trendVisible = parameters.trendVisibleWithDefault(false);
  List<LedColorEnum> trendColors = parameters.trendColorsWithDefault([LedColorEnum.RED_LED, LedColorEnum.GREEN_LED, LedColorEnum.CYAN_LED]);
  bool useOdometer = parameters.useOdometerWithDefault(false);
  OdometerParameters odometerParams = parameters.odometerParametersWithDefault(OdometerParameters());

  double value = parameters.value ?? minValue;

  // Properties
  double minMeasuredValue = parameters.minMeasuredValueWithDefault(minValue);
  double maxMeasuredValue = parameters.maxMeasuredValueWithDefault(maxValue);

  TrendStateEnum trendIndicator = parameters.trendStateWithDefault(TrendStateEnum.OFF);
  double trendSize = size * 0.06;
  double trendPosX = size * 0.29;
  double trendPosY = size * 0.36;

  // GaugeType specific private variables
  double freeAreaAngle = 0;
  double rotationOffset = 0;
  double angleRange = 0;
  double angleStep = 0;

  double angle = rotationOffset + (value - minValue) * angleStep;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  // Misc
  double ledSize = size * 0.093457;
  double ledPosX = 0.6 * imageWidth;
  double ledPosY = 0.4 * imageHeight;
  double userLedPosX = gaugeType == GaugeTypeEnum.TYPE3 ? 0.6 * imageWidth : centerX - ledSize / 2;
  double userLedPosY = gaugeType == GaugeTypeEnum.TYPE3 ? 0.72 * imageHeight : 0.75 * imageHeight;
  double lcdFontHeight = (imageWidth / 10).floorToDouble();
  double lcdHeight = imageHeight * 0.13;
  double lcdWidth = imageWidth * 0.4;
  double lcdPosX = (imageWidth - lcdWidth) / 2;
  double lcdPosY = imageHeight * 0.57;
  double odoPosX = 0;
  double odoPosY = imageHeight * 0.61;
  //double shadowOffset = imageWidth * 0.006;

  // Constants
  // let initialized = false

  // Tickmark specific private variables
  double niceMinValue = minValue;
  double niceMaxValue = maxValue;
  double niceRange = maxValue - minValue;
  double range = niceMaxValue - niceMinValue;
  double minorTickSpacing = 0;
  double majorTickSpacing = 0;
  double maxNoOfMinorTicks = 10;
  double maxNoOfMajorTicks = 10;

  // Method to calculate nice values for min, max and range for the tickmarks
  void calculate() {
    if (niceScale) {
      niceRange = calcNiceNumber(maxValue - minValue, false);
      majorTickSpacing = calcNiceNumber(niceRange / (maxNoOfMajorTicks - 1), true);
      niceMinValue = (minValue / majorTickSpacing).floorToDouble() * majorTickSpacing;
      niceMaxValue = (maxValue / majorTickSpacing).ceilToDouble() * majorTickSpacing;
      minorTickSpacing = calcNiceNumber(majorTickSpacing / (maxNoOfMinorTicks - 1), true);
      minValue = niceMinValue;
      maxValue = niceMaxValue;
      range = maxValue - minValue;
    } else {
      niceRange = maxValue - minValue;
      niceMinValue = minValue;
      niceMaxValue = maxValue;
      range = niceRange;
      majorTickSpacing = calcNiceNumber(niceRange / (maxNoOfMajorTicks - 1), true);
      minorTickSpacing = calcNiceNumber(majorTickSpacing / (maxNoOfMinorTicks - 1), true);
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

    switch (gaugeType) {
      case GaugeTypeEnum.TYPE1:
        freeAreaAngle = 0;
        rotationOffset = PI;
        angleRange = HALF_PI;
        angleStep = angleRange / range;
        break;

      case GaugeTypeEnum.TYPE2:
        freeAreaAngle = 0;
        rotationOffset = PI;
        angleRange = PI;
        angleStep = angleRange / range;
        break;

      case GaugeTypeEnum.TYPE3:
        freeAreaAngle = 0;
        rotationOffset = HALF_PI;
        angleRange = 1.5 * PI;
        angleStep = angleRange / range;
        break;

      case GaugeTypeEnum.TYPE4:
      /* falls through */
      default:
        freeAreaAngle = 60 * RAD_FACTOR;
        rotationOffset = HALF_PI + freeAreaAngle / 2;
        angleRange = TWO_PI - freeAreaAngle;
        angleStep = angleRange / range;
        break;
    }
    angle = rotationOffset + (value - minValue) * angleStep;
  }

  // **************   Buffer creation  ********************
  // Buffer for the frame
  var frameContextRecorder = ui.PictureRecorder();
  var frameContext = Canvas(frameContextRecorder);

  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // let lcdBuffer

  // Buffer for led on painting code
  var ledBufferOnRecorder = ui.PictureRecorder();
  var ledContextOn = Canvas(ledBufferOnRecorder);

  // Buffer for led off painting code
  var ledBufferOffRecorder = ui.PictureRecorder();
  var ledContextOff = Canvas(ledBufferOffRecorder);

  // Buffer for current led painting code
  // const ledBuffer = ledBufferOff

  // Buffer for user led on painting code
  var userLedBufferOnRecorder = ui.PictureRecorder();
  var userLedContextOn = Canvas(userLedBufferOnRecorder);

  // Buffer for user led off painting code
  var userLedBufferOffRecorder = ui.PictureRecorder();
  var userLedContextOff = Canvas(userLedBufferOffRecorder);

  // // Buffer for current user led painting code
  // const userLedBuffer = userLedBufferOff

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

  // Buffers for trend indicators
  ui.Picture? trendUpBuffer;
  ui.Picture? trendSteadyBuffer;
  ui.Picture? trendDownBuffer;
  ui.Picture? trendOffBuffer;

  // Buffer for odometer
  var odoContextRecorder = ui.PictureRecorder();
  var odoContext = Canvas(odoContextRecorder);

  // **************   Image creation  ********************
  void drawLcdText(Canvas ctx, double value) {
    ctx.save();
    // ctx.textAlign = 'right'
    // ctx.strokeStyle = lcdColor.textColor
    // ctx.fillStyle = lcdColor.textColor

    if (lcdColor == LcdColorEnum.STANDARD || lcdColor == LcdColorEnum.STANDARD_GREEN) {
      // ctx.shadowColor = 'gray'
      // ctx.shadowOffsetX = imageWidth * 0.007
      // ctx.shadowOffsetY = imageWidth * 0.007
      // ctx.shadowBlur = imageWidth * 0.007
    }
    TextStyle font = getFont(fontType == FontTypeEnum.LCDMono ? lcdFontHeight : lcdFontHeight * 0.8, lcdColor.textColor, fontType: fontType);
    var textSpan = TextSpan(
      text: value.toStringAsFixed(lcdDecimals),
      style: font,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout(
      minWidth: lcdWidth * 0.8,
      maxWidth: lcdWidth * 0.8,
    );
    Offset offset = Offset(centerX - textPainter.size.width / 2, lcdPosY + lcdHeight / 2 - textPainter.height / 2);
    // Rect rect = Rect.fromLTWH(offset.dx - 3, offset.dy, textPainter.size.width + 10, textPainter.size.height);

    // ui.Gradient foregroundGrad = ui.Gradient.linear(
    //   rect.topLeft,
    //   rect.bottomLeft,
    //   [
    //     lcdColor.gradientStartColor,
    //     lcdColor.gradientFraction1Color,
    //     lcdColor.gradientFraction2Color,
    //     lcdColor.gradientFraction3Color,
    //     lcdColor.gradientStopColor,
    //   ],
    //   [0, 0.03, 0.49, 0.5, 1],
    // );
    // Path path = Path();
    // path.addRect(rect);
    // path.close();
    // ctx.drawPath(
    //     path,
    //     Paint()
    //       ..shader = foregroundGrad
    //       ..style = ui.PaintingStyle.fill);
    // paintBorder(
    //   ctx,
    //   rect,
    //   top: BorderSide(width: 1, color: Colors.grey.shade800),
    //   bottom: BorderSide(width: 1, color: Colors.grey.shade800),
    //   left: BorderSide(width: 1, color: Colors.grey.shade800),
    //   right: BorderSide(width: 1, color: Colors.grey.shade800),
    // );
    // Rect innerRect = rect.deflate(1);
    // paintBorder(
    //   ctx,
    //   innerRect,
    //   top: BorderSide(width: 1, color: Colors.grey),
    //   bottom: BorderSide(width: 1, color: Colors.grey),
    //   left: BorderSide(width: 1, color: Colors.grey),
    //   right: BorderSide(width: 1, color: Colors.grey),
    // );

    textPainter.paint(ctx, offset);
    ctx.restore();
  }

  void drawPostsImage(Canvas ctx) {
    ctx.save();

    if (gaugeType == GaugeTypeEnum.TYPE1) {
      // Draw max center top post
      ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
      ctx.translate(imageWidth * 0.523364, imageHeight * 0.130841);
      ctx.drawPicture(knobImage);
      ctx.translate(-imageWidth * 0.523364, -imageHeight * 0.130841);
    }

    if (gaugeType == GaugeTypeEnum.TYPE1 || gaugeType == GaugeTypeEnum.TYPE2) {
      // Draw min left post
      ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
      ctx.translate(imageWidth * 0.130841, imageHeight * 0.514018);
      ctx.drawPicture(knobImage);
      ctx.translate(-imageWidth * 0.130841, -imageHeight * 0.514018);
    }

    if (gaugeType == GaugeTypeEnum.TYPE2 || gaugeType == GaugeTypeEnum.TYPE3) {
      // Draw max right post
      ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
      ctx.translate(imageWidth * 0.831775, imageHeight * 0.514018);
      ctx.drawPicture(knobImage);
      ctx.translate(-imageWidth * 0.831775, -imageHeight * 0.514018);
    }

    if (gaugeType == GaugeTypeEnum.TYPE3) {
      // Draw min center bottom post
      ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
      ctx.translate(imageWidth * 0.523364, imageHeight * 0.831775);
      ctx.drawPicture(knobImage);
      ctx.translate(-imageWidth * 0.523364, -imageHeight * 0.831775);
    }

    if (gaugeType == GaugeTypeEnum.TYPE4) {
      // Min post
      ui.Picture knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
      ctx.translate(imageWidth * 0.336448, imageHeight * 0.803738);
      ctx.drawPicture(knobImage);
      ctx.translate(-imageWidth * 0.336448, -imageHeight * 0.803738);

      // Max post
      knobImage = createKnobImage((imageHeight * 0.037383).ceilToDouble(), KnobTypeEnum.STANDARD_KNOB, knobStyle);
      ctx.translate(imageWidth * 0.626168, imageHeight * 0.803738);
      ctx.drawPicture(knobImage);
      ctx.translate(-imageWidth * 0.626168, -imageHeight * 0.803738);
    }

    ctx.restore();
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
    if (start < minValue) {
      start = minValue;
    } else if (start > maxValue) {
      start = maxValue;
    }
    if (stop < minValue) {
      stop = minValue;
    } else if (stop > maxValue) {
      stop = maxValue;
    }
    if (start >= stop) {
      return;
    }
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

  void drawTickmarksImage(Canvas ctx, LabelNumberFormatEnum labelNumberFormat) {
    double fontSize = (imageWidth * 0.04).ceilToDouble();
    double alpha = rotationOffset; // Tracks total rotation
    double rotationStep = angleStep * minorTickSpacing;
    double textRotationAngle;
    double valueCounter = minValue;
    double majorTickCounter = maxNoOfMinorTicks - 1;
    double OUTER_POINT = imageWidth * 0.38;
    double MAJOR_INNER_POINT = imageWidth * 0.35;
    double MED_INNER_POINT = imageWidth * 0.355;
    double MINOR_INNER_POINT = imageWidth * 0.36;
    double TEXT_TRANSLATE_X = imageWidth * 0.3;
    double TEXT_WIDTH = imageWidth * 0.3;
    double HALF_MAX_NO_OF_MINOR_TICKS = maxNoOfMinorTicks / 2;
    double MAX_VALUE_ROUNDED = double.parse(maxValue.toStringAsFixed(2));

    ctx.save();
    //   ctx.textAlign = 'center'
    //   ctx.textBaseline = 'middle'
    //   ctx.font = fontSize + 'px ' + stdFontName
    //   ctx.strokeStyle = backgroundColor.labelColor.getRgbaColor()
    //   ctx.fillStyle = backgroundColor.labelColor.getRgbaColor()

    double localFontSize = fontSize * 1.1;

    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset);

    if (gaugeType == GaugeTypeEnum.TYPE1 || gaugeType == GaugeTypeEnum.TYPE2) {
      TEXT_WIDTH = imageWidth * 0.09;
      localFontSize = fontSize * 0.75;
    }

    if (tickLabelOrientation == TickLabelOrientationEnum.HORIZONTAL || tickLabelOrientation == TickLabelOrientationEnum.TANGENT) {
      TEXT_TRANSLATE_X = imageWidth * 0.26;
      if (maxValue > 999) {
        fontSize *= 0.7;
      }
    }

    final TextStyle stdFont = getFont(localFontSize, backgroundColor.labelColor);

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
        double textYOffset = 0;

        switch (tickLabelOrientation) {
          case TickLabelOrientationEnum.HORIZONTAL:
            textRotationAngle = -alpha;
            break;

          case TickLabelOrientationEnum.TANGENT:
            textRotationAngle = alpha <= HALF_PI + PI ? PI : 0;
            textYOffset = stdFont.fontSize! / 4;
            break;

          case TickLabelOrientationEnum.NORMAL:
          /* falls through */
          default:
            textRotationAngle = HALF_PI;
            break;
        }
        ctx.rotate(textRotationAngle);

        switch (labelNumberFormat) {
          case LabelNumberFormatEnum.FRACTIONAL:
            var textSpan = TextSpan(
              text: valueCounter.toStringAsFixed(fractionalScaleDecimals),
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
            textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 1.4 + textYOffset));
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
            textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 1.4 + textYOffset));
            break;

          case LabelNumberFormatEnum.STANDARD:
          /* falls through */
          default:
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
            textPainter.paint(ctx, Offset(-textPainter.width / 2, -textPainter.height / 1.4 + textYOffset));
            break;
        }
        ctx.translate(-TEXT_TRANSLATE_X, 0);
        ctx.restore();

        valueCounter += majorTickSpacing;
        majorTickCounter = 0;
        ctx.rotate(rotationStep);
        alpha += rotationStep;
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
      alpha += rotationStep;
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
    bool drawUserLed = parameters['userLed'] == null ? false : parameters['userLed'] as bool;
    bool drawPointer = parameters['pointer'] == null ? false : parameters['pointer'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;
    bool drawTrend = parameters['trend'] == null ? false : parameters['trend'] as bool;
    bool drawOdo = parameters['odo'] == null ? false : parameters['odo'] as bool;

    //   initialized = true

    // Calculate the current min and max values and the range
    calculate();

    // Create frame in frame buffer (backgroundBuffer)
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

    // Create background in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
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
    }

    if (drawLed) {
      // Draw LED ON in ledBuffer_ON
      ui.Picture ledOnPicture = createLedImage((size * 0.093457).ceilToDouble(), 1, ledColor);
      ledContextOn.drawPicture(ledOnPicture);

      // Draw LED OFF in ledBuffer_OFF
      ui.Picture ledOffPicture = createLedImage((size * 0.093457).ceilToDouble(), 0, ledColor);
      ledContextOff.drawPicture(ledOffPicture);
    }

    if (drawUserLed) {
      // Draw user LED ON in userLedBuffer_ON
      ui.Picture userLedOnPicture = createLedImage((size * 0.093457).ceilToDouble(), 1, userLedColor);
      userLedContextOn.drawPicture(userLedOnPicture);

      // Draw user LED OFF in userLedBuffer_OFF
      ui.Picture userLedOffPicture = createLedImage((size * 0.093457).ceilToDouble(), 0, userLedColor);
      userLedContextOff.drawPicture(userLedOffPicture);
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
      }

      // Create area in background buffer (backgroundBuffer)
      if (area != null && area.isNotEmpty) {
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
      }

      // Create tickmarks in background buffer (backgroundBuffer)
      drawTickmarksImage(backgroundContext, labelNumberFormat);

      // Create title in background buffer (backgroundBuffer)
      drawTitleImage(
        backgroundContext,
        imageWidth,
        imageHeight,
        titleString,
        unitString,
        backgroundColor,
        true,
        true,
        false,
        null,
      );
    }

    // Draw threshold image to background context
    if (drawBackground2 && thresholdVisible) {
      backgroundContext.save();
      backgroundContext.translate(centerX, centerY);
      backgroundContext.rotate(
        rotationOffset + (threshold - minValue) * angleStep + HALF_PI,
      );
      backgroundContext.translate(-centerX, -centerY);
      backgroundContext.translate(imageWidth * 0.475, imageHeight * 0.13);
      ui.Picture thresholdImagePicture = createThresholdImage();
      backgroundContext.drawPicture(thresholdImagePicture);
      backgroundContext.translate(-imageWidth * 0.475, -imageHeight * 0.13);
      backgroundContext.translate(centerX, centerY);
      backgroundContext.restore();
    }

    // Create lcd background if selected in background buffer (backgroundBuffer)
    if (drawBackground2 && lcdVisible) {
      if (useOdometer && drawOdo) {
        var params = OdometerParameters(
            height: size * 0.075,
            value: value,
            decimals: odometerParams.decimalsWithDefault(1),
            digits: odometerParams.digitsWithDefault(5),
            valueForeColor: odometerParams.valueForeColor,
            valueBackColor: odometerParams.valueBackColor,
            decimalForeColor: odometerParams.decimalForeColor,
            decimalBackColor: odometerParams.decimalBackColor,
            wobbleFactor: odometerParams.wobbleFactor);
        drawOdometer(odoContext, params);

        //   _context: odoContext,
        //   height: size * 0.075,
        //   decimals: odometerParams.decimals,
        //   digits:
        //     odometerParams.digits === undefined ? 5 : odometerParams.digits,
        //   valueForeColor: odometerParams.valueForeColor,
        //   valueBackColor: odometerParams.valueBackColor,
        //   decimalForeColor: odometerParams.decimalForeColor,
        //   decimalBackColor: odometerParams.decimalBackColor,
        //   font: odometerParams.font,
        //   value: value
        // })
        odoPosX = (imageWidth - odometerWidth(size * 0.075, params.digits!, params.decimals!)) / 2;
      } else if (!useOdometer) {
        var lcdBuffer = createLcdBackgroundImage(lcdWidth, lcdHeight, lcdColor);
        backgroundContext.save();
        backgroundContext.translate(lcdPosX, lcdPosY);
        backgroundContext.drawPicture(lcdBuffer);
        backgroundContext.translate(-lcdPosX, -lcdPosY);
        backgroundContext.restore();
      }
    }

    // Create pointer image in pointer buffer (contentBuffer)
    if (drawPointer) {
      ui.Picture pointerPicture = drawPointerImage(
        imageWidth,
        pointerType,
        pointerColor.toColorDef(),
        backgroundColor.labelColor,
      );
      pointerContext.drawPicture(pointerPicture);
    }

    // Create foreground in foreground buffer (foregroundBuffer)
    if (drawForeground2 && foregroundVisible) {
      bool knobVisible = !(pointerType == PointerTypeEnum.TYPE15 || pointerType == PointerTypeEnum.TYPE16);
      ui.Picture foregroundPicture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        knobVisible,
        knobType,
        knobStyle,
        gaugeType,
        OrientationEnum.NORTH,
      );
      foregroundContext.drawPicture(foregroundPicture);
    }

    // Create the trend indicator buffers
    if (drawTrend && trendVisible) {
      trendUpBuffer = createTrendIndicator(
        trendSize,
        TrendStateEnum.UP,
        trendColors,
      );
      trendSteadyBuffer = createTrendIndicator(
        trendSize,
        TrendStateEnum.STEADY,
        trendColors,
      );
      trendDownBuffer = createTrendIndicator(
        trendSize,
        TrendStateEnum.DOWN,
        trendColors,
      );
      trendOffBuffer = createTrendIndicator(
        trendSize,
        TrendStateEnum.OFF,
        trendColors,
      );
    }
  }

  void repaint() {
    init({
      'frame': true,
      'background': true,
      'led': true,
      'userLed': true,
      'pointer': true,
      'trend': true,
      'foreground': true,
      'odo': true,
    });

    //   mainCtx.clearRect(0, 0, size, size)

    // Draw frame
    if (frameVisible) {
      ui.Picture picture = frameContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw buffered image to visible canvas
    ui.Picture picture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(picture);

    // Draw lcd display
    if (lcdVisible) {
      if (useOdometer) {
        picture = odoContextRecorder.endRecording();
        canvas.save();
        canvas.translate(odoPosX, odoPosY);
        canvas.drawPicture(picture);
        canvas.translate(-odoPosX, -odoPosY);
        canvas.restore();
      } else {
        drawLcdText(canvas, value);
      }
    }

    // Draw led
    if (ledVisible) {
      picture = ledOn ? ledBufferOnRecorder.endRecording() : ledBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(ledPosX, ledPosY);
      canvas.drawPicture(picture);
      canvas.translate(-ledPosX, -ledPosY);
      canvas.restore();
    }

    // Draw user led
    if (userLedVisible) {
      picture = userLedOn ? userLedBufferOnRecorder.endRecording() : userLedBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(userLedPosX, userLedPosY);
      canvas.drawPicture(picture);
      canvas.translate(-userLedPosX, -userLedPosY);
      canvas.restore();
    }

    // Draw the trend indicator
    if (trendVisible) {
      switch (trendIndicator) {
        case TrendStateEnum.UP:
          canvas.save();
          canvas.translate(trendPosX, trendPosY);
          canvas.drawPicture(trendUpBuffer!);
          canvas.translate(-trendPosX, -trendPosY);
          canvas.restore();
          break;
        case TrendStateEnum.STEADY:
          canvas.save();
          canvas.translate(trendPosX, trendPosY);
          canvas.drawPicture(trendSteadyBuffer!);
          canvas.translate(-trendPosX, -trendPosY);
          canvas.restore();
          break;
        case TrendStateEnum.DOWN:
          canvas.save();
          canvas.translate(trendPosX, trendPosY);
          canvas.drawPicture(trendDownBuffer!);
          canvas.translate(-trendPosX, -trendPosY);
          canvas.restore();
          break;
        case TrendStateEnum.OFF:
          canvas.save();
          canvas.translate(trendPosX, trendPosY);
          canvas.drawPicture(trendOffBuffer!);
          canvas.translate(-trendPosX, -trendPosY);
          canvas.restore();
          break;
      }
    }

    // Draw min measured value indicator
    if (minMeasuredValueVisible) {
      picture = minMeasuredValueBufferRecorder.endRecording();
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(rotationOffset + HALF_PI + (minMeasuredValue - minValue) * angleStep);
      canvas.translate(-centerX, -centerY);
      canvas.translate(imageWidth * 0.4865, imageHeight * 0.105);
      canvas.drawPicture(picture);
      canvas.translate(-imageWidth * 0.4865, -imageHeight * 0.105);
      canvas.restore();
    }

    // Draw max measured value indicator
    if (maxMeasuredValueVisible) {
      picture = maxMeasuredValueBufferRecorder.endRecording();
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(rotationOffset + HALF_PI + (maxMeasuredValue - minValue) * angleStep);
      canvas.translate(-centerX, -centerY);
      canvas.translate(imageWidth * 0.4865, imageHeight * 0.105);
      canvas.drawPicture(picture);
      canvas.translate(-imageWidth * 0.4865, -imageHeight * 0.105);
      canvas.restore();
    }

    angle = rotationOffset + HALF_PI + (value - minValue) * angleStep;

    // Define rotation center
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(angle);
    canvas.translate(-centerX, -centerY);
    // Set the pointer shadow params
    // mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    // mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
    // mainCtx.shadowBlur = shadowOffset * 2
    // Draw the pointer
    picture = pointerContextRecorder.endRecording();
    canvas.drawPicture(picture);
    // Undo the translations & shadow settings
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
