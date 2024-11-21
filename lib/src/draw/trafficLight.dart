// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'hatchBuffer.dart';
import 'tools.dart';

void drawTrafficlight(Canvas canvas, Size canvasSize, Parameters parameters) {
  double width = canvasSize.width;
  double height = canvasSize.height;
  //
  bool redOn = parameters.redOnWithDefault(false);
  bool yellowOn = parameters.yellowOnWithDefault(false);
  bool greenOn = parameters.greenOnWithDefault(false);
  var housingCtxRecorder = ui.PictureRecorder();
  var housingCtx = Canvas(housingCtxRecorder);

  var lightGreenCtxRecorder = ui.PictureRecorder();
  var lightGreenCtx = Canvas(lightGreenCtxRecorder);
  var greenOnCtxRecorder = ui.PictureRecorder();
  var greenOnCtx = Canvas(greenOnCtxRecorder);
  var greenOffCtxRecorder = ui.PictureRecorder();
  var greenOffCtx = Canvas(greenOffCtxRecorder);

  var lightYellowCtxRecorder = ui.PictureRecorder();
  var lightYellowCtx = Canvas(lightYellowCtxRecorder);
  var yellowOnCtxRecorder = ui.PictureRecorder();
  var yellowOnCtx = Canvas(yellowOnCtxRecorder);
  var yellowOffCtxRecorder = ui.PictureRecorder();
  var yellowOffCtx = Canvas(yellowOffCtxRecorder);

  var lightRedCtxRecorder = ui.PictureRecorder();
  var lightRedCtx = Canvas(lightRedCtxRecorder);
  var redOnCtxRecorder = ui.PictureRecorder();
  var redOnCtx = Canvas(redOnCtxRecorder);
  var redOffCtxRecorder = ui.PictureRecorder();
  var redOffCtx = Canvas(redOffCtxRecorder);
  // End of variables

  // double prefHeight = width < height * 0.352517 ? width * 2.836734 : height;
  // double imageWidth = prefHeight * 0.352517;
  // double imageHeight = prefHeight;

  double imageWidth = width;
  double imageHeight = height;

  void drawHousing(Canvas ctx) {
    ctx.save();

    ctx.save();
    Path path = Path();
    path.moveTo(0.107142 * imageWidth, 0);
    path.lineTo(imageWidth - 0.107142 * imageWidth, 0);
    path.quadraticBezierTo(
      imageWidth,
      0,
      imageWidth,
      0.107142 * imageWidth,
    );
    path.lineTo(imageWidth, imageHeight - 0.107142 * imageWidth);
    path.quadraticBezierTo(
      imageWidth,
      imageHeight,
      imageWidth - 0.107142 * imageWidth,
      imageHeight,
    );
    path.lineTo(0.107142 * imageWidth, imageHeight);
    path.quadraticBezierTo(
      0,
      imageHeight,
      0,
      imageHeight - 0.107142 * imageWidth,
    );
    path.lineTo(0, 0.107142 * imageWidth);
    path.quadraticBezierTo(
      0,
      0,
      0.107142 * imageWidth,
      imageHeight,
    );
    path.close();
    ui.Gradient housingFill = ui.Gradient.linear(
      Offset(0.040816 * imageWidth, 0.007194 * imageHeight),
      Offset(0.952101 * imageWidth, 0.995882 * imageHeight),
      [
        const Color.fromRGBO(152, 152, 154, 1),
        const Color.fromRGBO(152, 152, 154, 1),
        colorFromHex('#333333'),
        const Color.fromRGBO(152, 152, 154, 1),
        const Color.fromRGBO(31, 31, 31, 1),
        colorFromHex('#363636'),
        colorFromHex('#000000'),
        colorFromHex('#000000'),
      ],
      [0, 0.01, 0.09, 0.24, 0.55, 0.78, 0.98, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = housingFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    path = Path();
    path.moveTo(0.030612 * imageWidth + 0.084183 * imageWidth, 0.010791 * imageHeight);
    path.lineTo(0.030612 * imageWidth + 0.938775 * imageWidth - 0.084183 * imageWidth, 0.010791 * imageHeight);
    path.quadraticBezierTo(
      0.030612 * imageWidth + 0.938775 * imageWidth,
      0.010791 * imageHeight,
      0.030612 * imageWidth + 0.938775 * imageWidth,
      0.010791 * imageHeight + 0.084183 * imageWidth,
    );
    path.lineTo(0.030612 * imageWidth + 0.938775 * imageWidth, 0.010791 * imageHeight + 0.978417 * imageHeight - 0.084183 * imageWidth);
    path.quadraticBezierTo(
      0.030612 * imageWidth + 0.938775 * imageWidth,
      0.010791 * imageHeight + 0.978417 * imageHeight,
      0.030612 * imageWidth + 0.938775 * imageWidth - 0.084183 * imageWidth,
      0.010791 * imageHeight + 0.978417 * imageHeight,
    );
    path.lineTo(0.030612 * imageWidth + 0.084183 * imageWidth, 0.010791 * imageHeight + 0.978417 * imageHeight);
    path.quadraticBezierTo(
      0.030612 * imageWidth,
      0.010791 * imageHeight + 0.978417 * imageHeight,
      0.030612 * imageWidth,
      0.010791 * imageHeight + 0.978417 * imageHeight - 0.084183 * imageWidth,
    );
    path.lineTo(0.030612 * imageWidth, 0.010791 * imageHeight + 0.084183 * imageWidth);
    path.quadraticBezierTo(
      0.030612 * imageWidth,
      0.010791 * imageHeight,
      0.030612 * imageWidth + 0.084183 * imageWidth,
      0.010791 * imageHeight,
    );
    path.close();
    ui.Gradient housingFrontFill = ui.Gradient.linear(
      Offset(-0.132653 * imageWidth, -0.053956 * imageHeight),
      Offset(2.061408 * imageWidth, 0.667293 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#000000'),
        colorFromHex('#373735'),
        colorFromHex('#000000'),
        colorFromHex('#303030'),
        colorFromHex('#000000'),
        colorFromHex('#363636'),
        colorFromHex('#000000'),
        colorFromHex('#000000'),
      ],
      [0, 0.01, 0.16, 0.31, 0.44, 0.65, 0.87, 98, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = housingFrontFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawLightGreen(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.805755 * imageHeight), width: 0.397959 * imageWidth * 2, height: 0.397959 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightGreenFrameFill = ui.Gradient.linear(
      Offset(0, 0.665467 * imageHeight),
      Offset(0, 0.946043 * imageHeight),
      [
        colorFromHex('#ffffff'),
        const Color.fromRGBO(204, 204, 204, 1),
        const Color.fromRGBO(153, 153, 153, 1),
        colorFromHex('#666666'),
        colorFromHex('#333333'),
        colorFromHex('#010101'),
      ],
      [0, 0.05, 0.1, 0.17, 0.27, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightGreenFrameFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1.083333, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.461538 * imageWidth, 0.816546 * imageHeight), width: 0.367346 * imageWidth * 2, height: 0.367346 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightGreenInnerFill = ui.Gradient.linear(
      Offset(0, 0.68705 * imageHeight),
      Offset(0, 0.946043 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#040404'),
        colorFromHex('#000000'),
        colorFromHex('#010101'),
      ],
      [0, 0.35, 0.66, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightGreenInnerFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.809352 * imageHeight), width: 0.357142 * imageWidth * 2, height: 0.357142 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightGreenEffectFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0,
      [
        colorFromHex('#000000'),
        colorFromHex('#000000'),
        const Color.fromRGBO(94, 94, 94, 1),
        colorFromHex('#010101'),
      ],
      <double>[0.0, 0.88, 0.95, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0.362244 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightGreenEffectFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.809352 * imageHeight), width: 0.357142 * imageWidth * 2, height: 0.357142 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightGreenInnerShadowFill = ui.Gradient.linear(
      Offset(0, 0.68705 * imageHeight),
      Offset(0, 0.917266 * imageHeight),
      [
        colorFromHex('#000000'),
        const Color.fromRGBO(1, 1, 1, 0),
      ],
      [0, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightGreenInnerShadowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawGreenOn(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.809352 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient greenOnFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0,
      [
        const Color.fromRGBO(85, 185, 123, 1),
        const Color.fromRGBO(0, 31, 0, 1),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0.362244 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = greenOnFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    path = Path();
    path.moveTo(0, 0.812949 * imageHeight);
    path.cubicTo(
      0,
      0.910071 * imageHeight,
      0.224489 * imageWidth,
      0.989208 * imageHeight,
      0.5 * imageWidth,
      0.989208 * imageHeight,
    );
    path.cubicTo(
      0.77551 * imageWidth,
      0.989208 * imageHeight,
      imageWidth,
      0.910071 * imageHeight,
      imageWidth,
      0.809352 * imageHeight,
    );
    path.cubicTo(
      0.908163 * imageWidth,
      0.751798 * imageHeight,
      0.704081 * imageWidth,
      0.68705 * imageHeight,
      0.5 * imageWidth,
      0.68705 * imageHeight,
    );
    path.cubicTo(
      0.285714 * imageWidth,
      0.68705 * imageHeight,
      0.081632 * imageWidth,
      0.751798 * imageHeight,
      0,
      0.812949 * imageHeight,
    );
    path.close();
    ui.Gradient greenOnGlowFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0,
      [
        const Color.fromRGBO(65, 187, 126, 1),
        const Color.fromRGBO(4, 37, 8, 0),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0.515306 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = greenOnGlowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawGreenOff(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.809352 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient greenOffFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0,
      [
        const Color.fromRGBO(0, 255, 0, 0.25),
        const Color.fromRGBO(0, 255, 0, 0.05),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = greenOffFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.809352 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient greenOffInnerShadowFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0,
      [
        const Color.fromRGBO(1, 1, 1, 0),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0.12),
        const Color.fromRGBO(0, 0, 0, 0.12),
        const Color.fromRGBO(0, 0, 0, 0.5),
      ],
      <double>[0.0, 0.55, 0.5501, 0.78, 0.79, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.809352 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = greenOffInnerShadowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    var hatchedImage = hatchBuffer();
    if (hatchedImage != null) {
      ctx.save();
      Path path = Path();
      path.addArc(rect, 0, TWO_PI);
      path.close();
      ctx.clipPath(path);
      paintImage(canvas: ctx, rect: rect, image: hatchedImage, repeat: ImageRepeat.repeat);
      ctx.restore();
    }

    ctx.restore();
  }

  void drawLightYellow(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.496402 * imageHeight), width: 0.397959 * imageWidth * 2, height: 0.397959 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightYellowFrameFill = ui.Gradient.linear(
      Offset(0, 0.356115 * imageHeight),
      Offset(0, 0.63669 * imageHeight),
      [
        colorFromHex('#ffffff'),
        const Color.fromRGBO(204, 204, 204, 1),
        const Color.fromRGBO(153, 153, 153, 1),
        colorFromHex('#666666'),
        colorFromHex('#333333'),
        colorFromHex('#010101'),
      ],
      [0, 0.05, 0.1, 0.17, 0.27, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightYellowFrameFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1.083333, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.461538 * imageWidth, 0.507194 * imageHeight), width: 0.367346 * imageWidth * 2, height: 0.367346 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);
    ui.Gradient lightYellowInnerFill = ui.Gradient.linear(
      Offset(0, 0.377697 * imageHeight),
      Offset(0, 0.63669 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#040404'),
        colorFromHex('#000000'),
        colorFromHex('#010101'),
      ],
      [0, 0.35, 0.66, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightYellowInnerFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: 0.357142 * imageWidth * 2, height: 0.357142 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);
    ui.Gradient lightYellowEffectFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0,
      [
        colorFromHex('#000000'),
        colorFromHex('#000000'),
        colorFromHex('#5e5e5e'),
        colorFromHex('#010101'),
      ],
      <double>[0.0, 0.88, 0.95, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0.362244 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightYellowEffectFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    // lIGHT_YELLOW_4_E_INNER_SHADOW_3_4
    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: 0.357142 * imageWidth * 2, height: 0.357142 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightYellowInnerShadowFill = ui.Gradient.linear(
      Offset(0, 0.377697 * imageHeight),
      Offset(0, 0.607913 * imageHeight),
      [
        colorFromHex('#000000'),
        const Color.fromRGBO(1, 1, 1, 0),
      ],
      [0, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightYellowInnerShadowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawYellowOn(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient yellowOnFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0,
      [
        colorFromHex('#fed434'),
        colorFromHex('#82330c'),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = yellowOnFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    path = Path();
    path.moveTo(0, 0.503597 * imageHeight);
    path.cubicTo(
      0,
      0.600719 * imageHeight,
      0.224489 * imageWidth,
      0.679856 * imageHeight,
      0.5 * imageWidth,
      0.679856 * imageHeight,
    );
    path.cubicTo(
      0.77551 * imageWidth,
      0.679856 * imageHeight,
      imageWidth,
      0.600719 * imageHeight,
      imageWidth,
      0.5 * imageHeight,
    );
    path.cubicTo(
      0.908163 * imageWidth,
      0.442446 * imageHeight,
      0.704081 * imageWidth,
      0.377697 * imageHeight,
      0.5 * imageWidth,
      0.377697 * imageHeight,
    );
    path.cubicTo(
      0.285714 * imageWidth,
      0.377697 * imageHeight,
      0.081632 * imageWidth,
      0.442446 * imageHeight,
      0,
      0.503597 * imageHeight,
    );
    path.close();

    ui.Gradient yellowOnGlowFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0,
      [
        colorFromHex('#fed434'),
        const Color.fromRGBO(130, 51, 12, 0),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0.515306 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = yellowOnGlowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawYellowOff(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient yellowOffFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0,
      [
        const Color.fromRGBO(255, 255, 0, 0.25),
        const Color.fromRGBO(255, 255, 0, 0.05),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = yellowOffFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.5 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient yellowOffInnerShadowFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0,
      [
        const Color.fromRGBO(1, 1, 1, 0),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0.12),
        const Color.fromRGBO(0, 0, 0, 0.13),
        const Color.fromRGBO(0, 0, 0, 0.5),
      ],
      <double>[0.0, 0.55, 0.5501, 0.78, 0.79, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.5 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = yellowOffInnerShadowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    var hatchedImage = hatchBuffer();
    if (hatchedImage != null) {
      ctx.save();
      Path path = Path();
      path.addArc(rect, 0, TWO_PI);
      path.close();
      ctx.clipPath(path);
      paintImage(canvas: ctx, rect: rect, image: hatchedImage, repeat: ImageRepeat.repeat);
      ctx.restore();
    }

    ctx.restore();
  }

  void drawLightRed(Canvas ctx) {
    ctx.save();

    // lIGHT_RED_7_E_FRAME_0_1
    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.18705 * imageHeight), width: 0.397959 * imageWidth * 2, height: 0.397959 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightRedFrameFill = ui.Gradient.linear(
      Offset(0.5 * imageWidth, 0.046762 * imageHeight),
      Offset(0.5 * imageWidth, 0.327338 * imageHeight),
      [
        colorFromHex('#ffffff'),
        colorFromHex('#cccccc'),
        colorFromHex('#999999'),
        colorFromHex('#666666'),
        colorFromHex('#333333'),
        colorFromHex('#010101'),
      ],
      [0, 0.05, 0.1, 0.17, 0.27, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightRedFrameFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    // lIGHT_RED_7_E_INNER_CLIP_1_2
    ctx.save();
    ctx.scale(1.083333, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.461538 * imageWidth, 0.197841 * imageHeight), width: 0.367346 * imageWidth * 2, height: 0.367346 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightRedInnerFill = ui.Gradient.linear(
      Offset(0.5 * imageWidth, 0.068345 * imageHeight),
      Offset(0.5 * imageWidth, 0.327338 * imageHeight),
      [
        colorFromHex('#000000'),
        colorFromHex('#040404'),
        colorFromHex('#000000'),
        colorFromHex('#010101'),
      ],
      [0, 0.35, 0.66, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightRedInnerFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    // lIGHT_RED_7_E_LIGHT_EFFECT_2_3
    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.190647 * imageHeight), width: 0.357142 * imageWidth * 2, height: 0.357142 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightRedEffectFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0,
      [
        colorFromHex('#000000'),
        colorFromHex('#000000'),
        colorFromHex('#5e5e5e'),
        colorFromHex('#010101'),
      ],
      <double>[0.0, 0.88, 0.95, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0.362244 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightRedEffectFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    // lIGHT_RED_7_E_INNER_SHADOW_3_4
    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.190647 * imageHeight), width: 0.357142 * imageWidth * 2, height: 0.357142 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient lightRedInnerShadowFill = ui.Gradient.linear(
      Offset(0.5 * imageWidth, 0.068345 * imageHeight),
      Offset(0.5 * imageWidth, 0.298561 * imageHeight),
      [
        colorFromHex('#000000'),
        const Color.fromRGBO(1, 1, 1, 0),
      ],
      [0, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = lightRedInnerShadowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawRedOn(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.190647 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient redOnFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0,
      [
        colorFromHex('#ff0000'),
        colorFromHex('#410004'),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = redOnFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    path = Path();
    path.moveTo(0, 0.194244 * imageHeight);
    path.cubicTo(
      0,
      0.291366 * imageHeight,
      0.224489 * imageWidth,
      0.370503 * imageHeight,
      0.5 * imageWidth,
      0.370503 * imageHeight,
    );
    path.cubicTo(
      0.77551 * imageWidth,
      0.370503 * imageHeight,
      imageWidth,
      0.291366 * imageHeight,
      imageWidth,
      0.190647 * imageHeight,
    );
    path.cubicTo(
      0.908163 * imageWidth,
      0.133093 * imageHeight,
      0.704081 * imageWidth,
      0.068345 * imageHeight,
      0.5 * imageWidth,
      0.068345 * imageHeight,
    );
    path.cubicTo(
      0.285714 * imageWidth,
      0.068345 * imageHeight,
      0.081632 * imageWidth,
      0.133093 * imageHeight,
      0,
      0.194244 * imageHeight,
    );
    path.close();

    ui.Gradient redOnGlowFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0,
      [
        colorFromHex('#ff0000'),
        const Color.fromRGBO(118, 5, 1, 0),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0.515306 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = redOnGlowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.restore();
  }

  void drawRedOff(Canvas ctx) {
    ctx.save();

    ctx.save();
    ctx.scale(1, 1);
    Path path = Path();
    Rect rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.190647 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient redOffFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0,
      [
        const Color.fromRGBO(255, 0, 0, 0.25),
        const Color.fromRGBO(255, 0, 0, 0.05),
      ],
      <double>[0.0, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = redOffFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    ctx.save();
    ctx.scale(1, 1);
    path = Path();
    rect = Rect.fromCenter(center: Offset(0.5 * imageWidth, 0.190647 * imageHeight), width: 0.32653 * imageWidth * 2, height: 0.32653 * imageWidth * 2);
    path.addArc(rect, 0, TWO_PI);

    ui.Gradient redOffInnerShadowFill = ui.Gradient.radial(
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0,
      [
        const Color.fromRGBO(1, 1, 1, 0),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0),
        const Color.fromRGBO(0, 0, 0, 0.12),
        const Color.fromRGBO(0, 0, 0, 0.13),
        const Color.fromRGBO(0, 0, 0, 0.5),
      ],
      <double>[0.0, 0.55, 0.5501, 0.78, 0.79, 1],
      TileMode.clamp,
      null,
      Offset(0.5 * imageWidth, 0.190647 * imageHeight),
      0.32653 * imageWidth,
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = redOffInnerShadowFill
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    var hatchedImage = hatchBuffer();
    if (hatchedImage != null) {
      ctx.save();
      Path path = Path();
      path.addArc(rect, 0, TWO_PI);
      path.close();
      ctx.clipPath(path);
      paintImage(canvas: ctx, rect: rect, image: hatchedImage, repeat: ImageRepeat.repeat);
      ctx.restore();
    }

    ctx.restore();
  }

  void init() {
    drawHousing(housingCtx);
    drawLightGreen(lightGreenCtx);
    drawGreenOn(greenOnCtx);
    drawGreenOff(greenOffCtx);
    drawLightYellow(lightYellowCtx);
    drawYellowOn(yellowOnCtx);
    drawYellowOff(yellowOffCtx);
    drawLightRed(lightRedCtx);
    drawRedOn(redOnCtx);
    drawRedOff(redOffCtx);
  }

  void repaint() {
    init();

    canvas.save();

    // housing
    canvas.drawPicture(housingCtxRecorder.endRecording());

    // Green light
    canvas.drawPicture(lightGreenCtxRecorder.endRecording());

    ui.Picture picture = greenOnCtxRecorder.endRecording();
    if (greenOn) {
      canvas.drawPicture(picture);
    }

    canvas.drawPicture(greenOffCtxRecorder.endRecording());

    // Yellow light
    canvas.drawPicture(lightYellowCtxRecorder.endRecording());

    picture = yellowOnCtxRecorder.endRecording();
    if (yellowOn) {
      canvas.drawPicture(picture);
    }

    canvas.drawPicture(yellowOffCtxRecorder.endRecording());

    // Red light
    canvas.drawPicture(lightRedCtxRecorder.endRecording());

    picture = redOnCtxRecorder.endRecording();
    if (redOn) {
      canvas.drawPicture(picture);
    }

    canvas.drawPicture(redOffCtxRecorder.endRecording());

    canvas.restore();
  }

  // Visualize the component
  repaint();
}
