import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

void drawOdometer(Canvas canvas, OdometerParameters parameters) {
  // parameters
  double value = parameters.valueWithDefault(0);
  double height = parameters.heightWithDefault(50);
  int digits = parameters.digitsWithDefault(6);
  int decimals = parameters.decimalsWithDefault(1);
  Color decimalBackColor = parameters.decimalBackColorDefault(colorFromHex('#F0F0F0'));
  Color decimalForeColor = parameters.decimalForeColorDefault(colorFromHex('#F01010'));
  Color valueBackColor = parameters.valueBackColorDefault(colorFromHex('#050505'));
  Color valueForeColor = parameters.valueForeColorDefault(colorFromHex('#F8F8F8'));
  double wobbleFactor = parameters.wobbleFactorWithDefault(0);
  //
  //let ctx
  List<double> wobble = [];
  // End of variables

  // Has a height been specified?
  // if (height === 0) {
  //   height = ctx.canvas.height
  // }

  // Cannot display negative values yet
  if (value < 0) {
    value = 0;
  }

  double digitHeight = (height * 0.85).floorToDouble();
  //const stdFont = '600 ' + digitHeight + 'px ' + font

  double digitWidth = (height * 0.68).floorToDouble();
  double width = digitWidth * (digits + decimals);
  double columnHeight = digitHeight * 11;
  double verticalSpace = columnHeight / 12;
  double zeroOffset = verticalSpace * 0.81;

  // Create buffers
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);

  void init() {
    // Create the foreground
    Path path = Path();
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    path.addRect(rect);
    path.close();
    ui.Gradient grad = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, height),
      [
        const Color.fromRGBO(0, 0, 0, 1),
        const Color.fromRGBO(0, 0, 0, 0.4),
        const Color.fromRGBO(255, 255, 255, 0.45),
        const Color.fromRGBO(255, 255, 255, 0),
        const Color.fromRGBO(0, 0, 0, 0.4),
        const Color.fromRGBO(0, 0, 0, 1),
      ],
      [0, 0.1, 0.33, 0.46, 0.9, 1],
    );
    foregroundContext.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);

    // wobble factors
    for (int i = 0; i < digits + decimals; i++) {
      //wobble.add(math.Random().nextDouble() * wobbleFactor * height - (wobbleFactor * height) / 2);
      wobble.add(0);
    }
  }

  void drawDigits() {
    double pos = 1;
    double val = value;

    // do not use Math.pow() - rounding errors!
    for (int i = 0; i < decimals; i++) {
      val *= 10;
    }

    int numb = val.floor();
    double frac = val - numb;
    String numbString = numb.toInt().toString();
    int prevNum = 9;

    for (int i = decimals + digits - 1; i >= 0; i--) {
      int num = 0;
      try {
        int? val = int.tryParse(numbString.substring(numbString.length - i - 1, numbString.length - i));
        if (val != null) {
          num = val;
        }
      } catch (e) {}

      if (prevNum != 9) {
        frac = 0;
      }

      if (i < decimals) {
        TextStyle stdFont = getFont(digitHeight, decimalForeColor);
        var textSpan = TextSpan(
          text: num.toString(),
          style: stdFont,
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: digitWidth,
        );
        Path path = Path();
        Rect rect = Rect.fromLTWH(digitWidth * ((decimals + digits) - i - 1), 0, digitWidth, height);
        path.addRect(rect);
        path.close();
        backgroundContext.drawPath(
            path,
            Paint()
              ..color = decimalBackColor
              ..style = ui.PaintingStyle.fill);
        path = Path();
        path.moveTo(digitWidth * ((decimals + digits) - i - 1), 0);
        path.lineTo(digitWidth * ((decimals + digits) - i - 1), height);
        backgroundContext.drawPath(
            path,
            Paint()
              ..color = colorFromHex('#202020')
              ..strokeWidth = 1
              ..style = ui.PaintingStyle.stroke);
        textPainter.paint(backgroundContext, Offset(digitWidth * ((decimals + digits) - i - 1) + 4, -height * .1));
      } else {
        TextStyle stdFont = getFont(digitHeight, valueForeColor);
        var textSpan = TextSpan(
          text: num.toString(),
          style: stdFont,
        );

        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: digitWidth,
        );
        Path path = Path();
        Rect rect = Rect.fromLTWH(digitWidth * ((decimals + digits) - i - 1), 0, digitWidth, height);
        path.addRect(rect);
        path.close();
        backgroundContext.drawPath(
            path,
            Paint()
              ..color = valueBackColor
              ..style = ui.PaintingStyle.fill);
        path = Path();
        path.moveTo(digitWidth * ((decimals + digits) - i - 1), 0);
        path.lineTo(digitWidth * ((decimals + digits) - i - 1), height);
        backgroundContext.drawPath(
            path,
            Paint()
              ..color = colorFromHex('#f0f0f0')
              ..strokeWidth = 1
              ..style = ui.PaintingStyle.stroke);
        textPainter.paint(backgroundContext, Offset(digitWidth * ((decimals + digits) - i - 1) + 4, -height * .1));
      }
      pos++;
      prevNum = num;
    }
  }

  void repaint() {
    init();

    // draw digits
    drawDigits();

    var foregroundPicture = foregroundContextRecorder.endRecording();
    // draw the foreground
    backgroundContext.drawPicture(foregroundPicture);

    // // paint back to the main context
    var backgroundPicture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(backgroundPicture);
  }

  repaint();
}

double odometerWidth(double height, int digits, int decimals) {
  double digitWidth = (height * 0.68).floorToDouble();
  double width = digitWidth * (digits + decimals);
  return width;
}
