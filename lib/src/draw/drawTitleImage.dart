// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

void drawTitleImage(
  Canvas ctx,
  double imageWidth,
  double imageHeight,
  String titleString,
  String unitString,
  BackgroundColorEnum backgroundColor,
  bool vertical,
  bool radial,
  bool altPos,
  GaugeTypeEnum? gaugeTypeVal,
) {
  GaugeTypeEnum gaugeType = gaugeTypeVal ?? GaugeTypeEnum.TYPE1;
  ctx.save();

  if (radial) {
    TextStyle stdFont =
        getFont((0.046728 * imageWidth), backgroundColor.labelColor);
    var textSpan = TextSpan(
      text: titleString,
      style: stdFont,
    );
    var textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: imageWidth * 0.3,
    );
    textPainter.paint(
        ctx, Offset(imageWidth / 2 - textPainter.width / 2, imageHeight * 0.3));
    textSpan = TextSpan(
      text: unitString,
      style: stdFont,
    );
    textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: imageWidth * 0.3,
    );
    textPainter.paint(ctx,
        Offset(imageWidth / 2 - textPainter.width / 2, imageHeight * 0.38));
  } else {
    // linear
    if (vertical) {
      TextStyle stdFont = getFont(
          (0.1 * imageWidth), backgroundColor.labelColor,
          fontWeight: ui.FontWeight.bold);
      ctx.save();
      ctx.translate(0.711428 * imageWidth, 0.1375 * imageHeight);
      ctx.rotate(1.570796);

      //ctx.fillText(titleString, 0, 0)
      var textSpan = TextSpan(
        text: titleString,
        style: stdFont,
      );
      var textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth,
      );
      textPainter.paint(
          ctx,
          Offset(
              0,
              unitString.isEmpty
                  ? -textPainter.size.height / 2
                  : -textPainter.size.height));

      stdFont = getFont((0.071428 * imageWidth), backgroundColor.labelColor,
          fontWeight: ui.FontWeight.bold);
      textSpan = TextSpan(
        text: unitString,
        style: stdFont,
      );
      textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth,
      );
      textPainter.paint(ctx, const Offset(0, 0));
      ctx.translate(-0.711428 * imageWidth, -0.1375 * imageHeight);
      ctx.restore();
    } else {
      double xOffset = gaugeType == GaugeTypeEnum.TYPE1 ? 0 : 15;
      TextStyle stdFont = getFont(
          (0.035 * imageWidth), backgroundColor.labelColor,
          fontWeight: ui.FontWeight.bold);

      ctx.save();
      ctx.translate(imageWidth * 0.15 + xOffset, imageHeight * 0.30);
      var textSpan = TextSpan(
        text: titleString,
        style: stdFont,
      );
      var textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth,
      );
      textPainter.paint(
          ctx,
          Offset(
              0,
              unitString.isEmpty
                  ? -textPainter.size.height / 2
                  : -textPainter.size.height));
      stdFont = getFont((0.025 * imageWidth), backgroundColor.labelColor,
          fontWeight: ui.FontWeight.bold);

      textSpan = TextSpan(
        text: unitString,
        style: stdFont,
      );
      textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageWidth,
      );
      textPainter.paint(ctx, const Offset(0, 0));
      ctx.translate(-imageWidth * 0.15 - xOffset, -imageHeight * 0.30);
      ctx.restore();
    }
  }
  ctx.restore();
}
