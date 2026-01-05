// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'createLcdBackgroundImage.dart';
import 'createLedImage.dart';
import 'createTrendIndicator.dart';
import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'drawRadialCustomImage.dart';
import 'drawTitleImage.dart';
import 'tools.dart';

void drawRadialBargraph(Canvas canvas, Size canvasSize, Parameters parameters) {
  GaugeTypeEnum gaugeType = parameters.gaugeTypeWithDefault(GaugeTypeEnum.TYPE4);
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  double minValue = parameters.minValueWithDefault(0);
  double maxValue = parameters.maxValueWithDefault(100);
  bool niceScale = parameters.niceScaleWithDefault(true);
  double threshold = parameters.thresholdWithDefault((maxValue - minValue) / 2 + minValue);
  List<Section>? section = parameters.section;
  bool useSectionColors = parameters.useSectionColorsWithDefault(false);
  String titleString = parameters.titleStringWithDefault('');
  String unitString = parameters.unitStringWithDefault('');
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(BackgroundColorEnum.DARK_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  ColorEnum valueColor = parameters.valueColorWithDefault(ColorEnum.RED);
  LcdColorEnum lcdColor = parameters.lcdColorWithDefault(LcdColorEnum.STANDARD);
  bool lcdVisible = parameters.lcdVisibleWithDefault(true);
  int lcdDecimals = parameters.lcdDecimalsWithDefault(1);
  FontTypeEnum fontType = parameters.fontTypeWithDefault(FontTypeEnum.RobotoMono);
  int fractionalScaleDecimals = parameters.fractionalScaleDecimalsWithDefault(1);
  ui.Image? customLayer = parameters.customLayer;
  LedColorEnum ledColor = parameters.ledColorWithDefault(LedColorEnum.RED_LED);
  bool ledVisible = parameters.ledVisibleWithDefault(false);
  bool ledOn = parameters.ledOnWithDefault(false);
  LedColorEnum userLedColor = parameters.userLedColorWithDefault(LedColorEnum.GREEN_LED);
  bool userLedVisible = parameters.userLedVisibleWithDefault(false);
  bool userLedOn = parameters.userLedOnWithDefault(false);
  LabelNumberFormatEnum labelNumberFormat = parameters.labelNumberFormatWithDefault(LabelNumberFormatEnum.STANDARD);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE1);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  GradientWrapper? valueGradient = parameters.valueGradient;
  bool useValueGradient = parameters.useValueGradientWithDefault(false);
  TickLabelOrientationEnum tickLabelOrientation = parameters.tickLabelOrientationWithDefault(gaugeType == GaugeTypeEnum.TYPE1 ? TickLabelOrientationEnum.TANGENT : TickLabelOrientationEnum.NORMAL);
  bool trendVisible = parameters.trendVisibleWithDefault(false);
  List<LedColorEnum> trendColors = parameters.trendColorsWithDefault([LedColorEnum.RED_LED, LedColorEnum.GREEN_LED, LedColorEnum.CYAN_LED]);

  double value = parameters.value ?? minValue;

  // Properties
  double minMeasuredValue = parameters.minMeasuredValueWithDefault(minValue);
  double maxMeasuredValue = parameters.maxMeasuredValueWithDefault(maxValue);
  double range = maxValue - minValue;

  // GaugeType specific private variables
  double freeAreaAngle = 0;
  double rotationOffset = 0;
  double bargraphOffset = 0;
  double angleRange = 0;
  double degAngleRange = 0;
  double angleStep = 0;

  List<SectionRange> sectionAngles = [];
  bool isSectionsVisible = false;
  bool isGradientVisible = false;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  // Misc
  double lcdFontHeight = (imageWidth / 10).floorToDouble();
  // const stdFont = lcdFontHeight + 'px ' + stdFontName
  // const lcdFont = lcdFontHeight + 'px ' + lcdFontName
  double lcdHeight = imageHeight * 0.13;
  double lcdWidth = imageWidth * 0.4;
  double lcdPosX = (imageWidth - lcdWidth) / 2;
  double lcdPosY = imageHeight / 2 - lcdHeight / 2;
  double lcdPosYAdjust = 0;

  if (gaugeType == GaugeTypeEnum.TYPE1 || gaugeType == GaugeTypeEnum.TYPE2) {
    lcdPosYAdjust = lcdHeight / 3;
  }

  // Constants
  double ACTIVE_LED_POS_X = imageWidth * 0.116822;
  double ACTIVE_LED_POS_Y = imageWidth * 0.485981;
  double LED_SIZE = (size * 0.093457).ceilToDouble();
  //double LED_POS_X = imageWidth * 0.453271;
  double LED_POS_X = imageWidth * 0.53;
  double LED_POS_Y = imageHeight * 0.61;
  double USER_LED_POS_X = gaugeType == GaugeTypeEnum.TYPE3 ? 0.7 * imageWidth : centerX - LED_SIZE / 2;
  double USER_LED_POS_Y = gaugeType == GaugeTypeEnum.TYPE3 ? 0.61 * imageHeight : 0.75 * imageHeight;

  TrendStateEnum trendIndicator = parameters.trendStateWithDefault(TrendStateEnum.OFF);
  double trendSize = size * 0.06;
  double trendPosX = size * 0.38;
  double trendPosY = size * 0.57;

  switch (gaugeType) {
    case GaugeTypeEnum.TYPE1:
      freeAreaAngle = 0;
      rotationOffset = PI;
      bargraphOffset = 0;
      angleRange = HALF_PI;
      degAngleRange = angleRange * DEG_FACTOR;
      angleStep = angleRange / range;
      break;

    case GaugeTypeEnum.TYPE2:
      freeAreaAngle = 0;
      rotationOffset = PI;
      bargraphOffset = 0;
      angleRange = PI;
      degAngleRange = angleRange * DEG_FACTOR;
      angleStep = angleRange / range;
      break;

    case GaugeTypeEnum.TYPE3:
      freeAreaAngle = 0;
      rotationOffset = HALF_PI;
      bargraphOffset = -HALF_PI;
      angleRange = 1.5 * PI;
      degAngleRange = angleRange * DEG_FACTOR;
      angleStep = angleRange / range;
      break;

    case GaugeTypeEnum.TYPE4:
    /* falls through */
    default:
      freeAreaAngle = 60 * RAD_FACTOR;
      rotationOffset = HALF_PI + freeAreaAngle / 2;
      bargraphOffset = -TWO_PI / 6;
      angleRange = TWO_PI - freeAreaAngle;
      degAngleRange = angleRange * DEG_FACTOR;
      angleStep = angleRange / range;
      break;
  }

  // Buffer for the frame
  var frameContextRecorder = ui.PictureRecorder();
  var frameContext = Canvas(frameContextRecorder);

  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // let lcdBuffer

  // Buffer for active bargraph led
  var activeLedContextRecorder = ui.PictureRecorder();
  var activeLedContext = Canvas(activeLedContextRecorder);

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

  // Buffer for current user led painting code
  // const userLedBuffer = userLedBufferOff

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  // Buffers for trend indicators
  ui.Picture? trendUpBuffer;
  ui.Picture? trendSteadyBuffer;
  ui.Picture? trendDownBuffer;
  ui.Picture? trendOffBuffer;

  // Tickmark specific private variables
  double niceMinValue = minValue;
  double niceMaxValue = maxValue;
  double niceRange = maxValue - minValue;
  range = niceMaxValue - niceMinValue;
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
      // minorTickSpacing = 1;
      // majorTickSpacing = 10;
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

      case GaugeTypeEnum.TYPE4: // fall through
      /* falls through */
      default:
        freeAreaAngle = 60 * RAD_FACTOR;
        rotationOffset = HALF_PI + freeAreaAngle / 2;
        angleRange = TWO_PI - freeAreaAngle;
        angleStep = angleRange / range;
        break;
    }
  }

  void drawBargraphTrackImage(Canvas ctx) {
    ctx.save();

    // Bargraphtrack

    // Frame
    ctx.save();
    Path path = Path();
    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset - 4 * RAD_FACTOR);
    ctx.translate(-centerX, -centerY);
    Rect rect = Rect.fromCenter(center: Offset(centerX, centerY), width: imageWidth * 0.35514 * 2, height: imageWidth * 0.35514 * 2);
    path.addArc(rect, 0, angleRange + 8 * RAD_FACTOR);
    ui.Gradient grad = ui.Gradient.linear(
      Offset(0, 0.107476 * imageHeight),
      Offset(0, 0.897195 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#333333'),
        colorFromHex('#333333'),
        colorFromHex('#cccccc'),
      ],
      [0, 0.22, 0.76, 1],
    );

    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..strokeWidth = size * 0.085
          ..style = ui.PaintingStyle.stroke);
    ctx.rotate(-rotationOffset);
    ctx.restore();

    // Main
    ctx.save();
    path = Path();
    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset - 4 * RAD_FACTOR);
    ctx.translate(-centerX, -centerY);
    rect = Rect.fromCenter(center: Offset(centerX, centerY), width: imageWidth * 0.35514 * 2, height: imageWidth * 0.35514 * 2);
    path.addArc(rect, 0, angleRange + 8 * RAD_FACTOR);

    grad = ui.Gradient.linear(
      Offset(0, 0.112149 * imageHeight),
      Offset(0, 0.892523 * imageHeight),
      [
        colorFromHex('#111111'),
        colorFromHex('#333333'),
      ],
      [0, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..strokeWidth = size * 0.075
          ..style = ui.PaintingStyle.stroke);
    ctx.rotate(-rotationOffset);
    ctx.restore();

    // Draw inactive leds
    double ledCenterX = (imageWidth * 0.116822 + imageWidth * 0.060747) / 2;
    double ledCenterY = (imageWidth * 0.485981 + imageWidth * 0.023364) / 2;
    var ledOffGradient = ui.Gradient.radial(
      Offset(ledCenterX, ledCenterY),
      0,
      [
        colorFromHex('#3c3c3c'),
        colorFromHex('#323232'),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(ledCenterX, ledCenterY),
      0.030373 * imageWidth,
    );

    double angle = 0;
    for (angle = 0; angle <= degAngleRange; angle += 5) {
      ctx.save();
      ctx.translate(centerX, centerY);
      ctx.rotate(angle * RAD_FACTOR + bargraphOffset);
      ctx.translate(-centerX, -centerY);
      Path path = Path();
      Rect rect = Rect.fromLTWH(imageWidth * 0.116822, imageWidth * 0.485981, imageWidth * 0.060747, imageWidth * 0.023364);
      path.addRect(rect);
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = ledOffGradient
            ..style = ui.PaintingStyle.fill);
      ctx.restore();
    }

    ctx.restore();
  }

  void drawActiveLed(Canvas ctx, ColorDef color) {
    ctx.save();

    double ledWidth = (size * 0.060747).ceilToDouble();
    double ledHeight = (size * 0.023364).ceilToDouble();
    double ledCenterX = ledWidth / 2;
    double ledCenterY = ledHeight / 2;

    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, ledWidth, ledHeight));
    path.close();

    var ledGradient = ui.Gradient.radial(
      Offset(ledCenterX, ledCenterY),
      0,
      [
        color.light,
        color.dark,
      ],
      <double>[0, 1],
      TileMode.clamp,
      null,
      Offset(ledCenterX, ledCenterY),
      ledWidth / 2,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = ledGradient
          ..style = ui.PaintingStyle.fill);
    ctx.restore();
  }

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
    //Offset offset = Offset(lcdWidth - lcdWidth * 0.05, centerY - lcdHeight * 1.8 + lcdFontHeight * 0.38);
    Offset offset = Offset(centerX - textPainter.size.width / 2, centerY - lcdHeight / 2 + ((lcdHeight - textPainter.size.height) / 2 + lcdPosYAdjust));
    Rect rect = Rect.fromLTWH(offset.dx - 3, offset.dy, textPainter.size.width + 10, textPainter.size.height);

    ui.Gradient foregroundGrad = ui.Gradient.linear(
      rect.topLeft,
      rect.bottomLeft,
      [
        lcdColor.gradientStartColor,
        lcdColor.gradientFraction1Color,
        lcdColor.gradientFraction2Color,
        lcdColor.gradientFraction3Color,
        lcdColor.gradientStopColor,
      ],
      [0, 0.03, 0.49, 0.5, 1],
    );
    Path path = Path();
    path.addRect(rect);
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..shader = foregroundGrad
          ..style = ui.PaintingStyle.fill);
    textPainter.paint(ctx, offset);
    ctx.restore();
  }

  void drawTickmarksImage(Canvas ctx, LabelNumberFormatEnum labelNumberFormat) {
    double alpha = rotationOffset; // Tracks total rotation
    double rotationStep = angleStep * minorTickSpacing;
    double textRotationAngle;
    double fontSize = (imageWidth * 0.04).ceilToDouble();
    double valueCounter = minValue;
    double majorTickCounter = maxNoOfMinorTicks - 1;
    double TEXT_TRANSLATE_X = imageWidth * 0.28;
    double TEXT_WIDTH = imageWidth * 0.3;
    double MAX_VALUE_ROUNDED = double.parse(maxValue.toStringAsFixed(2));
    //let i

    ctx.save();
    // ctx.textAlign = 'center'
    // ctx.textBaseline = 'middle'
    // ctx.font = fontSize + 'px ' + stdFontName
    // ctx.strokeStyle = backgroundColor.labelColor.getRgbaColor()
    // ctx.fillStyle = backgroundColor.labelColor.getRgbaColor()
    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset);

    if (gaugeType == GaugeTypeEnum.TYPE1 || gaugeType == GaugeTypeEnum.TYPE2) {
      TEXT_WIDTH = imageWidth * 0.1;
      fontSize = fontSize * 0.75;
    }

    if (tickLabelOrientation == TickLabelOrientationEnum.HORIZONTAL || tickLabelOrientation == TickLabelOrientationEnum.TANGENT) {
      TEXT_TRANSLATE_X = imageWidth * 0.26;
      if (maxValue > 999) {
        fontSize *= 0.7;
      }
    }

    final TextStyle stdFont = getFont(fontSize, backgroundColor.labelColor);

    for (double i = minValue; double.parse(i.toStringAsFixed(2)) <= MAX_VALUE_ROUNDED; i += minorTickSpacing) {
      textRotationAngle = rotationStep + HALF_PI;
      majorTickCounter++;
      // Draw major tickmarks
      if (majorTickCounter == maxNoOfMinorTicks) {
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
      ctx.rotate(rotationStep);
      alpha += rotationStep;
    }

    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  //* ******************************** Private methods *********************************
  // Draw all static painting code to background
  void init(dynamic parameters) {
    bool drawFrame2 = parameters['frame'] == null ? false : parameters['frame'] as bool;
    bool drawBackground2 = parameters['background'] == null ? false : parameters['background'] as bool;
    bool drawLed = parameters['led'] == null ? false : parameters['led'] as bool;
    bool drawUserLed = parameters['userLed'] == null ? false : parameters['userLed'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;
    bool drawTrend = parameters['trend'] == null ? false : parameters['trend'] as bool;
    bool drawValue = parameters['value'] == null ? false : parameters['value'] as bool;

    calculate();

    // Create frame in frame buffer (frameBuffer)
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

    if (drawBackground2) {
      // Create bargraphtrack in background buffer (backgroundBuffer)
      drawBargraphTrackImage(backgroundContext);
    }

    // Create tickmarks in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
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

    // Create lcd background if selected in background buffer (backgroundBuffer)
    if (drawBackground2 && lcdVisible) {
      var lcdBuffer = createLcdBackgroundImage(lcdWidth, lcdHeight, lcdColor);
      backgroundContext.save();
      backgroundContext.translate(lcdPosX, lcdPosY + lcdPosYAdjust);
      backgroundContext.drawPicture(lcdBuffer);
      backgroundContext.translate(-lcdPosX, -lcdPosY - lcdPosYAdjust);
      backgroundContext.restore();
    }

    // Convert Section values into angles
    isSectionsVisible = false;
    if (useSectionColors && section != null && section.isNotEmpty) {
      isSectionsVisible = true;
      int sectionIndex = section.length;
      sectionAngles.clear();
      do {
        sectionIndex--;
        sectionAngles.add(
          SectionRange(
            start: ((section[sectionIndex].start + minValue.abs()) / (maxValue - minValue)) * degAngleRange,
            stop: ((section[sectionIndex].stop + minValue.abs()) / (maxValue - minValue)) * degAngleRange,
            color: customColorDef(
              section[sectionIndex].color,
            ),
          ),
        );
      } while (sectionIndex > 0);
    }

    // Use a gradient for the valueColor?
    isGradientVisible = false;
    if (useValueGradient && valueGradient != null) {
      // force section colors off!
      isSectionsVisible = false;
      isGradientVisible = true;
    }

    // Create an image of an active led in active led buffer (activeLedBuffer)
    if (drawValue) {
      drawActiveLed(activeLedContext, valueColor.toColorDef());
    }

    // Create foreground in foreground buffer (foregroundBuffer)
    if (drawForeground2 && foregroundVisible) {
      ui.Picture foregroundPicture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        false,
        KnobTypeEnum.STANDARD_KNOB,
        KnobStyleEnum.BLACK,
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
    double activeLedAngle = ((value - minValue) / (maxValue - minValue)) * degAngleRange;
    ColorDef activeLedColor;
    ColorDef lastActiveLedColor = valueColor.toColorDef();
    //   let angle
    //   let i
    //   let currentValue
    //   let gradRange
    //   let fraction

    init({
      'frame': true,
      'background': true,
      'led': true,
      'userLed': true,
      'value': true,
      'trend': true,
      'foreground': true,
    });

    // Draw frame image
    if (frameVisible) {
      ui.Picture picture = frameContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw buffered image to visible canvas
    ui.Picture picture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(picture);

    ui.Picture? activeLedPicture;

    // Draw active leds
    for (double angle = 0; angle <= activeLedAngle; angle += 5) {
      // check for LED color
      activeLedColor = valueColor.toColorDef();
      // Use a gradient for value colors?
      if (isGradientVisible) {
        // Convert angle back to value
        double currentValue = minValue + (angle / degAngleRange) * (maxValue - minValue);
        double gradRange = valueGradient!.getEnd() - valueGradient.getStart();
        double fraction = (currentValue - minValue) / gradRange;
        fraction = math.max(math.min(fraction, 1), 0);
        activeLedColor = customColorDef(valueGradient.getColorAt(fraction));
      } else if (isSectionsVisible) {
        for (int i = 0; i < sectionAngles.length; i++) {
          if (angle >= sectionAngles[i].start && angle < sectionAngles[i].stop) {
            activeLedColor = sectionAngles[i].color;
            break;
          }
        }
      }
      // Has LED color changed? If so redraw the buffer
      if (lastActiveLedColor.medium != activeLedColor.medium) {
        activeLedContextRecorder = ui.PictureRecorder();
        activeLedContext = Canvas(activeLedContextRecorder);

        drawActiveLed(activeLedContext, activeLedColor);
        lastActiveLedColor = activeLedColor;
        activeLedPicture = null;
      }

      activeLedPicture ??= activeLedContextRecorder.endRecording();
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(angle * RAD_FACTOR + bargraphOffset);
      canvas.translate(-centerX, -centerY);

      canvas.translate(ACTIVE_LED_POS_X, ACTIVE_LED_POS_Y);
      canvas.drawPicture(activeLedPicture);
      canvas.translate(-ACTIVE_LED_POS_X, -ACTIVE_LED_POS_Y);
      canvas.restore();
    }

    // Draw lcd display
    if (lcdVisible) {
      drawLcdText(canvas, value);
    }

    // Draw led
    if (ledVisible) {
      picture = ledOn ? ledBufferOnRecorder.endRecording() : ledBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(LED_POS_X, LED_POS_Y);
      canvas.drawPicture(picture);
      canvas.translate(-LED_POS_X, -LED_POS_Y);
      canvas.restore();
    }

    // Draw user led
    if (userLedVisible) {
      picture = userLedOn ? userLedBufferOnRecorder.endRecording() : userLedBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(USER_LED_POS_X, USER_LED_POS_Y);
      canvas.drawPicture(picture);
      canvas.translate(-USER_LED_POS_X, -USER_LED_POS_Y);
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

    // Draw foreground
    if (foregroundVisible) {
      picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  // Visualize the component
  repaint();
}
