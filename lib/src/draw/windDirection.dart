// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'createLcdBackgroundImage.dart';
import 'definitions.dart';
import 'drawBackground.dart';
import 'drawForeground.dart';
import 'drawFrame.dart';
import 'drawPointerImage.dart';
import 'drawRadialCustomImage.dart';
import 'drawRoseImage.dart';
import 'tools.dart';

void drawWindDirection(Canvas canvas, Size canvasSize, Parameters parameters) {
  double size = parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  FrameDesignEnum frameDesign = parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor = parameters.backgroundColorWithDefault(BackgroundColorEnum.DARK_GRAY);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  PointerTypeEnum pointerTypeLatest = parameters.pointerTypeWithDefault(PointerTypeEnum.TYPE1);
  PointerTypeEnum pointerTypeAverage = parameters.pointerTypeAverageWithDefault(PointerTypeEnum.TYPE8);
  ColorEnum pointerColor = parameters.pointerColorWithDefault(ColorEnum.RED);
  ColorEnum pointerColorAverage = parameters.pointerColorAverageWithDefault(ColorEnum.BLUE);
  KnobTypeEnum knobType = parameters.knobTypeWithDefault(KnobTypeEnum.STANDARD_KNOB);
  KnobStyleEnum knobStyle = parameters.knobStyleWithDefault(KnobStyleEnum.SILVER);
  ForegroundTypeEnum foregroundType = parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE2);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  List<String> pointSymbols = parameters.pointerSymbolsWithDefault(['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']);
  bool pointSymbolsVisible = parameters.pointSymbolsVisibleWithDefault(true);
  ui.Image? customLayer = parameters.customLayer;
  bool degreeScale = parameters.degreeScaleWithDefault(true);
  bool degreeScaleHalf = parameters.degreeScaleHalfWithDefault(false);
  bool roseVisible = parameters.roseVisibleWithDefault(true);
  LcdColorEnum lcdColor = parameters.lcdColorWithDefault(LcdColorEnum.STANDARD);
  bool lcdVisible = parameters.lcdVisibleWithDefault(true);
  FontTypeEnum fontType = parameters.fontTypeWithDefault(FontTypeEnum.RobotoMono);
  List<Section>? section = parameters.section;
  List<Section>? area = parameters.area;
  List<String> lcdTitleStrings = parameters.lcdTitleStringsWithDefault(['Latest', 'Average']);
  String titleString = parameters.titleStringWithDefault('');
  bool useColorLabels = parameters.useColorLabelsWithDefault(false);

  double valueLatest = parameters.valueWithDefault(0);
  double valueAverage = parameters.valueAverageWithDefault(0);
  double angleStep = RAD_FACTOR;
  double angleLatest;
  double angleAverage;
  double rotationOffset = -HALF_PI;
  double angleRange = TWO_PI;
  double range = 360;

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  double lcdFontHeight = (imageWidth / 8.5).floorToDouble();
  double stdFontHeight = (imageWidth / 10).floorToDouble();
  double lcdWidth = imageWidth * 0.3;
  double lcdHeight = imageHeight * 0.12;
  double lcdPosX = (imageWidth - lcdWidth) / 2;
  double lcdPosY1 = imageHeight * 0.32;
  double lcdPosY2 = imageHeight * 0.565;

  // **************   Buffer creation  ********************
  // Buffer for all static background painting code
  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // Buffer for LCD displays

  // Buffer for latest pointer images painting code
  var pointerContextLatestRecorder = ui.PictureRecorder();
  var pointerContextLatest = Canvas(pointerContextLatestRecorder);

  // Buffer for average pointer image
  var pointerContextAverageRecorder = ui.PictureRecorder();
  var pointerContextAverage = Canvas(pointerContextAverageRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  // **************   Image creation  ********************
  void drawLcdText(double value, bool bLatest) {
    canvas.save();
    double fontYOffset = fontType == FontTypeEnum.LCDMono ? lcdFontHeight * 0.04 : 0;

    // convert value from -180,180 range into 0-360 range
    while (value < -180) {
      value += 360;
    }
    if (!degreeScaleHalf && value < 0) {
      value += 360;
    }

    if (degreeScaleHalf && value > 180) {
      value = -(360 - value);
    }

    late String stringValue;
    if (value >= 0) {
      int valueRound = value.round();
      if (value < 10) {
        stringValue = '00$valueRound';
      } else if (value < 100) {
        stringValue = '0$valueRound';
      } else {
        stringValue = '$valueRound';
      }
    } else {
      int valueRound = value.round().abs();
      if (valueRound < 10) {
        stringValue = '-00$valueRound';
      } else if (valueRound < 100) {
        stringValue = '-0$valueRound';
      } else {
        stringValue = '-$valueRound';
      }
    }

    if (lcdColor == LcdColorEnum.STANDARD || lcdColor == LcdColorEnum.STANDARD_GREEN) {
      // mainCtx.shadowColor = 'gray'
      // mainCtx.shadowOffsetX = imageWidth * 0.007
      // mainCtx.shadowOffsetY = imageWidth * 0.007
      // mainCtx.shadowBlur = imageWidth * 0.007
    }

    var textSpan = TextSpan(
      text: '$stringValue\u00B0',
      style: getFont(fontType == FontTypeEnum.LCDMono ? lcdFontHeight : stdFontHeight, lcdColor.textColor, fontType: fontType),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: lcdWidth * 1.9,
    );
    textPainter.paint(canvas, Offset(imageWidth / 2 - textPainter.size.width / 2, (bLatest ? lcdPosY1 : lcdPosY2) + lcdHeight * 0.5 - textPainter.size.height / 2 + fontYOffset));
    canvas.restore();
  }

  void drawAreaSectionImage(Canvas ctx, double start, double stop, Color color, bool filled) {
    ctx.save();
    double lineWidth = imageWidth * 0.035;
    double startAngle = (angleRange / range) * start;
    double stopAngle = startAngle + (stop - start) / (range / angleRange);
    ctx.translate(centerX, centerY);
    ctx.rotate(rotationOffset);
    Path path = Path();
    if (filled) {
      path.moveTo(0, 0);
      Rect rect = Rect.fromCircle(center: const Offset(0, 0), radius: imageWidth * 0.365 - lineWidth / 2);
      path.addArc(rect, startAngle, stopAngle - startAngle);
    } else {
      Rect rect = Rect.fromCircle(center: const Offset(0, 0), radius: imageWidth * 0.365);
      path.addArc(rect, startAngle, stopAngle - startAngle);
    }
    if (filled) {
      path.moveTo(0, 0);
      ctx.drawPath(
          path,
          Paint()
            ..color = color
            ..style = ui.PaintingStyle.fill);
    } else {
      ctx.drawPath(
          path,
          Paint()
            ..color = color
            ..strokeWidth = lineWidth
            ..style = ui.PaintingStyle.stroke);
    }

    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  void drawTickmarksImage(Canvas ctx) {
    double OUTER_POINT = imageWidth * 0.38;
    double MAJOR_INNER_POINT = imageWidth * 0.35;
    double MINOR_INNER_POINT = imageWidth * 0.36;
    double TEXT_WIDTH = imageWidth * 0.3;
    double TEXT_TRANSLATE_X = imageWidth * 0.31;
    double CARDINAL_TRANSLATE_X = imageWidth * 0.36;
    double stdFontSize;
    double smlFontSize;
    double val = 0;

    ctx.save();
    //   ctx.strokeStyle = backgroundColor.labelColor.getRgbaColor()
    //   ctx.fillStyle = backgroundColor.labelColor.getRgbaColor()
    ctx.translate(centerX, centerY);

    if (!degreeScale) {
      stdFontSize = 0.12 * imageWidth;
      smlFontSize = 0.06 * imageWidth;

      double angleStep = RAD_FACTOR;
      double lineWidth = 1;
      //     ctx.strokeStyle = backgroundColor.symbolColor.getRgbaColor()

      for (double i = 0; i < 360; i += 2.5) {
        if (i % 5 == 0) {
          Path path = Path();
          path.moveTo(imageWidth * 0.38, 0);
          path.lineTo(imageWidth * 0.36, 0);
          path.close();
          ctx.drawPath(
              path,
              Paint()
                ..color = backgroundColor.symbolColor
                ..strokeWidth = lineWidth
                ..style = ui.PaintingStyle.stroke);
        }

        // Draw the labels
        ctx.save();
        switch (i) {
          case 0: // E

            ctx.translate(imageWidth * 0.35, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[2],
              style: getFont(stdFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );
            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.35, 0);
            break;
          case 45: // SE
            ctx.translate(imageWidth * 0.29, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[3],
              style: getFont(smlFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );
            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.29, 0);
            break;
          case 90: // S
            ctx.translate(imageWidth * 0.35, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[4],
              style: getFont(stdFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );

            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.35, 0);
            break;
          case 135: // SW
            ctx.translate(imageWidth * 0.29, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[5],
              style: getFont(smlFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );
            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.29, 0);
            break;
          case 180: // W
            ctx.translate(imageWidth * 0.35, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[6],
              style: getFont(stdFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );
            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.35, 0);
            break;
          case 225: // NW
            ctx.translate(imageWidth * 0.29, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[7],
              style: getFont(smlFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );

            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.29, 0);
            break;
          case 270: // N
            ctx.translate(imageWidth * 0.35, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[0],
              style: getFont(stdFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );
            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.35, 0);
            break;
          case 315: // NE
            ctx.translate(imageWidth * 0.29, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: pointSymbols[1],
              style: getFont(smlFontSize, backgroundColor.labelColor),
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
              maxWidth: lcdWidth * 0.9,
            );
            textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
            ctx.translate(-imageWidth * 0.29, 0);
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
          ctx.drawPath(path, Paint()..style = ui.PaintingStyle.stroke);
          ctx.drawPath(
              path,
              Paint()
                ..color = backgroundColor.symbolColor
                ..strokeWidth = lineWidth
                ..style = ui.PaintingStyle.stroke);
        }
        ctx.rotate(angleStep * 2.5);
      }
    } else {
      stdFontSize = (0.1 * imageWidth).floorToDouble();
      smlFontSize = (imageWidth * 0.035).floorToDouble();

      ctx.rotate(angleStep * 5);
      for (double i = 5; i <= 360; i += 5) {
        // Draw the labels
        ctx.save();
        if (pointSymbolsVisible) {
          switch (i) {
            case 360:
              ctx.translate(CARDINAL_TRANSLATE_X, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[2],
                style: getFont(stdFontSize, backgroundColor.labelColor),
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
              textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
              ctx.translate(-CARDINAL_TRANSLATE_X, 0);
              break;

            case 90:
              ctx.translate(CARDINAL_TRANSLATE_X, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[4],
                style: getFont(stdFontSize, backgroundColor.labelColor),
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
              textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
              ctx.translate(-CARDINAL_TRANSLATE_X, 0);
              break;
            case 180:
              ctx.translate(CARDINAL_TRANSLATE_X, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[6],
                style: getFont(stdFontSize, backgroundColor.labelColor),
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
              textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
              ctx.translate(-CARDINAL_TRANSLATE_X, 0);
              break;

            case 270:
              ctx.translate(CARDINAL_TRANSLATE_X, 0);
              ctx.rotate(HALF_PI);
              var textSpan = TextSpan(
                text: pointSymbols[0],
                style: getFont(stdFontSize, backgroundColor.labelColor),
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
              textPainter.paint(ctx, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
              ctx.translate(-CARDINAL_TRANSLATE_X, 0);
              break;

            case 5:
            case 85:
            case 95:
            case 175:
            case 185:
            case 265:
            case 275:
            case 355:
              // leave room for ordinal labels
              break;

            default:
              if ((i + 90) % 20 != 0) {
                double lineWidth = (i + 90) % 5 != 0 ? 1.5 : 1;
                Path path = Path();
                path.moveTo(OUTER_POINT, 0);
                double to = (i + 90) % 10 != 0 ? MINOR_INNER_POINT : MAJOR_INNER_POINT;
                path.lineTo(to, 0);
                path.close();
                ctx.drawPath(
                    path,
                    Paint()
                      ..color = backgroundColor.labelColor
                      ..strokeWidth = lineWidth
                      ..style = ui.PaintingStyle.stroke);
              } else {
                double lineWidth = 1.5;
                Path path = Path();
                path.moveTo(OUTER_POINT, 0);
                path.lineTo(MAJOR_INNER_POINT, 0);
                path.close();
                ctx.drawPath(
                    path,
                    Paint()
                      ..color = backgroundColor.labelColor
                      ..strokeWidth = lineWidth
                      ..style = ui.PaintingStyle.stroke);

                val = (i + 90) % 360;
                ctx.translate(TEXT_TRANSLATE_X, 0);
                ctx.rotate(HALF_PI);
                String strVal = val.toInt().toString();
                if (val < 100) {
                  strVal = '0$strVal';
                }
                // ctx.font = smlFont
                // ctx.fillText('0'.substring(val >= 100) + val, 0, 0, TEXT_WIDTH)
                var textSpan = TextSpan(
                  text: strVal,
                  style: getFont(smlFontSize, backgroundColor.labelColor),
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
                textPainter.paint(ctx, Offset(-textPainter.size.width / 2, 0));
                ctx.translate(-TEXT_TRANSLATE_X, 0);
              }
          }
        } else {
          if ((i + 90) % 20 != 0) {
            double lineWidth = (i + 90) % 5 != 0 ? 1.5 : 1;
            Path path = Path();
            path.moveTo(OUTER_POINT, 0);
            double to = (i + 90) % 10 != 0 ? MINOR_INNER_POINT : MAJOR_INNER_POINT;
            path.lineTo(to, 0);
            path.close();
            ctx.drawPath(
                path,
                Paint()
                  ..color = backgroundColor.labelColor
                  ..strokeWidth = lineWidth
                  ..style = ui.PaintingStyle.stroke);
          } else {
            double lineWidth = 1.5;
            Path path = Path();
            path.moveTo(OUTER_POINT, 0);
            path.lineTo(MAJOR_INNER_POINT, 0);
            path.close();
            ctx.drawPath(
                path,
                Paint()
                  ..color = backgroundColor.labelColor
                  ..strokeWidth = lineWidth
                  ..style = ui.PaintingStyle.stroke);
            val = (i + 90) % 360;
            if (degreeScaleHalf) {
              // invert 180-360
              if (val > 180) {
                val = -(360 - val);
              }
            }
            ctx.translate(TEXT_TRANSLATE_X, 0);
            ctx.rotate(HALF_PI);

            var textSpan = TextSpan(
              text: val.toInt().toString(),
              style: getFont(smlFontSize, backgroundColor.labelColor),
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
            textPainter.paint(ctx, const Offset(0, 0));
            ctx.translate(-TEXT_TRANSLATE_X, 0);
          }
        }
        ctx.restore();
        ctx.rotate(angleStep * 5);
      }
    }
    ctx.translate(-centerX, -centerY);
    ctx.restore();
  }

  void drawLcdTitles(Canvas ctx) {
    if (lcdTitleStrings.isNotEmpty) {
      TextStyle font = getFont(0.04 * imageWidth, useColorLabels ? pointerColor.medium : backgroundColor.labelColor, fontWeight: ui.FontWeight.bold);
      var textSpan = TextSpan(
        text: lcdTitleStrings[0],
        style: font,
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

      textPainter.paint(ctx, Offset(imageWidth / 2 - textPainter.size.width / 2, imageHeight * 0.29 - textPainter.size.height / 2));
      font = getFont(0.04 * imageWidth, useColorLabels ? pointerColorAverage.medium : backgroundColor.labelColor, fontWeight: ui.FontWeight.bold);
      textSpan = TextSpan(
        text: lcdTitleStrings[1],
        style: font,
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
      textPainter.paint(ctx, Offset(imageWidth / 2 - textPainter.size.width / 2, imageHeight * 0.71 - textPainter.size.height / 2));

      if (titleString.isNotEmpty) {
        font = getFont(0.0467 * imageWidth, backgroundColor.labelColor, fontWeight: ui.FontWeight.bold);
        textSpan = TextSpan(
          text: titleString,
          style: font,
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
        textPainter.paint(ctx, Offset(imageWidth / 2 - textPainter.size.width / 2, imageHeight * 0.5 - textPainter.size.height / 2));
      }
    }
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background

  void init(dynamic parameters) {
    bool drawBackground2 = parameters['background'] == null ? false : parameters['background'] as bool;
    bool drawPointer = parameters['pointer'] == null ? false : parameters['pointer'] as bool;
    bool drawForeground2 = parameters['foreground'] == null ? false : parameters['foreground'] as bool;

    if (drawBackground2 && frameVisible) {
      ui.Picture picture = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      backgroundContext.drawPicture(picture);
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

      drawTickmarksImage(backgroundContext);
    }

    if (drawBackground2 && roseVisible) {
      drawRoseImage(
        backgroundContext,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
        backgroundColor,
      );
    }

    // Create lcd background if selected in background buffer (backgroundBuffer)
    if (drawBackground2 && lcdVisible) {
      ui.Picture lcdBuffer = createLcdBackgroundImage(lcdWidth, lcdHeight, lcdColor);
      backgroundContext.save();
      backgroundContext.translate(lcdPosX, lcdPosY1);
      backgroundContext.drawPicture(lcdBuffer);
      backgroundContext.translate(-lcdPosX, -lcdPosY1);
      backgroundContext.restore();
      backgroundContext.save();
      backgroundContext.translate(lcdPosX, lcdPosY2);
      backgroundContext.drawPicture(lcdBuffer);
      backgroundContext.translate(-lcdPosX, -lcdPosY2);
      backgroundContext.restore();

      // Create title in background buffer (backgroundBuffer)
      drawLcdTitles(backgroundContext);
    }

    if (drawPointer) {
      ui.Picture picture = drawPointerImage(
        imageWidth,
        pointerTypeAverage,
        pointerColorAverage.toColorDef(),
        backgroundColor.labelColor,
      );
      pointerContextAverage.drawPicture(picture);
      picture = drawPointerImage(
        imageWidth,
        pointerTypeLatest,
        pointerColor.toColorDef(),
        backgroundColor.labelColor,
      );
      pointerContextLatest.drawPicture(picture);
    }

    if (drawForeground2 && foregroundVisible) {
      bool knobVisible = !(pointerTypeLatest == PointerTypeEnum.TYPE15 || pointerTypeLatest == PointerTypeEnum.TYPE16);
      ui.Picture picture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        knobVisible,
        knobType,
        knobStyle,
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
      'led': true,
      'pointer': true,
      'foreground': true,
    });

    if (frameVisible || backgroundVisible) {
      ui.Picture picture = backgroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }

    // Draw lcd display
    if (lcdVisible) {
      drawLcdText(valueLatest, true);
      drawLcdText(valueAverage, false);
    }

    // Define rotation angle
    angleAverage = valueAverage * angleStep;

    // we have to draw to a rotated temporary image area so we can translate in
    // absolute x, y values when drawing to main context
    //double shadowOffset = imageWidth * 0.006;

    // Define rotation center
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(angleAverage);
    canvas.translate(-centerX, -centerY);
    // Set the pointer shadow params
    //mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    //mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
    //mainCtx.shadowBlur = shadowOffset * 2
    // Draw the pointer
    ui.Picture picture = pointerContextAverageRecorder.endRecording();
    canvas.drawPicture(picture);
    // Define rotation angle difference for average pointer
    angleLatest = valueLatest * angleStep - angleAverage;
    canvas.translate(centerX, centerY);
    canvas.rotate(angleLatest);
    canvas.translate(-centerX, -centerY);
    picture = pointerContextLatestRecorder.endRecording();
    canvas.drawPicture(picture);
    canvas.restore();

    if (foregroundVisible) {
      ui.Picture picture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(picture);
    }
  }

  // Visualize the component
  repaint();
}
