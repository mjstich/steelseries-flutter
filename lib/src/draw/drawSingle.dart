// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'createLcdBackgroundImage.dart';
import 'definitions.dart';
import 'tools.dart';

void drawDisplaySingle(Canvas canvas, Size canvasSize, Parameters parameters) {
  double width = canvasSize.width;
  double height = canvasSize.height;
  LcdColorEnum lcdColor = parameters.lcdColorWithDefault(LcdColorEnum.STANDARD);
  int lcdDecimals = parameters.lcdDecimalsWithDefault(1);
  String unitString = parameters.unitStringWithDefault('');
  bool unitStringVisible = parameters.unitStringVisibleWithDefault(false);
  String headerString = parameters.headerStringWithDefault('');
  bool headerStringVisible = parameters.headerStringVisibleWithDefault(false);
  FontTypeEnum fontType = parameters.fontTypeWithDefault(FontTypeEnum.RobotoMono);
  double value = parameters.valueWithDefault(0);
  String? stringValue = parameters.stringValue;
  List<Section>? section = parameters.section;

  double imageWidth = width;
  double imageHeight = height;

  double fontHeight = (imageHeight / 1.5).floorToDouble();
  double stdFontSize = fontHeight;
  double lcdFontSize = fontHeight * 1.3;

  List<int> getColorValues(Color color) {
    return [color.red, color.green, color.blue];
  }

  // **************   Buffer creation  ********************
  // Buffer for the lcd
  ui.Picture? lcdBuffer;
  List<ui.Picture> sectionBuffer = [];
  List<Color> sectionForegroundColor = [];

  // **************   Image creation  ********************
  void drawLcdText(double value, String? stringValue, Color color) {
    canvas.save();
    // mainCtx.textAlign = 'right'
    // // mainCtx.textBaseline = 'top';
    // mainCtx.strokeStyle = color
    // mainCtx.fillStyle = color

    Path path = Path();
    Rect rect = Rect.fromLTWH(2, 0, imageWidth - 4, imageHeight);
    path.addRect(rect);
    path.close();
    canvas.clipPath(path);

    if ((lcdColor == LcdColorEnum.STANDARD || lcdColor == LcdColorEnum.STANDARD_GREEN) && section == null) {
      // mainCtx.shadowColor = 'gray'
      // mainCtx.shadowOffsetX = imageHeight * 0.035
      // mainCtx.shadowOffsetY = imageHeight * 0.035
      // mainCtx.shadowBlur = imageHeight * 0.055
    }

    double fontSize = fontType == FontTypeEnum.LCDMono ? lcdFontSize : stdFontSize;

    if (stringValue == null) {
      // Numeric value
      double unitXOffset = 0;
      double headerYOffset = 0;

      if (headerStringVisible && headerString.isNotEmpty) {
        headerYOffset = 5;
      }

      TextStyle font = getFont(fontSize, color, fontType: fontType);
      if (unitStringVisible && unitString.isNotEmpty) {
        TextStyle font = getFont(fontSize * 0.6, color, fontType: fontType);
        var textSpan = TextSpan(
          text: unitString,
          style: font,
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: imageWidth,
        );
        textPainter.paint(canvas, Offset(imageWidth - textPainter.size.width - 6, fontSize * 0.40 + (fontType == FontTypeEnum.LCDMono ? headerYOffset : 8)));
        unitXOffset = textPainter.size.width + 10;
      }

      String lcdText = value.toStringAsFixed(lcdDecimals);

      var textSpan = TextSpan(
        text: lcdText,
        style: font,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth,
      );
      textPainter.paint(canvas, Offset(imageWidth - textPainter.size.width - 6 - unitXOffset, fontSize * 0.09 + headerYOffset));

      if (headerStringVisible && headerString.isNotEmpty) {
        TextStyle font = getFont(fontSize * 0.25, color, fontType: fontType);
        var textSpan = TextSpan(
          text: headerString,
          style: font,
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: imageWidth,
        );
        textPainter.paint(canvas, Offset(imageWidth / 2 - textPainter.size.width / 2, 2));
      }
    } else {
      // Text value
      TextStyle font = getFont(fontSize, color, fontType: fontType);
      var textSpan = TextSpan(
        text: stringValue,
        style: font,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth,
      );
      textPainter.paint(canvas, Offset(imageWidth - textPainter.size.width - 6, fontSize * 0.09));
    }
    canvas.restore();
  }

  ui.Picture createLcdSectionImage(double width, double height, Color color, LcdColorEnum lcdColor) {
    var lcdCtxRecorder = ui.PictureRecorder();
    var lcdCtx = Canvas(lcdCtxRecorder);

    lcdCtx.save();
    double xB = 0;
    double yB = 0;
    double wB = width;
    double hB = height;
    double rB = math.min(width, height) * 0.095;

    ui.Gradient lcdBackground = ui.Gradient.linear(
      Offset(0, yB),
      Offset(0, yB + hB),
      [
        colorFromHex('#4c4c4c'),
        colorFromHex('#666666'),
        colorFromHex('#666666'),
        colorFromHex('#e6e6e6'),
      ],
      [0, 0.08, 0.92, 1],
    );

    Path path = roundedRectangle(xB, yB, wB, hB, rB);
    lcdCtx.drawPath(
        path,
        Paint()
          ..shader = lcdBackground
          ..style = ui.PaintingStyle.fill);

    lcdCtx.restore();

    lcdCtx.save();

    List<int> rgb = getColorValues(color);
    List<double> hsb = rgbToHsb(rgb[0].toDouble(), rgb[1].toDouble(), rgb[2].toDouble());

    List<int> rgbStart = getColorValues(lcdColor.gradientStartColor);
    List<double> hsbStart = rgbToHsb(rgbStart[0].toDouble(), rgbStart[1].toDouble(), rgbStart[2].toDouble());
    List<int> rgbFraction1 = getColorValues(lcdColor.gradientFraction1Color);
    List<double> hsbFraction1 = rgbToHsb(rgbFraction1[0].toDouble(), rgbFraction1[1].toDouble(), rgbFraction1[2].toDouble());
    List<int> rgbFraction2 = getColorValues(lcdColor.gradientFraction2Color);
    List<double> hsbFraction2 = rgbToHsb(rgbFraction2[0].toDouble(), rgbFraction2[1].toDouble(), rgbFraction2[2].toDouble());
    List<int> rgbFraction3 = getColorValues(lcdColor.gradientFraction3Color);
    List<double> hsbFraction3 = rgbToHsb(rgbFraction3[0].toDouble(), rgbFraction3[1].toDouble(), rgbFraction3[2].toDouble());
    List<int> rgbStop = getColorValues(lcdColor.gradientStopColor);
    List<double> hsbStop = rgbToHsb(rgbStop[0].toDouble(), rgbStop[1].toDouble(), rgbStop[2].toDouble());

    List<int> startColor = hsbToRgb(hsb[0], hsb[1], hsbStart[2] - 0.31);
    List<int> fraction1Color = hsbToRgb(hsb[0], hsb[1], hsbFraction1[2] - 0.31);
    List<int> fraction2Color = hsbToRgb(hsb[0], hsb[1], hsbFraction2[2] - 0.31);
    List<int> fraction3Color = hsbToRgb(hsb[0], hsb[1], hsbFraction3[2] - 0.31);
    List<int> stopColor = hsbToRgb(hsb[0], hsb[1], hsbStop[2] - 0.31);

    double xF = 1;
    double yF = 1;
    double wF = width - 2;
    double hF = height - 2;
    double rF = rB - 1;

    ui.Gradient lcdForeground = ui.Gradient.linear(
      Offset(0, yF),
      Offset(0, yF + hF),
      [
        Color.fromRGBO(startColor[0], startColor[1], startColor[2], 1),
        Color.fromRGBO(fraction1Color[0], fraction1Color[1], fraction1Color[2], 1),
        Color.fromRGBO(fraction2Color[0], fraction2Color[1], fraction2Color[2], 1),
        Color.fromRGBO(fraction3Color[0], fraction3Color[1], fraction3Color[2], 1),
        Color.fromRGBO(stopColor[0], stopColor[1], stopColor[2], 1),
      ],
      [0, 0.03, 0.49, 0.5, 1],
    );

    path = roundedRectangle(xF, yF, wF, hF, rF);
    lcdCtx.drawPath(
        path,
        Paint()
          ..shader = lcdForeground
          ..style = ui.PaintingStyle.fill);

    lcdCtx.restore();

    return lcdCtxRecorder.endRecording();
  }

  Color createSectionForegroundColor(Color sectionColor) {
    List<int> rgbSection = getColorValues(sectionColor);
    List<double> hsbSection = rgbToHsb(rgbSection[0].toDouble(), rgbSection[1].toDouble(), rgbSection[2].toDouble());
    List<int> sectionForegroundRgb = hsbToRgb(hsbSection[0], 0.57, 0.83);
    return Color.fromRGBO(sectionForegroundRgb[0], sectionForegroundRgb[1], sectionForegroundRgb[2], 1);
  }

  // **************   Initialization  ********************
  void init() {
    // let sectionIndex
    // initialized = true

    // Create lcd background if selected in background buffer (backgroundBuffer)
    lcdBuffer = createLcdBackgroundImage(width, height, lcdColor);

    if (stringValue == null && section != null && section.isNotEmpty) {
      for (int sectionIndex = 0; sectionIndex < section.length; sectionIndex++) {
        sectionBuffer.add(createLcdSectionImage(width, height, section[sectionIndex].color, lcdColor));
        sectionForegroundColor.add(createSectionForegroundColor(section[sectionIndex].color));
      }
    }
  }

  void repaint() {
    init();

    // mainCtx.save();

    ui.Picture lcdBackgroundBuffer = lcdBuffer!;
    Color lcdTextColor = lcdColor.textColor;

    // Draw sections
    if (stringValue == null && section != null && section.isNotEmpty) {
      for (int sectionIndex = 0; sectionIndex < section.length; sectionIndex++) {
        if (value >= section[sectionIndex].start && value <= section[sectionIndex].stop) {
          lcdBackgroundBuffer = sectionBuffer[sectionIndex];
          lcdTextColor = sectionForegroundColor[sectionIndex];
          break;
        }
      }
    }

    // Draw lcd background
    canvas.drawPicture(lcdBackgroundBuffer);

    // Draw lcd text
    drawLcdText(value, stringValue, lcdTextColor);
  }

  // Visualize the component
  repaint();
}
