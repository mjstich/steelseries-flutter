// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;

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

void drawLinear(Canvas canvas, Size canvasSize, Parameters parameters) {
  GaugeTypeEnum gaugeType =
      parameters.gaugeTypeWithDefault(GaugeTypeEnum.TYPE1);

  double width = canvasSize.width;
  double height = canvasSize.height;
  double minValue = parameters.minValueWithDefault(0);
  double maxValue = parameters.maxValueWithDefault(100);
  bool niceScale = parameters.niceScaleWithDefault(true);
  double threshold =
      parameters.thresholdWithDefault((maxValue - minValue) / 2 + minValue);
  bool thresholdVisible = parameters.thresholdVisibleWithDefault(true);
  String titleString = parameters.titleStringWithDefault('');
  String unitString = parameters.unitStringWithDefault('');
  FrameDesignEnum frameDesign =
      parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor =
      parameters.backgroundColorWithDefault(BackgroundColorEnum.DARK_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  ColorEnum valueColor = parameters.valueColorWithDefault(ColorEnum.RED);
  LcdColorEnum lcdColor = parameters.lcdColorWithDefault(LcdColorEnum.STANDARD);
  bool lcdVisible = parameters.lcdVisibleWithDefault(true);
  int lcdDecimals = parameters.lcdDecimalsWithDefault(1);
  FontTypeEnum fontType =
      parameters.fontTypeWithDefault(FontTypeEnum.RobotoMono);
  LedColorEnum ledColor = parameters.ledColorWithDefault(LedColorEnum.RED_LED);
  bool ledVisible = parameters.ledVisibleWithDefault(false);
  bool ledOn = parameters.ledOnWithDefault(false);
  bool minMeasuredValueVisible =
      parameters.minMeasuredValueVisibleWithDefault(false);
  bool maxMeasuredValueVisible =
      parameters.maxMeasuredValueVisibleWithDefault(false);
  LabelNumberFormatEnum labelNumberFormat =
      parameters.labelNumberFormatWithDefault(LabelNumberFormatEnum.STANDARD);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);

  double imageWidth = width;
  double imageHeight = height;

  double value = parameters.value ?? minValue;

  // Properties
  double minMeasuredValue = parameters.minMeasuredValueWithDefault(minValue);
  double maxMeasuredValue = parameters.maxMeasuredValueWithDefault(maxValue);

  // Check gaugeType is 1 or 2
  if (gaugeType != GaugeTypeEnum.TYPE1 && gaugeType != GaugeTypeEnum.TYPE2) {
    gaugeType = GaugeTypeEnum.TYPE1;
  }

  bool vertical = width <= height;

  // Constants
  double ledPosX;
  double ledPosY;
  double ledSize = ((vertical ? height : width) * 0.05).roundToDouble();
  double minMaxIndSize = ((vertical ? width : height) * 0.05).roundToDouble();
  double stdFontSize;
  double lcdFontSize;

  // Misc
  if (vertical) {
    ledPosX = imageWidth / 2 - ledSize / 2;
    ledPosY = (gaugeType == GaugeTypeEnum.TYPE1 ? 0.053 : 0.038) * imageHeight;
    stdFontSize = (imageHeight / 25).floorToDouble();
    lcdFontSize = (imageHeight / 21).floorToDouble();
  } else {
    ledPosX = 0.89 * imageWidth;
    ledPosY = imageHeight / 2 - ledSize / 2;
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
      niceMinValue =
          (minValue / majorTickSpacing).floorToDouble() * majorTickSpacing;
      niceMaxValue =
          (maxValue / majorTickSpacing).ceilToDouble() * majorTickSpacing;
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

    if (lcdColor == LcdColorEnum.STANDARD ||
        lcdColor == LcdColorEnum.STANDARD_GREEN) {
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
    TextStyle font = getFont(
        fontType == FontTypeEnum.LCDMono ? lcdFontSize : stdFontSize,
        lcdColor.textColor,
        fontType: fontType);

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
      lcdTextY =
          imageHeight * 0.88 + imageHeight * 0.055 / 2 - textPainter.height / 2;
    } else {
      lcdTextX = imageWidth * 0.695 - 5;
      //lcdTextY = imageHeight * 0.225 - (fontType == FontTypeEnum.LCDMono ? 2 : 0);
      lcdTextY =
          imageHeight * 0.22 + imageHeight * 0.15 / 2 - textPainter.height / 2;
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

  void drawTickmarksImage(
      Canvas ctx, LabelNumberFormatEnum labelNumberFormat, bool vertical) {
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
      if (gaugeType == GaugeTypeEnum.TYPE1) {
        scaleBoundsH = imageHeight * 0.856796 - imageHeight * 0.12864;
      } else {
        scaleBoundsH = imageHeight * 0.7475 - imageHeight * 0.12864;
      }
      tickSpaceScaling = scaleBoundsH / (maxValue - minValue);

      stdFont = getFont(stdFontSize * 0.45, backgroundColor.labelColor);
    } else {
      minorTickStart = 0.65 * imageHeight;
      minorTickStop = 0.63 * imageHeight;
      mediumTickStart = 0.66 * imageHeight;
      mediumTickStop = 0.63 * imageHeight;
      majorTickStart = 0.67 * imageHeight;
      majorTickStop = 0.63 * imageHeight;
      //ctx.textAlign = 'center'
      scaleBoundsY = 0;
      if (gaugeType == GaugeTypeEnum.TYPE1) {
        scaleBoundsX = imageWidth * 0.142857;
        scaleBoundsW = imageWidth * 0.871012 - scaleBoundsX;
      } else {
        scaleBoundsX = imageWidth * 0.19857;
        scaleBoundsW = imageWidth * 0.82 - scaleBoundsX;
      }
      scaleBoundsH = 0;
      tickSpaceScaling = scaleBoundsW / (maxValue - minValue);

      stdFont = getFont(stdFontSize * 0.65, backgroundColor.labelColor);
    }

    double labelCounter = minValue;
    tickCounter = 0;
    for (;
        labelCounter <= maxValue;
        labelCounter += minorTickSpacing, tickCounter += minorTickSpacing) {
      // Calculate the bounds of the scaling
      if (vertical) {
        currentPos =
            scaleBoundsY + scaleBoundsH - tickCounter * tickSpaceScaling;
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
              textPainter.paint(
                  ctx,
                  Offset(imageWidth * 0.28 - textPainter.size.width / 1.25,
                      currentPos - textPainter.size.height / 2));
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
              textPainter.paint(
                  ctx,
                  Offset(imageWidth * 0.28 - textPainter.size.width / 1.25,
                      currentPos - textPainter.size.height / 2));
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
              textPainter.paint(
                  ctx,
                  Offset(imageWidth * 0.28 - textPainter.size.width / 1.25,
                      currentPos - textPainter.size.height / 2));
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
              textPainter.paint(
                  ctx,
                  Offset(currentPos - textPainter.size.width / 2,
                      imageHeight * 0.73 - textPainter.size.height / 3));
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
              textPainter.paint(
                  ctx,
                  Offset(currentPos - textPainter.size.width / 2,
                      imageHeight * 0.73 - textPainter.size.height / 3));

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
              textPainter.paint(
                  ctx,
                  Offset(currentPos - textPainter.size.width / 2,
                      imageHeight * 0.73 - textPainter.size.height / 3));
              break;
          }
        }

        valueCounter += majorTickSpacing;
        majorTickCounter = 0;
        continue;
      }

      // Draw tickmark every minor tickmark spacing
      if (maxNoOfMinorTicks % 2 == 0 &&
          majorTickCounter == maxNoOfMinorTicks / 2) {
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

  void drawValue(Canvas ctx, double imageWidth, double imageHeight) {
    double top; // position of max value
    double bottom; // position of min value
    Color labelColor = backgroundColor.labelColor;
    double fullSize;
    double valueSize;
    double valueTop;
    double valueStartX;
    double valueStartY;
    double valueStopX;
    double valueStopY;
    double valueBackgroundStartX;
    double valueBackgroundStartY;
    double valueBackgroundStopX;
    double valueBackgroundStopY;
    double valueBorderStartX;
    double valueBorderStartY;
    double valueBorderStopX;
    double valueBorderStopY;
    double valueForegroundStartX;
    double valueForegroundStartY;
    double valueForegroundStopX;
    double valueForegroundStopY;

    // Orientation dependend definitions
    if (vertical) {
      // Vertical orientation
      top = imageHeight * 0.12864; // position of max value
      if (gaugeType == GaugeTypeEnum.TYPE1) {
        bottom = imageHeight * 0.856796; // position of min value
      } else {
        bottom = imageHeight * 0.7475;
      }
      fullSize = bottom - top;
      valueSize = (fullSize * (value - minValue)) / (maxValue - minValue);
      valueTop = bottom - valueSize;
      valueBackgroundStartX = 0;
      valueBackgroundStartY = top;
      valueBackgroundStopX = 0;
      valueBackgroundStopY = bottom;
    } else {
      // Horizontal orientation
      if (gaugeType == GaugeTypeEnum.TYPE1) {
        top = imageWidth * 0.871012; // position of max value
        bottom = imageWidth * 0.142857; // position of min value
      } else {
        top = imageWidth * 0.82; // position of max value
        bottom = imageWidth * 0.19857; // position of min value
      }
      fullSize = top - bottom;
      valueSize = (fullSize * (value - minValue)) / (maxValue - minValue);
      valueTop = bottom;
      valueBackgroundStartX = top;
      valueBackgroundStartY = 0;
      valueBackgroundStopX = bottom;
      valueBackgroundStopY = 0;
    }
    if (gaugeType == GaugeTypeEnum.TYPE1) {
      //double darker = backgroundColor == BackgroundColorEnum.CARBON || backgroundColor == BackgroundColorEnum.PUNCHED_SHEET || backgroundColor == BackgroundColorEnum.STAINLESS || backgroundColor == BackgroundColorEnum.BRUSHED_STAINLESS || backgroundColor == BackgroundColorEnum.TURNED ? 0.3 : 0;
      double darker = backgroundColor == BackgroundColorEnum.CARBON ||
              backgroundColor == BackgroundColorEnum.PUNCHED_SHEET
          ? 0.3
          : 0;
      ui.Gradient valueBackgroundTrackGradient = ui.Gradient.linear(
        Offset(valueBackgroundStartX, valueBackgroundStartY),
        Offset(valueBackgroundStopX, valueBackgroundStopY),
        [
          labelColor.withOpacity(0.05 + darker),
          labelColor.withOpacity(0.15 + darker),
          labelColor.withOpacity(0.15 + darker),
          labelColor.withOpacity(0.05 + darker),
        ],
        [0, 0.48, 0.49, 1],
      );

      if (vertical) {
        Path path = Path();
        path.addRect(Rect.fromLTWH(
            imageWidth * 0.435714, top, imageWidth * 0.142857, fullSize));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueBackgroundTrackGradient
              ..style = ui.PaintingStyle.fill);
      } else {
        Path path = Path();
        path.addRect(Rect.fromLTWH(imageWidth * 0.142857,
            imageHeight * 0.435714, fullSize, imageHeight * 0.142857));
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
        valueBorderStopY = top + fullSize;
      } else {
        // Horizontal orientation
        valueBorderStartX = imageWidth * 0.142857 + fullSize;
        valueBorderStartY = 0;
        valueBorderStopX = imageWidth * 0.142857;
        valueBorderStopY = 0;
      }

      ui.Gradient valueBorderGradient = ui.Gradient.linear(
        Offset(valueBorderStartX, valueBorderStartY),
        Offset(valueBorderStopX, valueBorderStopY),
        [
          labelColor.withOpacity(0.03 + darker),
          labelColor.withOpacity(0.69),
          labelColor.withOpacity(0.7),
          labelColor.withOpacity(0.4),
        ],
        [0, 0.48, 0.49, 1],
      );

      // ctx.fillStyle = valueBorderGradient
      if (vertical) {
        Path path = Path();
        path.addRect(Rect.fromLTWH(
            imageWidth * 0.435714, top, imageWidth * 0.007142, fullSize));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueBorderGradient
              ..style = ui.PaintingStyle.fill);

        path = Path();
        path.addRect(Rect.fromLTWH(
            imageWidth * 0.571428, top, imageWidth * 0.007142, fullSize));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueBorderGradient
              ..style = ui.PaintingStyle.fill);
      } else {
        Path path = Path();
        path.addRect(Rect.fromLTWH(imageWidth * 0.142857,
            imageHeight * 0.435714, fullSize, imageHeight * 0.007142));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueBorderGradient
              ..style = ui.PaintingStyle.fill);

        path = Path();
        path.addRect(Rect.fromLTWH(imageWidth * 0.142857,
            imageHeight * 0.571428, fullSize, imageHeight * 0.007142));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueBorderGradient
              ..style = ui.PaintingStyle.fill);
      }
    }
    if (vertical) {
      // Vertical orientation
      if (gaugeType == GaugeTypeEnum.TYPE1) {
        valueStartX = imageWidth * 0.45;
        valueStartY = 0;
        valueStopX = imageWidth * 0.45 + imageWidth * 0.114285;
        valueStopY = 0;
      } else {
        valueStartX = imageWidth / 2 - (imageHeight * 0.0486) / 2;
        valueStartY = 0;
        valueStopX = valueStartX + imageHeight * 0.053;
        valueStopY = 0;
      }
    } else {
      // Horizontal orientation
      if (gaugeType == GaugeTypeEnum.TYPE1) {
        valueStartX = 0;
        valueStartY = imageHeight * 0.45;
        valueStopX = 0;
        valueStopY = imageHeight * 0.45 + imageHeight * 0.114285;
      } else {
        valueStartX = 0;
        valueStartY = imageHeight / 2 - imageWidth * 0.025;
        valueStopX = 0;
        valueStopY = valueStartY + imageWidth * 0.053;
      }
    }

    ui.Gradient valueBackgroundGradient = ui.Gradient.linear(
      Offset(valueStartX, valueStartY),
      Offset(valueStopX, valueStopY),
      [
        valueColor.medium,
        valueColor.light,
      ],
      [0, 1],
    );

    double thermoTweak = gaugeType == GaugeTypeEnum.TYPE1
        ? 0
        : vertical
            ? imageHeight * 0.05
            : imageWidth * 0.05;
    if (vertical) {
      Path path = Path();
      path.addRect(Rect.fromLTWH(valueStartX, valueTop,
          valueStopX - valueStartX, valueSize + thermoTweak));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBackgroundGradient
            ..style = ui.PaintingStyle.fill);
    } else {
      Path path = Path();
      path.addRect(Rect.fromLTWH(valueTop - thermoTweak, valueStartY,
          valueSize + thermoTweak, valueStopY - valueStartY));
      path.close();
      ctx.drawPath(
          path,
          Paint()
            ..shader = valueBackgroundGradient
            ..style = ui.PaintingStyle.fill);
    }

    if (gaugeType == GaugeTypeEnum.TYPE1) {
      // The light effect on the value
      if (vertical) {
        // Vertical orientation
        valueForegroundStartX = imageWidth * 0.45;
        valueForegroundStartY = 0;
        valueForegroundStopX = valueForegroundStartX + imageWidth * 0.05;
        valueForegroundStopY = 0;
      } else {
        // Horizontal orientation
        valueForegroundStartX = 0;
        valueForegroundStartY = imageHeight * 0.45;
        valueForegroundStopX = 0;
        valueForegroundStopY = valueForegroundStartY + imageHeight * 0.05;
      }

      ui.Gradient valueForegroundGradient = ui.Gradient.linear(
        Offset(valueForegroundStartX, valueForegroundStartY),
        Offset(valueForegroundStopX, valueForegroundStopY),
        [
          const Color.fromRGBO(255, 255, 255, 0.7),
          const Color.fromRGBO(255, 255, 255, 0.0),
        ],
        [0, 0.98],
      );

      if (vertical) {
        Path path = Path();
        path.addRect(Rect.fromLTWH(
            valueForegroundStartX, valueTop, valueForegroundStopX, valueSize));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueForegroundGradient
              ..style = ui.PaintingStyle.fill);
      } else {
        Path path = Path();
        path.addRect(Rect.fromLTWH(valueTop, valueForegroundStartY, valueSize,
            valueForegroundStopY - valueForegroundStartY));
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..shader = valueForegroundGradient
              ..style = ui.PaintingStyle.fill);
      }
    }
  }

  void drawForegroundImage(Canvas ctx) {
    double foreSize = vertical ? imageHeight : imageWidth;

    ctx.save();
    if (vertical) {
      ctx.translate(imageWidth / 2, 0);
    } else {
      ctx.translate(imageWidth / 2, imageHeight / 2);
      ctx.rotate(HALF_PI);
      ctx.translate(0, -imageWidth / 2 + imageWidth * 0.05);
    }

    // draw bulb
    Path path = Path();
    path.moveTo(-0.049 * foreSize, 0.825 * foreSize);
    path.cubicTo(
      -0.049 * foreSize,
      0.7975 * foreSize,
      -0.0264 * foreSize,
      0.775 * foreSize,
      0.0013 * foreSize,
      0.775 * foreSize,
    );
    path.cubicTo(
      0.0264 * foreSize,
      0.775 * foreSize,
      0.049 * foreSize,
      0.7975 * foreSize,
      0.049 * foreSize,
      0.825 * foreSize,
    );
    path.cubicTo(
      0.049 * foreSize,
      0.85 * foreSize,
      0.0264 * foreSize,
      0.8725 * foreSize,
      0.0013 * foreSize,
      0.8725 * foreSize,
    );
    path.cubicTo(
      -0.0264 * foreSize,
      0.8725 * foreSize,
      -0.049 * foreSize,
      0.85 * foreSize,
      -0.049 * foreSize,
      0.825 * foreSize,
    );
    path.close();
    ui.Gradient grad = ui.Gradient.radial(
      Offset(0 * foreSize, 0.825 * foreSize),
      0,
      [
        valueColor.medium,
        valueColor.medium,
        valueColor.light,
      ],
      <double>[0.0, 0.3, 1],
      TileMode.clamp,
      null,
      Offset(0 * foreSize, 0.825 * foreSize),
      0.049 * foreSize,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // draw bulb highlight
    path = Path();
    if (vertical) {
      path.moveTo(-0.0365 * foreSize, 0.8075 * foreSize);
      path.cubicTo(
        -0.0365 * foreSize,
        0.7925 * foreSize,
        -0.0214 * foreSize,
        0.7875 * foreSize,
        -0.0214 * foreSize,
        0.7825 * foreSize,
      );
      path.cubicTo(
        0.0189 * foreSize,
        0.785 * foreSize,
        0.0365 * foreSize,
        0.7925 * foreSize,
        0.0365 * foreSize,
        0.8075 * foreSize,
      );
      path.cubicTo(
        0.0365 * foreSize,
        0.8175 * foreSize,
        0.0214 * foreSize,
        0.815 * foreSize,
        0.0013 * foreSize,
        0.8125 * foreSize,
      );
      path.cubicTo(
        -0.0189 * foreSize,
        0.8125 * foreSize,
        -0.0365 * foreSize,
        0.8175 * foreSize,
        -0.0365 * foreSize,
        0.8075 * foreSize,
      );

      grad = ui.Gradient.radial(
        Offset(0, 0.8 * foreSize),
        0,
        [
          const Color.fromRGBO(255, 255, 255, 0.55),
          const Color.fromRGBO(255, 255, 255, 0.05),
        ],
        <double>[0.0, 1],
        TileMode.clamp,
        null,
        Offset(0, 0.8 * foreSize),
        0.0377 * foreSize,
      );
    } else {
      path.moveTo(-0.0214 * foreSize, 0.86 * foreSize);
      path.cubicTo(
        -0.0365 * foreSize,
        0.86 * foreSize,
        -0.0415 * foreSize,
        0.845 * foreSize,
        -0.0465 * foreSize,
        0.825 * foreSize,
      );
      path.cubicTo(
        -0.0465 * foreSize,
        0.805 * foreSize,
        -0.0365 * foreSize,
        0.7875 * foreSize,
        -0.0214 * foreSize,
        0.7875 * foreSize,
      );
      path.cubicTo(
        -0.0113 * foreSize,
        0.7875 * foreSize,
        -0.0163 * foreSize,
        0.8025 * foreSize,
        -0.0163 * foreSize,
        0.8225 * foreSize,
      );
      path.cubicTo(
        -0.0163 * foreSize,
        0.8425 * foreSize,
        -0.0113 * foreSize,
        0.86 * foreSize,
        -0.0214 * foreSize,
        0.86 * foreSize,
      );

      grad = ui.Gradient.radial(
        Offset(-0.03 * foreSize, 0.8225 * foreSize),
        0,
        [
          const Color.fromRGBO(255, 255, 255, 0.55),
          const Color.fromRGBO(255, 255, 255, 0.05),
        ],
        <double>[0.0, 1],
        TileMode.clamp,
        null,
        Offset(-0.03 * foreSize, 0.8225 * foreSize),
        0.0377 * foreSize,
      );
    }
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // stem highlight
    path = Path();
    path.moveTo(-0.0214 * foreSize, 0.115 * foreSize);
    path.cubicTo(
      -0.0214 * foreSize,
      0.1075 * foreSize,
      -0.0163 * foreSize,
      0.1025 * foreSize,
      -0.0113 * foreSize,
      0.1025 * foreSize,
    );
    path.cubicTo(
      -0.0113 * foreSize,
      0.1025 * foreSize,
      -0.0113 * foreSize,
      0.1025 * foreSize,
      -0.0113 * foreSize,
      0.1025 * foreSize,
    );
    path.cubicTo(
      -0.0038 * foreSize,
      0.1025 * foreSize,
      0.0013 * foreSize,
      0.1075 * foreSize,
      0.0013 * foreSize,
      0.115 * foreSize,
    );
    path.cubicTo(
      0.0013 * foreSize,
      0.115 * foreSize,
      0.0013 * foreSize,
      0.76 * foreSize,
      0.0013 * foreSize,
      0.76 * foreSize,
    );
    path.cubicTo(
      0.0013 * foreSize,
      0.7675 * foreSize,
      -0.0038 * foreSize,
      0.7725 * foreSize,
      -0.0113 * foreSize,
      0.7725 * foreSize,
    );
    path.cubicTo(
      -0.0113 * foreSize,
      0.7725 * foreSize,
      -0.0113 * foreSize,
      0.7725 * foreSize,
      -0.0113 * foreSize,
      0.7725 * foreSize,
    );
    path.cubicTo(
      -0.0163 * foreSize,
      0.7725 * foreSize,
      -0.0214 * foreSize,
      0.7675 * foreSize,
      -0.0214 * foreSize,
      0.76 * foreSize,
    );
    path.cubicTo(
      -0.0214 * foreSize,
      0.76 * foreSize,
      -0.0214 * foreSize,
      0.115 * foreSize,
      -0.0214 * foreSize,
      0.115 * foreSize,
    );
    path.close();

    grad = ui.Gradient.linear(
      Offset(-0.0189 * foreSize, 0),
      Offset(0.0013 * foreSize, 0),
      [
        const Color.fromRGBO(255, 255, 255, 0.1),
        const Color.fromRGBO(255, 255, 255, 0.5),
        const Color.fromRGBO(255, 255, 255, 0.1),
      ],
      [0, 0.34, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    ctx.restore();
  }

  void drawBackgroundImage(Canvas ctx) {
    double backSize = vertical ? imageHeight : imageWidth;
    ctx.save();
    if (vertical) {
      ctx.translate(imageWidth / 2, 0);
    } else {
      ctx.translate(imageWidth / 2, imageHeight / 2);
      ctx.rotate(HALF_PI);
      ctx.translate(0, -imageWidth / 2 + imageWidth * 0.05);
    }
    Path path = Path();
    path.moveTo(-0.0516 * backSize, 0.825 * backSize);
    path.cubicTo(
      -0.0516 * backSize,
      0.8525 * backSize,
      -0.0289 * backSize,
      0.875 * backSize,
      0.0013 * backSize,
      0.875 * backSize,
    );
    path.cubicTo(
      0.0289 * backSize,
      0.875 * backSize,
      0.0516 * backSize,
      0.8525 * backSize,
      0.0516 * backSize,
      0.825 * backSize,
    );
    path.cubicTo(
      0.0516 * backSize,
      0.8075 * backSize,
      0.044 * backSize,
      0.7925 * backSize,
      0.0314 * backSize,
      0.7825 * backSize,
    );
    path.cubicTo(
      0.0314 * backSize,
      0.7825 * backSize,
      0.0314 * backSize,
      0.12 * backSize,
      0.0314 * backSize,
      0.12 * backSize,
    );
    path.cubicTo(
      0.0314 * backSize,
      0.1025 * backSize,
      0.0189 * backSize,
      0.0875 * backSize,
      0.0013 * backSize,
      0.0875 * backSize,
    );
    path.cubicTo(
      -0.0163 * backSize,
      0.0875 * backSize,
      -0.0289 * backSize,
      0.1025 * backSize,
      -0.0289 * backSize,
      0.12 * backSize,
    );
    path.cubicTo(
      -0.0289 * backSize,
      0.12 * backSize,
      -0.0289 * backSize,
      0.7825 * backSize,
      -0.0289 * backSize,
      0.7825 * backSize,
    );
    path.cubicTo(
      -0.0415 * backSize,
      0.79 * backSize,
      -0.0516 * backSize,
      0.805 * backSize,
      -0.0516 * backSize,
      0.825 * backSize,
    );
    path.close();
    ui.Gradient grad = ui.Gradient.linear(
      Offset(-0.0163 * backSize, 0),
      Offset(0.0289 * backSize, 0),
      [
        const Color.fromRGBO(226, 226, 226, 0.5),
        const Color.fromRGBO(226, 226, 226, 0.2),
        const Color.fromRGBO(226, 226, 226, 0.5),
      ],
      [0, 0.5, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = const Color.fromRGBO(153, 153, 153, 0.5)
          ..strokeWidth = 1
          ..style = ui.PaintingStyle.stroke);

    ctx.restore();
  }

  // **************   Initialization  ********************
  void init(dynamic parameters) {
    bool drawFrame2 =
        parameters['frame'] == null ? false : parameters['frame'] as bool;
    bool drawBackground2 = parameters['background'] == null
        ? false
        : parameters['background'] as bool;
    bool drawLed =
        parameters['led'] == null ? false : parameters['led'] as bool;
    bool drawForeground2 = parameters['foreground'] == null
        ? false
        : parameters['foreground'] as bool;

    double yOffset;
    double yRange;
    double valuePos;

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

    // draw Thermometer outline
    if (drawBackground2 && gaugeType == GaugeTypeEnum.TYPE2) {
      drawBackgroundImage(backgroundContext);
    }

    if (drawLed) {
      // Draw LED ON in ledBuffer_ON
      ui.Picture ledOnPicture = createLedImage(ledSize, 1, ledColor);
      ledContextOn.drawPicture(ledOnPicture);

      // Draw LED OFF in ledBuffer_OFF
      ui.Picture ledOffPicture = createLedImage(ledSize, 0, ledColor);
      ledContextOff.drawPicture(ledOffPicture);
    }

    // Draw min measured value indicator in minMeasuredValueBuffer
    if (minMeasuredValueVisible) {
      if (vertical) {
        minMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(
              minMaxIndSize, ColorEnum.BLUE.dark, false, vertical),
        );
      } else {
        minMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(
              minMaxIndSize, ColorEnum.BLUE.dark, false, vertical),
        );
      }
    }

    // Draw max measured value indicator in maxMeasuredValueBuffer
    if (maxMeasuredValueVisible) {
      if (vertical) {
        maxMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(
              minMaxIndSize, ColorEnum.RED.medium, false, vertical),
        );
      } else {
        maxMeasuredValueCtx.drawPicture(
          createMeasuredValueImage(
              minMaxIndSize, ColorEnum.RED.medium, false, vertical),
        );
      }
    }

    // Create alignment posts in background buffer (backgroundBuffer)
    if (drawBackground2 && backgroundVisible) {
      // Create tickmarks in background buffer (backgroundBuffer)
      drawTickmarksImage(backgroundContext, labelNumberFormat, vertical);

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
          gaugeType,
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
          gaugeType,
        );
      }
    }

    // Draw threshold image to background context
    if (drawBackground2 && thresholdVisible) {
      backgroundContext.save();
      if (vertical) {
        // Vertical orientation
        yOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0.856796 : 0.7475;
        yRange = yOffset - 0.12864;
        valuePos = imageHeight * yOffset -
            (imageHeight * yRange * (threshold - minValue)) /
                (maxValue - minValue);
        backgroundContext.translate(
            imageWidth * 0.365, valuePos - minMaxIndSize / 2);
      } else {
        // Horizontal orientation
        yOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0.871012 : 0.82;
        yRange =
            yOffset - (gaugeType == GaugeTypeEnum.TYPE1 ? 0.142857 : 0.19857);
        valuePos = (imageWidth * yRange * (threshold - minValue)) /
            (maxValue - minValue);
        backgroundContext.translate(
            imageWidth *
                    (gaugeType == GaugeTypeEnum.TYPE1 ? 0.142857 : 0.19857) -
                minMaxIndSize / 2 +
                valuePos,
            imageHeight * 0.58);
      }
      backgroundContext.drawPicture(createThresholdImage(vertical));
      backgroundContext.restore();
    }

    // Create lcd background if selected in background buffer (backgroundBuffer)
    if (drawBackground2 && lcdVisible) {
      if (vertical) {
        ui.Picture picture = createLcdBackgroundImage(
            imageWidth * 0.571428, imageHeight * 0.055, lcdColor);
        backgroundContext.save();
        backgroundContext.translate(
            (imageWidth - imageWidth * 0.571428) / 2, imageHeight * 0.88);
        backgroundContext.drawPicture(picture);
        backgroundContext.translate(
            -(imageWidth - imageWidth * 0.571428) / 2, -imageHeight * 0.88);
        backgroundContext.restore();
      } else {
        ui.Picture picture = createLcdBackgroundImage(
            imageWidth * 0.18, imageHeight * 0.15, lcdColor);
        backgroundContext.save();
        backgroundContext.translate(imageWidth * 0.695, imageHeight * 0.22);
        backgroundContext.drawPicture(picture);
        backgroundContext.translate(-imageWidth * 0.695, -imageHeight * 0.22);
        backgroundContext.restore();
      }
    }

    // add thermometer stem foreground
    if (drawForeground2 && gaugeType == GaugeTypeEnum.TYPE2) {
      drawForegroundImage(foregroundContext);
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
      'foreground': true,
    });

    ui.Picture picture;

    // Draw frame
    if (frameVisible) {
      picture = frameContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw buffered image to visible canvas
    picture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(picture);

    // Draw lcd display
    if (lcdVisible) {
      drawLcdText(canvas, value, vertical);
    }

    // Draw led
    if (ledVisible) {
      picture = ledOn
          ? ledBufferOnRecorder.endRecording()
          : ledBufferOffRecorder.endRecording();
      canvas.save();
      canvas.translate(ledPosX, ledPosY);
      canvas.drawPicture(picture);
      canvas.translate(-ledPosX, -ledPosY);
      canvas.restore();
    }

    double valuePos;
    double yOffset = 0;
    double yRange = 0;
    double minMaxX;
    double minMaxY;
    // Draw min measured value indicator
    if (minMeasuredValueVisible) {
      if (vertical) {
        yOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0.856796 : 0.7475;
        yRange = yOffset - 0.12864;
        valuePos = imageHeight * yOffset -
            (imageHeight * yRange * (minMeasuredValue - minValue)) /
                (maxValue - minValue);
        minMaxX = imageWidth * 0.34 - minMaxIndSize;
        minMaxY = valuePos - minMaxIndSize / 2;
      } else {
        yOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0.871012 : 0.82;
        yRange =
            yOffset - (gaugeType == GaugeTypeEnum.TYPE1 ? 0.142857 : 0.19857);
        valuePos = (imageWidth * yRange * (minMeasuredValue - minValue)) /
            (maxValue - minValue);
        minMaxX = imageWidth *
                (gaugeType == GaugeTypeEnum.TYPE1 ? 0.142857 : 0.19857) -
            minMaxIndSize / 2 +
            valuePos;
        minMaxY = imageHeight * 0.65;
      }
      canvas.save();
      canvas.translate(minMaxX, minMaxY);
      picture = minMeasuredValueBufferRecorder.endRecording();
      canvas.drawPicture(picture);
      canvas.translate(-minMaxX, -minMaxY);
      canvas.restore();
    }

    // Draw max measured value indicator
    if (maxMeasuredValueVisible) {
      if (vertical) {
        yOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0.856796 : 0.7475;
        yRange = yOffset - 0.12864;
        valuePos = imageHeight * yOffset -
            (imageHeight * yRange * (maxMeasuredValue - minValue)) /
                (maxValue - minValue);
        minMaxX = imageWidth * 0.34 - minMaxIndSize;
        minMaxY = valuePos - minMaxIndSize / 2;
      } else {
        yOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0.877012 : 0.82;
        yRange =
            yOffset - (gaugeType == GaugeTypeEnum.TYPE1 ? 0.14857 : 0.19857);
        valuePos = (imageWidth * yRange * (maxMeasuredValue - minValue)) /
            (maxValue - minValue);
        minMaxX = imageWidth *
                (gaugeType == GaugeTypeEnum.TYPE1 ? 0.142857 : 0.19857) -
            minMaxIndSize / 2 +
            valuePos;
        minMaxY = imageHeight * 0.65;
      }
      canvas.save();
      canvas.translate(minMaxX, minMaxY);
      picture = maxMeasuredValueBufferRecorder.endRecording();
      canvas.drawPicture(picture);
      canvas.translate(-minMaxX, -minMaxY);
      canvas.restore();
    }

    canvas.save();
    drawValue(canvas, imageWidth, imageHeight);
    canvas.restore();

    // Draw foreground
    if (foregroundVisible || gaugeType == GaugeTypeEnum.TYPE2) {
      picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  // Visualize the component
  repaint();
}
