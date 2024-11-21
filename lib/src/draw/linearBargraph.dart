// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'createLcdBackgroundImage.dart';
import 'createLedImage.dart';
import 'createMeasuredValueImage.dart';
import 'definitions.dart';
import 'drawLinearBackgroundImage.dart';
import 'drawLinearForegroundImage.dart';
import 'drawLinearFrameImage.dart';
import 'drawTitleImage.dart';
import 'tools.dart';

void drawLinearBargraph(Canvas canvas, Size canvasSize, Parameters parameters) {
  double width = canvasSize.width;
  double height = canvasSize.height;
  double minValue = parameters.minValueWithDefault(0);
  double maxValue = parameters.maxValueWithDefault(100);
  List<Section>? section = parameters.section;
  bool useSectionColors = parameters.useSectionColorsWithDefault(false);
  bool niceScale = parameters.niceScaleWithDefault(true);
  double threshold = parameters.thresholdWithDefault((maxValue - minValue) / 2 + minValue);
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
  LedColorEnum ledColor = parameters.ledColorWithDefault(LedColorEnum.RED_LED);
  bool ledVisible = parameters.ledVisibleWithDefault(false);
  bool ledOn = parameters.ledOnWithDefault(false);
  bool thresholdVisible = parameters.thresholdVisibleWithDefault(true);
  bool minMeasuredValueVisible = parameters.minMeasuredValueVisibleWithDefault(false);
  bool maxMeasuredValueVisible = parameters.maxMeasuredValueVisibleWithDefault(false);
  LabelNumberFormatEnum labelNumberFormat = parameters.labelNumberFormatWithDefault(LabelNumberFormatEnum.STANDARD);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  GradientWrapper? valueGradient = parameters.valueGradient;
  bool useValueGradient = parameters.useValueGradientWithDefault(false);

  double imageWidth = width;
  double imageHeight = height;

  double value = parameters.value ?? minValue;

  // Properties
  double minMeasuredValue = parameters.minMeasuredValueWithDefault(minValue);
  double maxMeasuredValue = parameters.maxMeasuredValueWithDefault(maxValue);

  bool isSectionsVisible = false;
  bool isGradientVisible = false;
  List<SectionRange> sectionPixels = [];

  bool vertical = width <= height;

  // Constants
  double ledPosX;
  double ledPosY;
  double ledSize = ((vertical ? height : width) * 0.05).roundToDouble();
  double minMaxIndSize = ((vertical ? width : height) * 0.05).roundToDouble();
  double stdFontSize;
  double lcdFontSize;

  if (vertical) {
    ledPosX = imageWidth / 2 - ledSize / 2;
    ledPosY = 0.053 * imageHeight;
    stdFontSize = (imageHeight / 25).floorToDouble();
    lcdFontSize = (imageHeight / 21).floorToDouble();
  } else {
    ledPosX = 0.89 * imageWidth;
    ledPosY = imageHeight / 1.95 - ledSize / 2;
    stdFontSize = (imageHeight / 10).floorToDouble();
    lcdFontSize = (imageHeight / 9).floorToDouble();
  }

  // Tickmark specific private variables
  double niceMinValue = minValue;
  double niceMaxValue = maxValue;
  double niceRange = maxValue - minValue;
  double minorTickSpacing = 0;
  double majorTickSpacing = 0;
  double maxNoOfMinorTicks = 10;
  double maxNoOfMajorTicks = 10;

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
    } else {
      niceRange = maxValue - minValue;
      niceMinValue = minValue;
      niceMaxValue = maxValue;
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
  }

  // **************   Buffer creation  ********************
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
  // const activeLedBuffer = doc.createElement('canvas')
  // if (vertical) {
  //   activeLedBuffer.width = imageWidth * 0.121428
  //   activeLedBuffer.height = imageHeight * 0.012135
  // } else {
  //   activeLedBuffer.width = imageWidth * 0.012135
  //   activeLedBuffer.height = imageHeight * 0.121428
  // }
  // const activeLedContext = activeLedBuffer.getContext('2d')

  // Buffer for inactive bargraph led
  var inActiveLedContextRecorder = ui.PictureRecorder();
  var inActiveLedContext = Canvas(inActiveLedContextRecorder);
  // const inActiveLedBuffer = doc.createElement('canvas')
  // if (vertical) {
  //   inActiveLedBuffer.width = imageWidth * 0.121428
  //   inActiveLedBuffer.height = imageHeight * 0.012135
  // } else {
  //   inActiveLedBuffer.width = imageWidth * 0.012135
  //   inActiveLedBuffer.height = imageHeight * 0.121428
  // }
  // const inActiveLedContext = inActiveLedBuffer.getContext('2d')

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

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  // **************   Image creation  ********************
  void drawLcdText(Canvas ctx, double value, bool vertical) {
    ctx.save();

    if (lcdColor == LcdColorEnum.STANDARD || lcdColor == LcdColorEnum.STANDARD_GREEN) {
      // ctx.shadowColor = 'gray'
      // if (vertical) {
      //   ctx.shadowOffsetX = imageHeight * 0.003
      //   ctx.shadowOffsetY = imageHeight * 0.003
      //   ctx.shadowBlur = imageHeight * 0.004
      // } else {
      //   ctx.shadowOffsetX = imageHeight * 0.007
      //   ctx.shadowOffsetY = imageHeight * 0.007
      //   ctx.shadowBlur = imageHeight * 0.009
      // }
    }

    double lcdTextX;
    double lcdTextY;
    double lcdTextWidth;
    TextStyle font = getFont(fontType == FontTypeEnum.LCDMono ? lcdFontSize : stdFontSize, lcdColor.textColor, fontType: fontType);

    if (vertical) {
      lcdTextWidth = imageWidth * 0.571428;
    } else {
      lcdTextWidth = imageWidth * 0.18;
    }

    var textSpan = TextSpan(
      text: value.toStringAsFixed(lcdDecimals),
      style: font,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: vertical ? TextAlign.center : TextAlign.right,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout(
      minWidth: lcdTextWidth,
      maxWidth: lcdTextWidth,
    );

    if (vertical) {
      //lcdTextX = (imageWidth - imageWidth * 0.571428) / 2 + imageWidth * 0.571428 - 2;
      lcdTextX = (imageWidth - imageWidth * 0.571428) / 2;
      //lcdTextY = imageHeight * 0.875;
      lcdTextY = imageHeight * 0.88 + imageHeight * 0.055 / 2 - textPainter.height / 2;
    } else {
      lcdTextX = imageWidth * 0.695 - 5;
      //lcdTextY = imageHeight * 0.225 - (fontType == FontTypeEnum.LCDMono ? 2 : 0);
      lcdTextY = imageHeight * 0.22 + imageHeight * 0.15 / 2 - textPainter.height / 2;
    }

    textPainter.paint(ctx, Offset(lcdTextX, lcdTextY));
    ctx.restore();
  }

  ui.Picture createThresholdImage(bool vertical) {
    var thresholdCtxtRecorder = ui.PictureRecorder();
    var thresholdCtx = Canvas(thresholdCtxtRecorder);

    double thresholdBufferHeight = minMaxIndSize;
    double thresholdBufferWidth = minMaxIndSize;

    thresholdCtx.save();

    Path path = Path();
    if (vertical) {
      path.moveTo(0.1, thresholdBufferHeight * 0.5);
      path.lineTo(thresholdBufferWidth * 0.9, 0.1);
      path.lineTo(thresholdBufferWidth * 0.9, thresholdBufferHeight * 0.9);
      path.close();
    } else {
      path.moveTo(0.1, 0.1);
      path.lineTo(thresholdBufferWidth * 0.9, 0.1);
      path.lineTo(thresholdBufferWidth * 0.5, thresholdBufferHeight * 0.9);
      path.close();
    }

    ui.Gradient gradThreshold = ui.Gradient.linear(
      const Offset(0, 0.1),
      Offset(0, thresholdBufferHeight * 0.9),
      [
        colorFromHex('#520000'),
        colorFromHex('#fc1d00'),
        colorFromHex('#fc1d00'),
        colorFromHex('#520000'),
      ],
      [0, 0.3, 0.59, 1],
    );

    thresholdCtx.drawPath(
        path,
        Paint()
          ..shader = gradThreshold
          ..style = ui.PaintingStyle.fill);
    thresholdCtx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#FFFFFF')
          ..style = ui.PaintingStyle.stroke);

    thresholdCtx.restore();
    return thresholdCtxtRecorder.endRecording();
  }

  void drawLinearTicks(
    Canvas ctx,
    double tickStart,
    double tickStop,
    double currentPos,
    bool vertical,
    Color color,
    double strokeWidth,
  ) {
    if (vertical) {
      // Vertical orientation
      Path path = Path();
      path.moveTo(tickStart, currentPos);
      path.lineTo(tickStop, currentPos);
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..color
            ..strokeWidth = strokeWidth
            ..style = ui.PaintingStyle.stroke);
    } else {
      // Horizontal orientation
      Path path = Path();
      path.moveTo(currentPos, tickStart);
      path.lineTo(currentPos, tickStop);
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..color
            ..strokeWidth = strokeWidth
            ..style = ui.PaintingStyle.stroke);
    }
  }

  void drawTickmarksImage(Canvas ctx, LabelNumberFormatEnum labelNumberFormat, bool vertical) {
    ctx.save();

    double TEXT_WIDTH = imageWidth * 0.3;
    double valueCounter = minValue;
    double majorTickCounter = maxNoOfMinorTicks - 1;
    double tickCounter;
    double currentPos;
    double scaleBoundsX;
    double scaleBoundsY;
    double scaleBoundsW;
    double scaleBoundsH;
    double tickSpaceScaling = 1;

    double minorTickStart;
    double minorTickStop;
    double mediumTickStart;
    double mediumTickStop;
    double majorTickStart;
    double majorTickStop;

    late TextStyle stdFont;

    if (vertical) {
      minorTickStart = 0.34 * imageWidth;
      minorTickStop = 0.36 * imageWidth;
      mediumTickStart = 0.33 * imageWidth;
      mediumTickStop = 0.36 * imageWidth;
      majorTickStart = 0.32 * imageWidth;
      majorTickStop = 0.36 * imageWidth;
      //ctx.textAlign = 'right'
      scaleBoundsX = 0;
      scaleBoundsY = imageHeight * 0.12864;
      scaleBoundsW = 0;
      scaleBoundsH = imageHeight * 0.856796 - imageHeight * 0.12864;
      tickSpaceScaling = scaleBoundsH / (maxValue - minValue);

      stdFont = getFont(stdFontSize * 0.45, backgroundColor.labelColor);
    } else {
      minorTickStart = 0.65 * imageHeight;
      minorTickStop = 0.63 * imageHeight;
      mediumTickStart = 0.66 * imageHeight;
      mediumTickStop = 0.63 * imageHeight;
      majorTickStart = 0.67 * imageHeight;
      majorTickStop = 0.63 * imageHeight;

      scaleBoundsX = imageWidth * 0.142857;
      scaleBoundsY = 0;
      scaleBoundsW = imageWidth * 0.871012 - imageWidth * 0.142857;
      scaleBoundsH = 0;
      tickSpaceScaling = scaleBoundsW / (maxValue - minValue);

      stdFont = getFont(stdFontSize * 0.65, backgroundColor.labelColor);
    }

    double labelCounter = minValue;
    tickCounter = 0;
    for (; labelCounter <= maxValue; labelCounter += minorTickSpacing, tickCounter += minorTickSpacing) {
      // Calculate the bounds of the scaling
      if (vertical) {
        currentPos = scaleBoundsY + scaleBoundsH - tickCounter * tickSpaceScaling;
      } else {
        currentPos = scaleBoundsX + tickCounter * tickSpaceScaling;
      }

      majorTickCounter++;

      // Draw tickmark every major tickmark spacing
      if (majorTickCounter == maxNoOfMinorTicks) {
        // Draw the major tickmarks

        drawLinearTicks(
          ctx,
          majorTickStart,
          majorTickStop,
          currentPos,
          vertical,
          backgroundColor.labelColor,
          1.5,
        );

        // Draw the standard tickmark labels
        if (vertical) {
          // Vertical orientation
          switch (labelNumberFormat) {
            case LabelNumberFormatEnum.FRACTIONAL:
              var textSpan = TextSpan(
                text: valueCounter.toStringAsFixed(2),
                style: stdFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: TEXT_WIDTH,
              );
              textPainter.paint(ctx, Offset(imageWidth * 0.28 - textPainter.size.width / 1.25, currentPos - textPainter.size.height / 2));
              break;

            case LabelNumberFormatEnum.SCIENTIFIC:
              var textSpan = TextSpan(
                text: valueCounter.toStringAsPrecision(2),
                style: stdFont,
              );
              final textPainter = TextPainter(
                text: textSpan,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: TEXT_WIDTH,
              );
              textPainter.paint(ctx, Offset(imageWidth * 0.28 - textPainter.size.width / 1.25, currentPos - textPainter.size.height / 2));
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
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(
                minWidth: 0,
                maxWidth: TEXT_WIDTH,
              );
              textPainter.paint(ctx, Offset(imageWidth * 0.28 - textPainter.size.width / 1.25, currentPos - textPainter.size.height / 2));
              break;
          }
        } else {
          // Horizontal orientation
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
                maxWidth: TEXT_WIDTH,
              );
              textPainter.paint(ctx, Offset(currentPos - textPainter.size.width / 2, imageHeight * 0.73 - textPainter.size.height / 3));
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
              textPainter.paint(ctx, Offset(currentPos - textPainter.size.width / 2, imageHeight * 0.73 - textPainter.size.height / 3));

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
              textPainter.paint(ctx, Offset(currentPos - textPainter.size.width / 2, imageHeight * 0.73 - textPainter.size.height / 3));
              break;
          }
        }

        valueCounter += majorTickSpacing;
        majorTickCounter = 0;
        continue;
      }

      // Draw tickmark every minor tickmark spacing
      if (maxNoOfMinorTicks % 2 == 0 && majorTickCounter == maxNoOfMinorTicks / 2) {
        drawLinearTicks(
          ctx,
          mediumTickStart,
          mediumTickStop,
          currentPos,
          vertical,
          backgroundColor.labelColor,
          1,
        );
      } else {
        drawLinearTicks(
          ctx,
          minorTickStart,
          minorTickStop,
          currentPos,
          vertical,
          backgroundColor.labelColor,
          0.5,
        );
      }
    }

    ctx.restore();
  }

  void drawInActiveLed(Canvas ctx, double width, double height) {
    ctx.save();
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, width, height));
    path.close();
    double ledCenterX = width / 2;
    double ledCenterY = height / 2;

    var grad = ui.Gradient.radial(
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
      width / 2,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
    ctx.restore();
  }

  void drawActiveLed(Canvas ctx, ColorDef ledColor, double width, double height) {
    ctx.save();
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, width, height));
    path.close();
    double ledCenterX = width / 2;
    double ledCenterY = height / 2;
    double outerRadius;
    if (vertical) {
      outerRadius = width / 2;
    } else {
      outerRadius = height / 2;
    }
    var grad = ui.Gradient.radial(
      Offset(ledCenterX, ledCenterY),
      0,
      [
        ledColor.light,
        ledColor.dark,
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(ledCenterX, ledCenterY),
      outerRadius,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
    ctx.restore();
  }

  void drawValue(Canvas ctx, double imageWidth, double imageHeight, ui.Picture inActiveLedPicture) {
    double top; // position of max value
    double bottom; // position of min value
    Color labelColor = backgroundColor.labelColor;
    double fullSize;
    double valueBackgroundStartX;
    double valueBackgroundStartY;
    double valueBackgroundStopX;
    double valueBackgroundStopY;
    double valueBorderStartX;
    double valueBorderStartY;
    double valueBorderStopX;
    double valueBorderStopY;
    double currentValue;
    double gradRange;
    double fraction;

    // Orientation dependend definitions
    if (vertical) {
      // Vertical orientation
      top = imageHeight * 0.12864; // position of max value
      bottom = imageHeight * 0.856796; // position of min value
      fullSize = bottom - top;
      valueBackgroundStartX = 0;
      valueBackgroundStartY = top;
      valueBackgroundStopX = 0;
      valueBackgroundStopY = top + fullSize * 1.014;
    } else {
      // Horizontal orientation
      top = imageWidth * 0.856796; // position of max value
      bottom = imageWidth * 0.12864;
      fullSize = top - bottom;
      valueBackgroundStartX = imageWidth * 0.13;
      valueBackgroundStartY = imageHeight * 0.435714;
      valueBackgroundStopX = valueBackgroundStartX + fullSize * 1.035;
      valueBackgroundStopY = valueBackgroundStartY;
    }

    double darker = backgroundColor == BackgroundColorEnum.CARBON || backgroundColor == BackgroundColorEnum.PUNCHED_SHEET || backgroundColor == BackgroundColorEnum.STAINLESS || backgroundColor == BackgroundColorEnum.BRUSHED_STAINLESS || backgroundColor == BackgroundColorEnum.TURNED ? 0.3 : 0;

    ui.Gradient valueBackgroundTrackGradient = ui.Gradient.linear(
      Offset(valueBackgroundStartX, valueBackgroundStartY),
      Offset(valueBackgroundStopX, valueBackgroundStopY),
      [
        labelColor.withOpacity(0.047058 + darker),
        labelColor.withOpacity(0.145098 + darker),
        labelColor.withOpacity(0.149019 + darker),
        labelColor.withOpacity(0.047058 + darker),
      ],
      [0, 0.48, 0.49, 1],
    );

    if (vertical) {
      Path path = Path();
      path.addRect(Rect.fromLTWH(imageWidth * 0.435714, top, imageWidth * 0.15, fullSize * 1.014));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBackgroundTrackGradient
            ..style = ui.PaintingStyle.fill);
    } else {
      Path path = Path();
      path.addRect(Rect.fromLTWH(valueBackgroundStartX, valueBackgroundStartY, fullSize * 1.035, imageHeight * 0.152857));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBackgroundTrackGradient
            ..style = ui.PaintingStyle.fill);
    }

    if (vertical) {
      // Vertical orientation
      valueBorderStartX = 0;
      valueBorderStartY = top;
      valueBorderStopX = 0;
      valueBorderStopY = top + fullSize * 1.014;
    } else {
      // Horizontal orientation                ;
      valueBorderStartX = valueBackgroundStartX;
      valueBorderStartY = 0;
      valueBorderStopX = valueBackgroundStopX;
      valueBorderStopY = 0;
    }

    ui.Gradient valueBorderGradient = ui.Gradient.linear(
      Offset(valueBorderStartX, valueBorderStartY),
      Offset(valueBorderStopX, valueBorderStopY),
      [
        labelColor.withOpacity(0.298039 + darker),
        labelColor.withOpacity(0.686274 + darker),
        labelColor.withOpacity(0.698039 + darker),
        labelColor.withOpacity(0.4 + darker),
      ],
      [0, 0.48, 0.49, 1],
    );

    if (vertical) {
      Path path = Path();
      path.addRect(Rect.fromLTWH(imageWidth * 0.435714, top, imageWidth * 0.007142, fullSize * 1.014));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBorderGradient
            ..style = ui.PaintingStyle.fill);
      path = Path();
      path.addRect(Rect.fromLTWH(imageWidth * 0.571428, top, imageWidth * 0.007142, fullSize * 1.014));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBorderGradient
            ..style = ui.PaintingStyle.fill);
    } else {
      Path path = Path();
      path.addRect(Rect.fromLTWH(imageWidth * 0.13, imageHeight * 0.435714, fullSize * 1.035, imageHeight * 0.007142));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBorderGradient
            ..style = ui.PaintingStyle.fill);
      path = Path();
      path.addRect(Rect.fromLTWH(imageWidth * 0.13, imageHeight * 0.571428, fullSize * 1.035, imageHeight * 0.007142));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBorderGradient
            ..style = ui.PaintingStyle.fill);
    }

    // Prepare led specific variables
    double ledX;
    double ledY;
    double ledW;
    double ledH;
    double activeLeds;
    double inactiveLeds;
    if (vertical) {
      // VERTICAL
      ledX = imageWidth * 0.45;
      ledY = imageHeight * 0.851941;
      ledW = imageWidth * 0.121428;
      ledH = imageHeight * 0.012135;
    } else {
      // HORIZONTAL
      ledX = imageWidth * 0.142857;
      ledY = imageHeight * 0.45;
      ledW = imageWidth * 0.012135;
      ledH = imageHeight * 0.121428;
    }

    double translateX;
    double translateY;
    ColorDef activeLedColor;
    ColorDef lastActiveLedColor = valueColor.toColorDef();
    ui.Picture? activeLedPicture;

    // Draw the value
    if (vertical) {
      // Draw the inactive leds
      inactiveLeds = fullSize;
      for (translateY = 0; translateY <= inactiveLeds; translateY += ledH + 1) {
        ctx.translate(0, -translateY);
        ctx.translate(ledX, ledY);
        ctx.drawPicture(inActiveLedPicture);
        ctx.translate(-ledX, -ledY);
        ctx.translate(0, translateY);
      }
      // Draw the active leds in dependence on the current value
      activeLeds = ((value - minValue) / (maxValue - minValue)) * fullSize;
      for (translateY = 0; translateY <= activeLeds; translateY += ledH + 1) {
        // check for LED color
        activeLedColor = valueColor.toColorDef();
        // Use a gradient for value colors?
        if (isGradientVisible) {
          // Convert pixel back to value
          currentValue = minValue + (translateY / fullSize) * (maxValue - minValue);
          gradRange = valueGradient!.end - valueGradient.start;
          fraction = (currentValue - minValue) / gradRange;
          fraction = math.max(math.min(fraction, 1), 0);
          activeLedColor = customColorDef(valueGradient.getColorAt(fraction));
        } else if (isSectionsVisible) {
          for (int i = 0; i < sectionPixels.length; i++) {
            if (translateY >= sectionPixels[i].start && translateY < sectionPixels[i].stop) {
              activeLedColor = sectionPixels[i].color;
              break;
            }
          }
        }
        // Has LED color changed? If so redraw the buffer
        if (lastActiveLedColor.medium != activeLedColor.medium) {
          activeLedContextRecorder = ui.PictureRecorder();
          activeLedContext = Canvas(activeLedContextRecorder);

          double activeLedWidth;
          double activeLedHeight;

          if (vertical) {
            activeLedWidth = imageWidth * 0.121428;
            activeLedHeight = imageHeight * 0.012135;
          } else {
            activeLedWidth = imageWidth * 0.012135;
            activeLedHeight = imageHeight * 0.121428;
          }

          drawActiveLed(activeLedContext, activeLedColor, activeLedWidth, activeLedHeight);
          lastActiveLedColor = activeLedColor;
          activeLedPicture = null;
        }

        // Draw LED
        activeLedPicture ??= activeLedContextRecorder.endRecording();
        ctx.translate(0, -translateY);
        ctx.translate(ledX, ledY);
        ctx.drawPicture(activeLedPicture);
        ctx.translate(-ledX, -ledY);
        ctx.translate(0, translateY);
      }
    } else {
      // Draw the inactive leds
      inactiveLeds = fullSize;
      for (translateX = -(ledW / 2); translateX <= inactiveLeds; translateX += ledW + 1) {
        ctx.translate(translateX, 0);
        ctx.translate(ledX, ledY);
        ctx.drawPicture(inActiveLedPicture);
        ctx.translate(-ledX, -ledY);
        ctx.translate(-translateX, 0);
      }
      // Draw the active leds in dependence on the current value
      activeLeds = ((value - minValue) / (maxValue - minValue)) * fullSize;
      for (translateX = -(ledW / 2); translateX <= activeLeds; translateX += ledW + 1) {
        // check for LED color
        activeLedColor = valueColor.toColorDef();
        if (isGradientVisible) {
          // Convert pixel back to value
          currentValue = minValue + (translateX / fullSize) * (maxValue - minValue);
          gradRange = valueGradient!.end - valueGradient.start;
          fraction = (currentValue - minValue) / gradRange;
          fraction = math.max(math.min(fraction, 1), 0);
          activeLedColor = customColorDef(valueGradient.getColorAt(fraction));
        } else if (isSectionsVisible) {
          for (int i = 0; i < sectionPixels.length; i++) {
            if (translateX >= sectionPixels[i].start && translateX < sectionPixels[i].stop) {
              activeLedColor = sectionPixels[i].color;
              break;
            }
          }
        }
        // Has LED color changed? If so redraw the buffer
        if (lastActiveLedColor.medium != activeLedColor.medium) {
          activeLedContextRecorder = ui.PictureRecorder();
          activeLedContext = Canvas(activeLedContextRecorder);

          double activeLedWidth;
          double activeLedHeight;

          if (vertical) {
            activeLedWidth = imageWidth * 0.121428;
            activeLedHeight = imageHeight * 0.012135;
          } else {
            activeLedWidth = imageWidth * 0.012135;
            activeLedHeight = imageHeight * 0.121428;
          }

          drawActiveLed(activeLedContext, activeLedColor, activeLedWidth, activeLedHeight);
          lastActiveLedColor = activeLedColor;
          activeLedPicture = null;
        }

        // Draw LED
        activeLedPicture ??= activeLedContextRecorder.endRecording();
        ctx.translate(translateX, 0);
        ctx.translate(ledX, ledY);
        ctx.drawPicture(activeLedPicture);
        ctx.translate(-ledX, -ledY);
        ctx.translate(-translateX, 0);
      }
    }
  }

  // **************   Initialization  ********************
  void init(dynamic parameters) {
    bool drawFrame2 = parameters['frame'] == null ? false : parameters['frame'] as bool;
    bool drawBackground2 = parameters['background'] == null ? false : parameters['background'] as bool;
    bool drawLed = parameters['led'] == null ? false : parameters['led'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;
    bool drawBargraphLed = parameters['bargraphled'] == null ? false : parameters['bargraphled'] as bool;

    // Calculate the current min and max values and the range
    calculate();

    // Create frame in frame buffer (backgroundBuffer)
    if (drawFrame2 && frameVisible) {
      ui.Picture picture = drawLinearFrameImage(
        frameDesign,
        imageWidth,
        imageHeight,
        vertical,
      );
      frameContext.drawPicture(picture);
    }

    // Create background in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
      ui.Picture picture = drawLinearBackgroundImage(
        backgroundColor,
        imageWidth,
        imageHeight,
        vertical,
      );
      backgroundContext.drawPicture(picture);
    }

    if (drawLed) {
      if (vertical) {
        // Draw LED ON in ledBuffer_ON
        ui.Picture ledOnPicture = createLedImage(ledSize, 1, ledColor);
        ledContextOn.drawPicture(ledOnPicture);

        // Draw LED OFF in ledBuffer_OFF
        ui.Picture ledOffPicture = createLedImage(ledSize, 0, ledColor);
        ledContextOff.drawPicture(ledOffPicture);
      } else {
        // Draw LED ON in ledBuffer_ON
        ui.Picture ledOnPicture = createLedImage(ledSize, 1, ledColor);
        ledContextOn.drawPicture(ledOnPicture);

        // Draw LED OFF in ledBuffer_OFF
        ui.Picture ledOffPicture = createLedImage(ledSize, 0, ledColor);
        ledContextOff.drawPicture(ledOffPicture);
      }
    }

    // Draw min measured value indicator in minMeasuredValueBuffer
    if (minMeasuredValueVisible) {
      if (vertical) {
        minMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(minMaxIndSize, ColorEnum.BLUE.dark, false, vertical),
        );
      } else {
        minMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(minMaxIndSize, ColorEnum.BLUE.dark, false, vertical),
        );
      }
    }

    // Draw max measured value indicator in maxMeasuredValueBuffer
    if (maxMeasuredValueVisible) {
      if (vertical) {
        maxMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(minMaxIndSize, ColorEnum.RED.medium, false, vertical),
        );
      } else {
        maxMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(minMaxIndSize, ColorEnum.RED.medium, false, vertical),
        );
      }
    }

    // Create alignment posts in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
      double valuePos;
      // Create tickmarks in background buffer (backgroundBuffer)
      drawTickmarksImage(backgroundContext, labelNumberFormat, vertical);

      // Draw threshold image to background context
      if (thresholdVisible) {
        backgroundContext.save();
        if (vertical) {
          // Vertical orientation
          valuePos = imageHeight * 0.856796 - (imageHeight * 0.728155 * (threshold - minValue)) / (maxValue - minValue);
          backgroundContext.translate(imageWidth * 0.365, valuePos - minMaxIndSize / 2);
        } else {
          // Horizontal orientation
          valuePos = ((imageWidth * 0.856796 - imageWidth * 0.12864) * (threshold - minValue)) / (maxValue - minValue);
          backgroundContext.translate(imageWidth * 0.142857 - minMaxIndSize / 2 + valuePos, imageHeight * 0.58);
        }
        ui.Picture picture = createThresholdImage(vertical);
        backgroundContext.drawPicture(picture);
        backgroundContext.restore();
      }

      // Create title in background buffer (backgroundBuffer)
      if (vertical) {
        drawTitleImage(
          backgroundContext,
          imageWidth,
          imageHeight,
          titleString,
          unitString,
          backgroundColor,
          vertical,
          false,
          lcdVisible,
          GaugeTypeEnum.TYPE1,
        );
      } else {
        drawTitleImage(
          backgroundContext,
          imageWidth,
          imageHeight,
          titleString,
          unitString,
          backgroundColor,
          vertical,
          false,
          lcdVisible,
          GaugeTypeEnum.TYPE1,
        );
      }
    }

    // Create lcd background if selected in background buffer (backgroundBuffer)
    if (drawBackground2 && lcdVisible) {
      if (vertical) {
        ui.Picture picture = createLcdBackgroundImage(imageWidth * 0.571428, imageHeight * 0.055, lcdColor);
        backgroundContext.translate((imageWidth - imageWidth * 0.571428) / 2, imageHeight * 0.88);
        backgroundContext.drawPicture(picture);
        backgroundContext.translate(-(imageWidth - imageWidth * 0.571428) / 2, -imageHeight * 0.88);
      } else {
        ui.Picture picture = createLcdBackgroundImage(imageWidth * 0.18, imageHeight * 0.15, lcdColor);
        backgroundContext.translate(imageWidth * 0.695, imageHeight * 0.22);
        backgroundContext.drawPicture(picture);
        backgroundContext.translate(-imageWidth * 0.695, -imageHeight * 0.22);
      }
    }

    // Draw leds of bargraph
    if (drawBargraphLed) {
      if (vertical) {
        drawInActiveLed(inActiveLedContext, imageWidth * 0.121428, imageHeight * 0.012135);
        drawActiveLed(activeLedContext, valueColor.toColorDef(), imageWidth * 0.121428, imageHeight * 0.012135);
      } else {
        drawInActiveLed(inActiveLedContext, imageWidth * 0.012135, imageHeight * 0.121428);
        drawActiveLed(activeLedContext, valueColor.toColorDef(), imageWidth * 0.012135, imageHeight * 0.121428);
      }
    }

    // Convert Section values into pixels
    isSectionsVisible = false;
    if (useSectionColors && section != null && section.isNotEmpty) {
      isSectionsVisible = true;
      int sectionIndex = section.length;
      double top;
      double bottom;
      double fullSize;
      double ledWidth2;

      if (vertical) {
        // Vertical orientation
        top = imageHeight * 0.12864; // position of max value
        bottom = imageHeight * 0.856796; // position of min value
        fullSize = bottom - top;
        ledWidth2 = 0;
      } else {
        // Horizontal orientation
        top = imageWidth * 0.856796; // position of max value
        bottom = imageWidth * 0.12864;
        fullSize = top - bottom;
        ledWidth2 = (imageWidth * 0.012135) / 2;
      }
      sectionPixels = [];
      do {
        sectionIndex--;
        sectionPixels.add(SectionRange(
          start: ((section[sectionIndex].start + minValue.abs()) / (maxValue - minValue)) * fullSize - ledWidth2,
          stop: ((section[sectionIndex].stop + minValue.abs()) / (maxValue - minValue)) * fullSize - ledWidth2,
          color: customColorDef(section[sectionIndex].color),
        ));
      } while (sectionIndex > 0);
    }

    // Use a gradient for the valueColor?
    isGradientVisible = false;
    if (useValueGradient && valueGradient != null) {
      // force section colors off!
      isSectionsVisible = false;
      isGradientVisible = true;
    }

    // Create foreground in foreground buffer (foregroundBuffer)
    if (drawForeground2 && foregroundVisible) {
      ui.Picture picture = drawLinearForegroundImage(
        imageWidth,
        imageHeight,
        vertical,
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
      'bargraphled': true,
    });

    // mainCtx.save();

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

    // Draw lcd display
    if (lcdVisible) {
      drawLcdText(canvas, value, vertical);
    }

    // Draw led
    if (ledVisible) {
      ui.Picture picture = ledOn ? ledBufferOnRecorder.endRecording() : ledBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(ledPosX, ledPosY);
      canvas.drawPicture(picture);
      canvas.translate(-ledPosX, -ledPosY);
      canvas.restore();
    }

    double valuePos;
    double minMaxX;
    double minMaxY;
    // Draw min measured value indicator
    if (minMeasuredValueVisible) {
      if (vertical) {
        valuePos = imageHeight * 0.856796 - (imageHeight * 0.728155 * (minMeasuredValue - minValue)) / (maxValue - minValue);
        minMaxX = imageWidth * 0.34 - minMaxIndSize;
        minMaxY = valuePos - minMaxIndSize / 2;
      } else {
        valuePos = ((imageWidth * 0.856796 - imageWidth * 0.12864) * (minMeasuredValue - minValue)) / (maxValue - minValue);
        minMaxX = imageWidth * 0.142857 - minMaxIndSize / 2 + valuePos;
        minMaxY = imageHeight * 0.65;
      }
      ui.Picture picture = minMeasuredValueBufferRecorder.endRecording();
      canvas.translate(minMaxX, minMaxY);
      canvas.drawPicture(picture);
      canvas.translate(-minMaxX, -minMaxY);
    }

    // Draw max measured value indicator
    if (maxMeasuredValueVisible) {
      if (vertical) {
        valuePos = imageHeight * 0.856796 - (imageHeight * 0.728155 * (maxMeasuredValue - minValue)) / (maxValue - minValue);
        minMaxX = imageWidth * 0.34 - minMaxIndSize;
        minMaxY = valuePos - minMaxIndSize / 2;
      } else {
        valuePos = ((imageWidth * 0.856796 - imageWidth * 0.12864) * (maxMeasuredValue - minValue)) / (maxValue - minValue);
        minMaxX = imageWidth * 0.142857 - minMaxIndSize / 2 + valuePos;
        minMaxY = imageHeight * 0.65;
      }
      ui.Picture picture = maxMeasuredValueBufferRecorder.endRecording();
      canvas.translate(minMaxX, minMaxY);
      canvas.drawPicture(picture);
      canvas.translate(-minMaxX, -minMaxY);
    }

    canvas.save();
    ui.Picture inActiveLed = inActiveLedContextRecorder.endRecording();
    drawValue(canvas, imageWidth, imageHeight, inActiveLed);
    canvas.restore();

    // Draw foreground
    if (foregroundVisible) {
      ui.Picture picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  // Visualize the component
  repaint();
}
